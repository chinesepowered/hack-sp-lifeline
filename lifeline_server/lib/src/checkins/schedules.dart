import 'package:serverpod/serverpod.dart';

import '../common/local_time.dart';
import '../generated/future_calls.dart';
import '../generated/protocol.dart';
import 'local_scheduler.dart';

/// Lifeline's scheduling layer: daily check-ins, escalation, demo cleanup.
///
/// Wherever Serverpod future calls are enabled (local development, tests,
/// Serverpod Cloud Growth and up), every job is a future call: persisted in
/// the database, surviving restarts, claimed by exactly one server. Each
/// check-in time is a recurring cron future call, and escalation is a delayed
/// future call cancelled by identifier when the loved one answers.
///
/// Serverpod Cloud's Starter plan turns future calls off. There, the same
/// jobs run on [LocalScheduler] (in-process timers plus a database sweep).
/// Every job is idempotent, so both modes behave identically.
abstract final class Schedules {
  static String slotIdentifier(int slotId) => 'check-in-slot-$slotId';

  static String escalationIdentifier(int checkInId) =>
      'escalate-check-in-$checkInId';

  static String demoIdentifier(int circleId) => 'demo-cleanup-$circleId';

  /// Whether this server runs Serverpod future calls.
  static bool usesFutureCalls(Session session) =>
      session.serverpod.config.futureCall.enabled;

  static Future<void> scheduleSlot(
    Session session,
    Circle circle,
    CheckInSlot slot,
  ) async {
    if (!usesFutureCalls(session)) {
      LocalScheduler.instance?.armSlot(circle, slot);
      return;
    }
    await session.serverpod.futureCalls
        .callRecurring(identifier: slotIdentifier(slot.id!))
        .cron(LocalTime.dailyCron(slot.minuteOfDay, circle.utcOffsetMinutes))
        .checkIn
        .scheduledCheckIn(circle.id!, slot.id!);
  }

  static Future<void> cancelSlot(Session session, int slotId) async {
    if (!usesFutureCalls(session)) {
      LocalScheduler.instance?.cancelSlot(slotId);
      return;
    }
    await session.serverpod.futureCalls.cancel(slotIdentifier(slotId));
  }

  /// Runs escalation [stage] for a check-in after [delay], unless answered.
  static Future<void> escalateLater(
    Session session, {
    required int checkInId,
    required int stage,
    required Duration delay,
  }) async {
    if (!usesFutureCalls(session)) {
      LocalScheduler.instance?.escalateAfter(checkInId, stage, delay);
      return;
    }
    await session.serverpod.futureCalls
        .callWithDelay(delay, identifier: escalationIdentifier(checkInId))
        .escalation
        .noResponse(checkInId, stage);
  }

  static Future<void> cancelEscalation(Session session, int checkInId) async {
    if (!usesFutureCalls(session)) {
      LocalScheduler.instance?.cancelEscalation(checkInId);
      return;
    }
    await session.serverpod.futureCalls.cancel(
      escalationIdentifier(checkInId),
    );
  }

  /// Deletes a demo circle after [delay]. Without future calls, the
  /// scheduler's sweep removes expired demos instead.
  static Future<void> expireDemoLater(
    Session session,
    int circleId,
    Duration delay,
  ) async {
    if (!usesFutureCalls(session)) return;
    await session.serverpod.futureCalls
        .callWithDelay(delay, identifier: demoIdentifier(circleId))
        .demoCleanup
        .expire(circleId);
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
