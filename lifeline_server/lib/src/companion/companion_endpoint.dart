import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../checkins/check_in_service.dart';
import '../circles/circle_access.dart';
import '../circles/circle_service.dart';
import '../circles/snapshots.dart';
import '../generated/protocol.dart';
import '../realtime/circle_channel.dart';
import '../triage/triage.dart';
import '../voice/voice_service.dart';

/// The loved one's companion screen. It has no user account: it is paired
/// once with a code from the family app and then authenticates every call
/// with its device token.
class CompanionEndpoint extends Endpoint {
  static const _maxAudioBytes = 1024 * 1024;

  Future<PairingResult> pair(
    Session session,
    String pairingCode,
    String label,
  ) => CircleService.pair(session, pairingCode, label);

  /// Live state of the companion screen, including lines to speak.
  Stream<CompanionState> watch(Session session, String deviceToken) async* {
    var device = await CircleAccess.requireDevice(session, deviceToken);
    device = await _touch(session, device);
    yield await Snapshots.forDevice(session, device);

    var lastTouch = DateTime.now();
    await for (final _ in CircleChannel.changes(session, device.circleId)) {
      if (DateTime.now().difference(lastTouch).inSeconds >= 30) {
        device = await _touch(session, device);
        lastTouch = DateTime.now();
      }
      yield await Snapshots.forDevice(session, device);
    }
  }

  /// The big green button.
  Future<void> imOkay(Session session, String deviceToken) async {
    final circle = await _circleFor(session, deviceToken);
    await CheckInService.respond(
      session,
      circle,
      method: ResponseMethod.button,
      level: TriageLevel.ok,
      reasons: ['Pressed "I\'m okay"'],
    );
  }

  /// The big red button.
  Future<void> needHelp(Session session, String deviceToken) async {
    final circle = await _circleFor(session, deviceToken);
    await CheckInService.respond(
      session,
      circle,
      method: ResponseMethod.button,
      level: TriageLevel.urgent,
      reasons: ['Pressed the help button'],
    );
  }

  /// A spoken answer: transcribed by ElevenLabs Scribe, then triaged.
  Future<VoiceReplyResult> answerByVoice(
    Session session,
    String deviceToken,
    ByteData audio,
    String mimeType,
  ) async {
    final circle = await _circleFor(session, deviceToken);
    if (audio.lengthInBytes == 0 || audio.lengthInBytes > _maxAudioBytes) {
      throw LifelineException(
        message: 'That recording was too long. Please try a shorter answer.',
        code: LifelineErrorCode.invalidInput,
      );
    }

    final transcript = await VoiceService.transcribe(
      session,
      audio: audio,
      mimeType: mimeType,
    );
    if (transcript.isEmpty) {
      await CheckInService.didNotCatch(session, circle);
      return VoiceReplyResult(
        transcript: '',
        triageLevel: TriageLevel.ok,
        reasons: const [],
      );
    }

    final triage = TriageEngine.evaluate(transcript);
    await CheckInService.respond(
      session,
      circle,
      method: ResponseMethod.voice,
      level: triage.level,
      reasons: triage.reasons,
      transcript: transcript,
    );
    return VoiceReplyResult(
      transcript: transcript,
      triageLevel: triage.level,
      reasons: triage.reasons,
    );
  }

  Future<Circle> _circleFor(Session session, String deviceToken) async {
    final device = await CircleAccess.requireDevice(session, deviceToken);
    await _touch(session, device);
    return CircleAccess.requireCircle(session, device.circleId);
  }

  static Future<CompanionDevice> _touch(
    Session session,
    CompanionDevice device,
  ) async {
    final now = DateTime.now().toUtc();
    final wasOffline =
        device.lastSeenAt == null ||
        now.difference(device.lastSeenAt!).inMinutes >= 2;
    final updated = await CompanionDevice.db.updateRow(
      session,
      device.copyWith(lastSeenAt: now),
    );
    if (wasOffline) {
      await CircleChannel.notify(session, device.circleId, 'device-online');
    }
    return updated;
  }
}
