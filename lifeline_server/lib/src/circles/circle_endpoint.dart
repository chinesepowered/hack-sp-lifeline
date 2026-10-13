import 'package:serverpod/serverpod.dart';

import '../checkins/check_in_service.dart';
import '../checkins/phrases.dart';
import '../generated/protocol.dart';
import '../realtime/circle_channel.dart';
import '../voice/voice_catalog.dart';
import '../voice/voice_service.dart';
import 'circle_access.dart';
import 'circle_service.dart';
import 'snapshots.dart';

/// Everything the family app does. Requires a signed-in Serverpod user, and
/// every method checks that the user belongs to the circle.
class CircleEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Voices the family can choose for the companion.
  Future<List<VoiceOption>> voices(Session session) async =>
      VoiceCatalog.voices;

  /// A short sample of [voiceId] saying [lovedOneName], for the voice picker.
  /// Returns an absolute URL, or null when speech is unavailable.
  Future<String?> previewVoice(
    Session session,
    String voiceId,
    String lovedOneName,
  ) async {
    final voice = VoiceCatalog.voices.where((v) => v.voiceId == voiceId);
    if (voice.isEmpty) return null;
    final name = lovedOneName.trim().isEmpty ? 'there' : lovedOneName.trim();
    final clip = await VoiceService.speak(
      session,
      text: Phrases.voicePreview(voice.first.name, name),
      voiceId: voiceId,
    );
    return clip == null ? null : '${Snapshots.voiceBaseUrl(session)}$clip';
  }

  Future<List<CircleSummary>> myCircles(Session session) async {
    final userId = CircleAccess.userIdentifier(session);
    final memberships = await CircleMember.db.find(
      session,
      where: (t) => t.userIdentifier.equals(userId),
      orderBy: (t) => t.joinedAt.desc(),
    );
    if (memberships.isEmpty) return [];
    final circles = {
      for (final circle in await Circle.db.find(
        session,
        where: (t) => t.id.inSet(memberships.map((m) => m.circleId).toSet()),
      ))
        circle.id!: circle,
    };
    return [
      for (final m in memberships)
        if (circles[m.circleId] case final circle?)
          CircleSummary(
            circleId: m.circleId,
            lovedOneName: circle.lovedOneName,
            status: circle.status,
            myRole: m.role,
            isDemo: circle.isDemo,
          ),
    ];
  }

  Future<CircleSnapshot> createCircle(
    Session session,
    CircleSettings settings,
    String myName,
    String? relationship,
  ) async {
    final circle = await CircleService.create(
      session,
      settings,
      userIdentifier: CircleAccess.userIdentifier(session),
      myName: myName,
      relationship: relationship,
    );
    return snapshot(session, circle.id!);
  }

  Future<CircleSnapshot> joinCircle(
    Session session,
    String inviteCode,
    String myName,
    String? relationship,
  ) async {
    final circle = await CircleService.join(
      session,
      inviteCode,
      userIdentifier: CircleAccess.userIdentifier(session),
      myName: myName,
      relationship: relationship,
    );
    return snapshot(session, circle.id!);
  }

  /// Creates a sandbox circle with a paired virtual companion screen.
  Future<DemoSetup> createDemo(
    Session session,
    String myName,
    int utcOffsetMinutes,
  ) => CircleService.createDemo(
    session,
    userIdentifier: CircleAccess.userIdentifier(session),
    myName: myName,
    utcOffsetMinutes: utcOffsetMinutes,
  );

  Future<CircleSnapshot> snapshot(Session session, int circleId) async {
    final me = await CircleAccess.requireMember(session, circleId);
    return Snapshots.forMember(session, me);
  }

  /// Live dashboard: a fresh snapshot whenever anything in the circle
  /// changes, pushed over Serverpod's managed WebSocket.
  Stream<CircleSnapshot> watch(Session session, int circleId) async* {
    final me = await CircleAccess.requireMember(session, circleId);
    yield await Snapshots.forMember(session, me);
    await for (final _ in CircleChannel.changes(session, circleId)) {
      yield await Snapshots.forMember(session, me);
    }
  }

  /// Starts a check-in right now, outside the daily schedule.
  Future<void> checkInNow(Session session, int circleId) async {
    final me = await CircleAccess.requireMember(session, circleId);
    final circle = await CircleAccess.requireCircle(session, circleId);
    await CheckInService.start(
      session,
      circle,
      kind: CheckInKind.onDemand,
      requestedBy: me.displayName,
    );
  }

  /// Sends a typed message that is spoken aloud on the companion screen.
  Future<void> sendMessage(Session session, int circleId, String text) async {
    final me = await CircleAccess.requireMember(session, circleId);
    await CheckInService.sendMessage(session, me, text);
  }

  /// "I'm on it": tells the family and the loved one that someone is
  /// handling the alert.
  Future<void> acknowledgeAlert(
    Session session,
    int circleId,
    int alertId,
  ) async {
    final me = await CircleAccess.requireMember(session, circleId);
    await CheckInService.acknowledge(session, me, alertId);
  }

  Future<void> resolveAlert(Session session, int circleId, int alertId) async {
    final me = await CircleAccess.requireMember(session, circleId);
    await CheckInService.resolve(session, me, alertId);
  }

  Future<CircleSnapshot> updateSettings(
    Session session,
    int circleId,
    CircleSettings settings,
  ) async {
    final me = await CircleAccess.requireMember(session, circleId);
    await CircleService.updateSettings(session, me, settings);
    return Snapshots.forMember(session, me);
  }

  /// Issues a fresh one-time code for pairing another tablet.
  Future<String> newPairingCode(Session session, int circleId) async {
    final me = await CircleAccess.requireMember(session, circleId);
    return CircleService.newPairingCode(session, me);
  }
}
