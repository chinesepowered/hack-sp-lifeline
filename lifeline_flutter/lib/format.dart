/// Human-friendly times. Everything is shown in the viewer's local time.
abstract final class Fmt {
  static const _weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  static const _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  /// "9:05 AM"
  static String time(DateTime t) {
    final local = t.toLocal();
    final hour = local.hour % 12 == 0 ? 12 : local.hour % 12;
    final minute = local.minute.toString().padLeft(2, '0');
    return '$hour:$minute ${local.hour < 12 ? 'AM' : 'PM'}';
  }

  /// "Tuesday, October 13"
  static String longDate(DateTime t) {
    final local = t.toLocal();
    return '${_weekdays[local.weekday - 1]}, ${_months[local.month - 1]} '
        '${local.day}';
  }

  /// "Tue"
  static String shortWeekday(DateTime t) =>
      _weekdays[t.toLocal().weekday - 1].substring(0, 3);

  /// "just now", "5 min ago", "2 h ago", "Yesterday 7:01 PM", "Oct 9"
  static String ago(DateTime t, DateTime now) {
    final diff = now.difference(t);
    if (diff.inSeconds < 45) return 'just now';
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes < 1 ? 1 : diff.inMinutes} min ago';
    }
    final local = t.toLocal();
    final today = now.toLocal();
    final sameDay =
        local.year == today.year &&
        local.month == today.month &&
        local.day == today.day;
    if (sameDay) return time(t);
    final yesterday = today.subtract(const Duration(days: 1));
    if (local.year == yesterday.year &&
        local.month == yesterday.month &&
        local.day == yesterday.day) {
      return 'Yesterday ${time(t)}';
    }
    return '${_months[local.month - 1].substring(0, 3)} ${local.day}, '
        '${time(t)}';
  }

  /// "0:42" or "12:05" for a countdown.
  static String countdown(Duration d) {
    if (d.isNegative) return '0:00';
    final minutes = d.inMinutes;
    final seconds = d.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  /// "20 seconds", "15 minutes", "1 hour"
  static String duration(int seconds) {
    if (seconds < 60) return '$seconds seconds';
    final minutes = seconds ~/ 60;
    if (minutes < 60) return minutes == 1 ? '1 minute' : '$minutes minutes';
    final hours = minutes ~/ 60;
    return hours == 1 ? '1 hour' : '$hours hours';
  }

  /// "9:00 AM" for minutes after midnight.
  static String minuteOfDay(int minutes) {
    final hour = minutes ~/ 60;
    final minute = (minutes % 60).toString().padLeft(2, '0');
    final hour12 = hour % 12 == 0 ? 12 : hour % 12;
    return '$hour12:$minute ${hour < 12 ? 'AM' : 'PM'}';
  }
}
