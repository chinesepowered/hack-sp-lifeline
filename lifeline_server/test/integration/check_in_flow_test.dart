import 'dart:convert';
import 'dart:typed_data';

import 'package:lifeline_server/src/generated/protocol.dart';
import 'package:lifeline_server/src/voice/eleven_labs.dart';
import 'package:lifeline_server/src/voice/voice_catalog.dart';
import 'package:lifeline_server/src/voice/voice_service.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

/// Stands in for ElevenLabs so tests are fast, free and deterministic.
class FakeVoiceEngine implements VoiceEngine {
  String nextTranscript = "I'm fine, thank you.";
  final spoken = <String>[];

  @override
  Future<Uint8List> synthesize({
    required String text,
    required String voiceId,
    required String modelId,
  }) async {
    spoken.add(text);
    return Uint8List.fromList(utf8.encode('fake mp3: $text'));
  }

  @override
  Future<String> transcribe({
    required Uint8List audio,
    required String mimeType,
  }) async => nextTranscript;
}

CircleSettings settings({int grace = 60}) => CircleSettings(
  lovedOneName: 'Rose',
  voiceId: VoiceCatalog.defaultVoiceId,
  utcOffsetMinutes: -240,
  slotMinutes: [9 * 60, 19 * 60],
  graceSeconds: grace,
  secondGraceSeconds: grace,
);

