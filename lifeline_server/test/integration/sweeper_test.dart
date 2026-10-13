import 'package:lifeline_server/src/checkins/local_scheduler.dart';
import 'package:lifeline_server/src/common/local_time.dart';
import 'package:lifeline_server/src/generated/protocol.dart';
import 'package:lifeline_server/src/voice/voice_catalog.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

/// The sweeper drives check-ins and escalation where Serverpod future calls
/// are disabled (Serverpod Cloud's Starter plan). It works purely from
/// database state, so these tests simulate the clock with `nowUtc`.
void main() {
  withServerpod('Given the fallback sweeper', (sessionBuilder, endpoints) {
    final sam = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        '3f2a6c1e-8b4d-4e9a-9c7f-1d2e3f4a5b6c',
        {},
      ),
    );
    late Session session;
    late CircleSnapshot created;

    setUp(() async {
      session = sessionBuilder.build();
      created = await endpoints.circle.createCircle(
        sam,
        CircleSettings(
          lovedOneName: 'Rose',
          voiceId: VoiceCatalog.defaultVoiceId,
          utcOffsetMinutes: 0,
          slotMinutes: [9 * 60],
          graceSeconds: 60,
          secondGraceSeconds: 60,
        ),
        'Sam',
        null,
      );
    });

    test('escalates an unanswered check-in in two stages, once', () async {
      final circleId = created.circle.id!;
      await endpoints.circle.checkInNow(sam, circleId);
      final checkIn = (await endpoints.circle.snapshot(
        sam,
        circleId,
      )).activeCheckIn!;
      final prompted = checkIn.promptedAt;

      await Sweeper.run(
        session,
        nowUtc: prompted.add(const Duration(seconds: 30)),
      );
      expect(
        (await CheckIn.db.findById(session, checkIn.id!))!.status,
        CheckInStatus.pending,
      );

      await Sweeper.run(
        session,
        nowUtc: prompted.add(const Duration(seconds: 65)),
      );
      await Sweeper.run(
        session,
        nowUtc: prompted.add(const Duration(seconds: 70)),
      );
      expect(
        (await CheckIn.db.findById(session, checkIn.id!))!.status,
        CheckInStatus.missed,
      );
      expect(
        await Alert.db.count(
          session,
          where: (t) => t.kind.equals(AlertKind.missedCheckIn),
        ),
        1,
      );

      await Sweeper.run(
        session,
        nowUtc: prompted.add(const Duration(seconds: 125)),
      );
      expect(
        (await CheckIn.db.findById(session, checkIn.id!))!.status,
        CheckInStatus.unresponsive,
      );
      final snapshot = await endpoints.circle.snapshot(sam, circleId);
      expect(snapshot.circle.status, CircleStatus.alert);
    });

    test('starts a scheduled check-in that a restart missed', () async {
      final circleId = created.circle.id!;
      final occurrence = LocalTime.latestOccurrence(9 * 60, 0);

      await Sweeper.run(
        session,
        nowUtc: occurrence.add(const Duration(minutes: 2)),
      );
      final checkIns = await CheckIn.db.find(
        session,
        where: (t) => t.circleId.equals(circleId),
      );
      expect(checkIns.single.kind, CheckInKind.scheduled);
      expect(checkIns.single.scheduledFor, occurrence);

      // Running again does not start a second one.
      await Sweeper.run(
        session,
        nowUtc: occurrence.add(const Duration(minutes: 3)),
      );
      expect(
        await CheckIn.db.count(
          session,
          where: (t) => t.circleId.equals(circleId),
        ),
        1,
      );
    });

    test('does not start check-ins long after their time', () async {
      final occurrence = LocalTime.latestOccurrence(9 * 60, 0);
      await Sweeper.run(
        session,
        nowUtc: occurrence.add(const Duration(minutes: 45)),
      );
      expect(await CheckIn.db.count(session), 0);
    });

    test('deletes expired demo circles', () async {
      final demo = await endpoints.circle.createDemo(sam, 'Sam', 0);
      await Sweeper.run(
        session,
        nowUtc: DateTime.now().toUtc().add(const Duration(hours: 13)),
      );
      expect(await Circle.db.findById(session, demo.circleId), isNull);
      expect(await Circle.db.findById(session, created.circle.id!), isNotNull);
    });
  });
}
