/// Helpers for working in the loved one's local time.
///
/// A circle stores a fixed UTC offset (captured from the family member's
/// device when the circle is set up). Check-in slots are minutes after local
/// midnight, and are converted to UTC for scheduling.
abstract final class LocalTime {
  static const minutesPerDay = 24 * 60;

  /// The current wall-clock time for a circle with [utcOffsetMinutes].
  static DateTime nowLocal(int utcOffsetMinutes, {DateTime? nowUtc}) =>
      (nowUtc ?? DateTime.now().toUtc()).add(
        Duration(minutes: utcOffsetMinutes),
      );

  /// The minute of the UTC day a local [minuteOfDay] maps to.
  static int utcMinuteOfDay(int minuteOfDay, int utcOffsetMinutes) =>
      (minuteOfDay - utcOffsetMinutes) % minutesPerDay;

  /// A cron expression (UTC, as Serverpod's scheduler expects) that fires
  /// every day at the local [minuteOfDay].
  static String dailyCron(int minuteOfDay, int utcOffsetMinutes) {
    final utcMinute = utcMinuteOfDay(minuteOfDay, utcOffsetMinutes);
    return '${utcMinute % 60} ${utcMinute ~/ 60} * * *';
  }

  /// The most recent UTC instant at or before [nowUtc] that matches the
  /// local [minuteOfDay]. Used to give a scheduled check-in a stable
  /// occurrence time, which makes duplicate future-call runs detectable.
  static DateTime latestOccurrence(
    int minuteOfDay,
    int utcOffsetMinutes, {
    DateTime? nowUtc,
  }) {
    final now = (nowUtc ?? DateTime.now().toUtc());
    final utcMinute = utcMinuteOfDay(minuteOfDay, utcOffsetMinutes);
    var candidate = DateTime.utc(
      now.year,
      now.month,
      now.day,
    ).add(Duration(minutes: utcMinute));
    if (candidate.isAfter(now)) {
      candidate = candidate.subtract(const Duration(days: 1));
    }
    return candidate;
  }

  /// The next UTC instant after [nowUtc] matching the local [minuteOfDay].
  static DateTime nextOccurrence(
    int minuteOfDay,
    int utcOffsetMinutes, {
    DateTime? nowUtc,
  }) =>
      latestOccurrence(
        minuteOfDay,
        utcOffsetMinutes,
        nowUtc: nowUtc,
      ).add(const Duration(days: 1));

  /// "Good morning", "Good afternoon" or "Good evening" for a local hour.
  static String greeting(int localHour) {
    if (localHour >= 4 && localHour < 12) return 'Good morning';
    if (localHour >= 12 && localHour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  /// A time phrase that reads naturally when spoken, e.g. "nine o'clock"
  /// style "9 o'clock" or "9:30".
  static String spokenTime(DateTime local) {
    final hour12 = local.hour % 12 == 0 ? 12 : local.hour % 12;
    if (local.minute == 0) return "$hour12 o'clock";
    return '$hour12:${local.minute.toString().padLeft(2, '0')}';
  }

  /// A short label such as "9:00 AM" for a local [minuteOfDay].
  static String label(int minuteOfDay) {
    final hour = minuteOfDay ~/ 60;
    final minute = minuteOfDay % 60;
    final hour12 = hour % 12 == 0 ? 12 : hour % 12;
    final suffix = hour < 12 ? 'AM' : 'PM';
    return '$hour12:${minute.toString().padLeft(2, '0')} $suffix';
  }
}