void main() {
  final voice = FakeVoiceEngine();
  setUpAll(() => VoiceService.engineOverride = voice);
  tearDownAll(() => VoiceService.engineOverride = null);

  withServerpod('Given a care circle with a paired companion screen', (
    sessionBuilder,
    endpoints,
  ) {
    const samId = '550e8400-e29b-41d4-a716-446655440000';
    const davidId = '6ba7b810-9dad-11d1-80b4-00c04fd430c8';
    final sam = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(samId, {}),
    );
    final david = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(davidId, {}),
    );

    late int circleId;
    late String pairingCode;
    late String deviceToken;

    setUp(() async {
      final created = await endpoints.circle.createCircle(
        sam,
        settings(),
        'Sam',
        'Daughter',
      );
      circleId = created.circle.id!;
      pairingCode = created.circle.pairingCode;
      final paired = await endpoints.companion.pair(
        sessionBuilder,
        pairingCode,
        'Kitchen tablet',
      );
      deviceToken = paired.deviceToken;
    });

    Future<CircleSnapshot> dashboard() =>
        endpoints.circle.snapshot(sam, circleId);
    Future<CompanionState> companion() =>
        endpoints.companion.watch(sessionBuilder, deviceToken).first;

    test('the circle starts quiet with schedule, code and device', () async {
      final snapshot = await dashboard();
      expect(snapshot.circle.status, CircleStatus.quiet);
      expect(snapshot.slots.map((s) => s.minuteOfDay), [540, 1140]);
      expect(snapshot.deviceCount, 1);
      expect(snapshot.nextCheckInAt, isNotNull);
      expect(snapshot.me.displayName, 'Sam');
    });

    test('pairing codes are single use', () async {
      await expectLater(
        endpoints.companion.pair(sessionBuilder, pairingCode, 'Another'),
        throwsA(
          isA<LifelineException>().having(
            (e) => e.code,
            'code',
            LifelineErrorCode.invalidCode,
          ),
        ),
      );
    });

    test('only members can see the circle; invite codes let family in', () async {
      await expectLater(
        endpoints.circle.snapshot(david, circleId),
        throwsA(isA<LifelineException>()),
      );
      final invite = (await dashboard()).circle.inviteCode;
      final joined = await endpoints.circle.joinCircle(
        david,
        invite,
        'David',
        'Son',
      );
      expect(joined.members.map((m) => m.displayName), ['Sam', 'David']);
      final circles = await endpoints.circle.myCircles(david);
      expect(circles.single.lovedOneName, 'Rose');
    });

    test('a check-in is spoken, answered with the button, and cleared', () async {
      await endpoints.circle.checkInNow(sam, circleId);

      var screen = await companion();
      expect(screen.activeCheckIn?.status, CheckInStatus.pending);
      final prompt = screen.utterances.last;
      expect(prompt.kind, UtteranceKind.prompt);
      expect(prompt.text, contains('Rose'));
      expect(prompt.audioPath, endsWith('.mp3'));
      expect((await dashboard()).circle.status, CircleStatus.awaiting);

      await endpoints.companion.imOkay(sessionBuilder, deviceToken);

      final snapshot = await dashboard();
      expect(snapshot.circle.status, CircleStatus.ok);
      expect(snapshot.activeCheckIn, isNull);
      expect(snapshot.recentCheckIns.first.status, CheckInStatus.ok);
      expect(snapshot.recentEvents.first.title, 'Rose is OK');
      screen = await companion();
      expect(screen.activeCheckIn, isNull);
      expect(screen.utterances.last.kind, UtteranceKind.reply);
    });

    test('an unanswered check-in escalates in two stages', () async {
      await endpoints.circle.checkInNow(sam, circleId);
      final checkInId = (await dashboard()).activeCheckIn!.id!;

      await endpoints.futureCalls.escalation.noResponse(
        sessionBuilder,
        checkInId,
        1,
      );
      var snapshot = await dashboard();
      expect(snapshot.circle.status, CircleStatus.missed);
      expect(snapshot.openAlerts.single.kind, AlertKind.missedCheckIn);
      expect(
        (await companion()).utterances.last.kind,
        UtteranceKind.reprompt,
      );

      // Future calls run at least once: a repeated stage is a no-op.
      await endpoints.futureCalls.escalation.noResponse(
        sessionBuilder,
        checkInId,
        1,
      );
      expect((await dashboard()).openAlerts, hasLength(1));

      await endpoints.futureCalls.escalation.noResponse(
        sessionBuilder,
        checkInId,
        2,
      );
      snapshot = await dashboard();
      expect(snapshot.circle.status, CircleStatus.alert);
      expect(snapshot.openAlerts.first.level, AlertLevel.urgent);
      expect(snapshot.openAlerts.first.kind, AlertKind.unresponsive);

      // A late answer clears the "missed" and "not responding" alerts.
      await endpoints.companion.imOkay(sessionBuilder, deviceToken);
      snapshot = await dashboard();
      expect(snapshot.openAlerts, isEmpty);
      expect(snapshot.circle.status, CircleStatus.ok);
    });

    test('escalation does nothing once the check-in was answered', () async {
      await endpoints.circle.checkInNow(sam, circleId);
      final checkInId = (await dashboard()).activeCheckIn!.id!;
      await endpoints.companion.imOkay(sessionBuilder, deviceToken);

      await endpoints.futureCalls.escalation.noResponse(
        sessionBuilder,
        checkInId,
        1,
      );
      final snapshot = await dashboard();
      expect(snapshot.openAlerts, isEmpty);
      expect(snapshot.circle.status, CircleStatus.ok);
    });

    test('a spoken "I have fallen" raises an urgent alert the family can '
        'acknowledge and resolve', () async {
      await endpoints.circle.checkInNow(sam, circleId);
      voice.nextTranscript = "I've fallen and I can't get up.";

      final result = await endpoints.companion.answerByVoice(
        sessionBuilder,
        deviceToken,
        ByteData(1200),
        'audio/webm',
      );
      expect(result.triageLevel, TriageLevel.urgent);
      expect(result.reasons, contains('Possible fall'));

      var snapshot = await dashboard();
      expect(snapshot.circle.status, CircleStatus.alert);
      final alert = snapshot.openAlerts.single;
      expect(alert.kind, AlertKind.helpRequested);
      expect((await companion()).helpActive, isTrue);

      await endpoints.circle.acknowledgeAlert(sam, circleId, alert.id!);
      final screen = await companion();
      expect(screen.helpAcknowledgedBy, 'Sam');
      expect(screen.utterances.last.text, contains('Sam has seen your alert'));

      await endpoints.circle.resolveAlert(sam, circleId, alert.id!);
      snapshot = await dashboard();
      expect(snapshot.openAlerts, isEmpty);
      expect(snapshot.circle.status, CircleStatus.ok);
    });

    test('a spoken ache becomes a concern, not an emergency', () async {
      await endpoints.circle.checkInNow(sam, circleId);
      voice.nextTranscript = 'My hip is quite sore this morning.';
      await endpoints.companion.answerByVoice(
        sessionBuilder,
        deviceToken,
        ByteData(1200),
        'audio/webm',
      );
      final snapshot = await dashboard();
      expect(snapshot.circle.status, CircleStatus.concern);
      expect(snapshot.openAlerts.single.level, AlertLevel.warning);
      expect(snapshot.recentCheckIns.first.transcript, contains('hip'));
    });

    test('family messages are spoken on the companion screen', () async {
      await endpoints.circle.sendMessage(
        sam,
        circleId,
        "Hi Mum, I'll pop round at four. Love you!",
      );
      final screen = await companion();
      final message = screen.latestMessage!;
      expect(message.fromName, 'Sam');
      expect(message.audioPath, isNotNull);
      expect(voice.spoken.last, startsWith('Here is a message from Sam.'));
    });

    test('the scheduled future call starts one check-in per occurrence', () async {
      final slotId = (await dashboard()).slots.first.id!;
      await endpoints.futureCalls.checkIn.scheduledCheckIn(
        sessionBuilder,
        circleId,
        slotId,
      );
      await endpoints.futureCalls.checkIn.scheduledCheckIn(
        sessionBuilder,
        circleId,
        slotId,
      );
      final checkIns = (await dashboard()).recentCheckIns;
      expect(checkIns, hasLength(1));
      expect(checkIns.single.kind, CheckInKind.scheduled);
    });

    test('settings can be updated', () async {
      final updated = await endpoints.circle.updateSettings(
        sam,
        circleId,
        settings(grace: 300)..slotMinutes = [8 * 60],
      );
      expect(updated.slots.single.minuteOfDay, 480);
      expect(updated.circle.graceSeconds, 300);
    });
  });

  withServerpod('Given the live demo', (sessionBuilder, endpoints) {
    final judge = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        '7c9e6679-7425-40de-944b-e07fc1f90ae7',
        {},
      ),
    );

    test('a demo circle comes with a paired screen and a week of history, '
        'and cleans itself up', () async {
      final demo = await endpoints.circle.createDemo(judge, 'Sam', 60);
      final snapshot = await endpoints.circle.snapshot(judge, demo.circleId);
      expect(snapshot.circle.isDemo, isTrue);
      expect(snapshot.deviceCount, 1);
      expect(snapshot.recentCheckIns, hasLength(12));
      expect(snapshot.circle.status, CircleStatus.ok);

      final screen = await endpoints.companion
          .watch(sessionBuilder, demo.deviceToken)
          .first;
      expect(screen.lovedOneName, 'Rose');

      await endpoints.futureCalls.demoCleanup.expire(
        sessionBuilder,
        demo.circleId,
      );
      expect(await endpoints.circle.myCircles(judge), isEmpty);
    });
  });
}
