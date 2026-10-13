import 'dart:async';
import 'dart:io';

import 'package:serverpod/serverpod.dart';

import '../circles/circle_service.dart';
import '../common/local_time.dart';
import '../generated/protocol.dart';
import 'check_in_service.dart';

/// In-process scheduling for servers where Serverpod future calls are
/// disabled (Serverpod Cloud's Starter plan runs a single podlet).
///
/// Timers give second-level precision; a [Sweeper] pass every minute rebuilds
/// anything a restart lost, straight from the database.
class LocalScheduler {
  LocalScheduler._(this._pod);

  static LocalScheduler? instance;

  final Serverpod _pod;
  final _escalations = <int, Timer>{};
  final _slots = <int, Timer>{};
  Timer? _sweep;

  static Future<void> start(Serverpod pod) async {
    final scheduler = instance = LocalScheduler._(pod);
    await scheduler._run((session) => Sweeper.run(session, armTimers: true));
    scheduler._sweep = Timer.periodic(
      const Duration(minutes: 1),
      (_) => scheduler._run(Sweeper.run),
    );
  }

  void escalateAfter(int checkInId, int stage, Duration delay) {
    _escalations.remove(checkInId)?.cancel();
    _escalations[checkInId] = Timer(delay, () {
      _escalations.remove(checkInId);
      _run((session) => CheckInService.escalate(session, checkInId, stage));
    });
  }

  void cancelEscalation(int checkInId) =>
      _escalations.remove(checkInId)?.cancel();

  void armSlot(Circle circle, CheckInSlot slot) {
    final slotId = slot.id!;
    _slots.remove(slotId)?.cancel();
    final next = LocalTime.nextOccurrence(
      slot.minuteOfDay,
      circle.utcOffsetMinutes,
    );
    _slots[slotId] = Timer(next.difference(DateTime.now().toUtc()), () {
      _slots.remove(slotId);
      _run((session) async {
        await CheckInService.startScheduled(session, circle.id!, slotId);
        // Re-arm for tomorrow from fresh data (settings may have changed).
        final freshSlot = await CheckInSlot.db.findById(session, slotId);
        final freshCircle = await Circle.db.findById(session, circle.id!);
        if (freshSlot != null && freshCircle != null) {
          armSlot(freshCircle, freshSlot);
        }
      });
    });
  }

  void cancelSlot(int slotId) => _slots.remove(slotId)?.cancel();

  Future<void> stop() async {
    _sweep?.cancel();
    for (final timer in [..._escalations.values, ..._slots.values]) {
      timer.cancel();
    }
    _escalations.clear();
    _slots.clear();
  }

  Future<void> _run(Future<void> Function(Session session) work) async {
    try {
      await _pod.withSession(work);
    } catch (e, stackTrace) {
      stderr.writeln('LocalScheduler job failed: $e\n$stackTrace');
    }
  }
}

/// Finds background work that is due, using only what is in the database.
///
/// Safe to run any number of times, on any number of servers: escalation
/// re-checks state under a row lock, and scheduled check-ins are unique per
/// occurrence.
abstract final class Sweeper {
  /// How late a scheduled check-in may still be started (e.g. after a
  /// restart during its minute).
  static const catchUpWindow = Duration(minutes: 10);

  static const _slack = Duration(seconds: 3);

  static Future<void> run(
    Session session, {
    bool armTimers = false,
    DateTime? nowUtc,
  }) async {
    final now = nowUtc ?? DateTime.now().toUtc();
    await _escalations(session, now, armTimers);
    await _scheduledCheckIns(session, now, armTimers);
    await _expiredDemos(session, now);
  }

  static Future<void> _escalations(
    Session session,
    DateTime now,
    bool armTimers,
  ) async {
    final open = await CheckIn.db.find(
      session,
      where: (t) =>
          t.status.inSet({CheckInStatus.pending, CheckInStatus.missed}),
    );
    if (open.isEmpty) return;
    final circles = await _circles(session, open.map((c) => c.circleId));
    for (final checkIn in open) {
      final circle = circles[checkIn.circleId];
      if (circle == null) continue;
      final stageOne = checkIn.promptedAt.add(
        Duration(seconds: circle.graceSeconds),
      );
      final stageTwo = stageOne.add(
        Duration(seconds: circle.secondGraceSeconds),
      );
      final (stage, dueAt) = checkIn.status == CheckInStatus.pending
          ? (1, stageOne)
          : (2, stageTwo);
      if (now.isAfter(dueAt.add(_slack))) {
        await CheckInService.escalate(session, checkIn.id!, stage);
      } else if (armTimers) {
        LocalScheduler.instance?.escalateAfter(
          checkIn.id!,
          stage,
          dueAt.difference(now),
        );
      }
    }
  }

  static Future<void> _scheduledCheckIns(
    Session session,
    DateTime now,
    bool armTimers,
  ) async {
    final slots = await CheckInSlot.db.find(session);
    if (slots.isEmpty) return;
    final circles = await _circles(session, slots.map((s) => s.circleId));
    for (final slot in slots) {
      final circle = circles[slot.circleId];
      if (circle == null) continue;
      final occurrence = LocalTime.latestOccurrence(
        slot.minuteOfDay,
        circle.utcOffsetMinutes,
        nowUtc: now,
      );
      final late = now.difference(occurrence);
      if (late > _slack && late < catchUpWindow) {
        final exists = await CheckIn.db.count(
          session,
          where: (t) =>
              t.circleId.equals(circle.id) & t.scheduledFor.equals(occurrence),
        );
        if (exists == 0) {
          await CheckInService.startScheduled(session, circle.id!, slot.id!);
        }
      }
      if (armTimers) LocalScheduler.instance?.armSlot(circle, slot);
    }
  }

  static Future<void> _expiredDemos(Session session, DateTime now) async {
    final expired = await Circle.db.find(
      session,
      where: (t) =>
          t.isDemo.equals(true) &
          (t.createdAt < now.subtract(CircleService.demoLifetime)),
    );
    for (final circle in expired) {
      await CircleService.expireDemo(session, circle.id!);
    }
  }

  static Future<Map<int, Circle>> _circles(
    Session session,
    Iterable<int> ids,
  ) async => {
    for (final circle in await Circle.db.find(
      session,
      where: (t) => t.id.inSet(ids.toSet()),
    ))
      circle.id!: circle,
  };
}
