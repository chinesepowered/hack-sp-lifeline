import 'package:serverpod/serverpod.dart';

import '../common/local_time.dart';
import '../generated/future_calls.dart';
import '../generated/protocol.dart';

/// Daily check-in times, backed by recurring Serverpod future calls.
///
/// Each [CheckInSlot] gets its own recurring call with a cron expression in
/// UTC. Future calls live in the database, so the schedule survives restarts
/// and deploys, and only one server instance runs each occurrence.
abstract final class Schedules {
  static String identifier(int slotId) => 'check-in-slot-$slotId';

  static Future<void> scheduleSlot(
    Session session,
    Circle circle,
    CheckInSlot slot,
  ) async {
    await session.serverpod.futureCalls
        .callRecurring(identifier: identifier(slot.id!))
        .cron(LocalTime.dailyCron(slot.minuteOfDay, circle.utcOffsetMinutes))
        .checkIn
        .scheduledCheckIn(circle.id!, slot.id!);
  }

  static Future<void> cancelSlot(Session session, int slotId) async {
    await session.serverpod.futureCalls.cancel(identifier(slotId));
  }

  /// When the next scheduled check-in will happen, in UTC.
  static DateTime? nextCheckInAt(
    Circle circle,
    List<CheckInSlot> slots, {
    DateTime? nowUtc,
  }) {
    DateTime? next;
    for (final slot in slots) {
      final at = LocalTime.nextOccurrence(
        slot.minuteOfDay,
        circle.utcOffsetMinutes,
        nowUtc: nowUtc,
      );
      if (next == null || at.isBefore(next)) next = at;
    }
    return next;
  }

  /// "Morning", "Afternoon" or "Evening" for a local [minuteOfDay].
  static String labelFor(int minuteOfDay) {
    final hour = minuteOfDay ~/ 60;
    if (hour >= 4 && hour < 12) return 'Morning';
    if (hour >= 12 && hour < 17) return 'Afternoon';
    return 'Evening';
  }
}
