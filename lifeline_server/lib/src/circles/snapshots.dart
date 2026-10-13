import 'package:serverpod/serverpod.dart';

import '../checkins/check_in_service.dart';
import '../checkins/schedules.dart';
import '../generated/protocol.dart';
import 'circle_access.dart';

/// Builds the complete state pushed to dashboards and companion screens.
///
/// Streams send whole snapshots rather than diffs: the payload is small, a
/// reconnecting client is instantly up to date, and there is no client-side
/// merge logic to get wrong.
abstract final class Snapshots {
  static Future<CircleSnapshot> forMember(
    Session session,
    CircleMember me,
  ) async {
    final circleId = me.circleId;
    final now = DateTime.now().toUtc();
    final circle = await CircleAccess.requireCircle(session, circleId);

    final members = await CircleMember.db.find(
      session,
      where: (t) => t.circleId.equals(circleId),
      orderBy: (t) => t.joinedAt,
    );
    final slots = await CheckInSlot.db.find(
      session,
      where: (t) => t.circleId.equals(circleId),
      orderBy: (t) => t.minuteOfDay,
    );
    final recentCheckIns = await CheckIn.db.find(
      session,
      where: (t) =>
          t.circleId.equals(circleId) &
          (t.promptedAt > now.subtract(const Duration(days: 7))),
      orderBy: (t) => t.promptedAt.desc(),
      limit: 60,
    );
    final openAlerts = await Alert.db.find(
      session,
      where: (t) => t.circleId.equals(circleId) & t.resolvedAt.equals(null),
      orderBy: (t) => t.createdAt.desc(),
    );
    final events = await CircleEvent.db.find(
      session,
      where: (t) => t.circleId.equals(circleId),
      orderBy: (t) => t.createdAt.desc(),
      limit: 40,
    );
    final messages = await Utterance.db.find(
      session,
      where: (t) =>
          t.circleId.equals(circleId) &
          t.kind.equals(UtteranceKind.familyMessage),
      orderBy: (t) => t.createdAt.desc(),
      limit: 10,
    );
    final devices = await CompanionDevice.db.find(
      session,
      where: (t) => t.circleId.equals(circleId),
    );

    DateTime? lastSeen;
    for (final device in devices) {
      final seen = device.lastSeenAt;
      if (seen != null && (lastSeen == null || seen.isAfter(lastSeen))) {
        lastSeen = seen;
      }
    }

    final latest = recentCheckIns.firstOrNull;
    return CircleSnapshot(
      circle: circle,
      me: me,
      members: members,
      slots: slots,
      activeCheckIn: latest != null && _isActive(latest) ? latest : null,
      recentCheckIns: recentCheckIns,
      openAlerts: openAlerts,
      recentEvents: events,
      recentMessages: messages,
      deviceCount: devices.length,
      companionLastSeenAt: lastSeen,
      nextCheckInAt: Schedules.nextCheckInAt(circle, slots, nowUtc: now),
      serverTime: now,
      voiceBaseUrl: voiceBaseUrl(session),
    );
  }

  static Future<CompanionState> forDevice(
    Session session,
    CompanionDevice device,
  ) async {
    final circleId = device.circleId;
    final now = DateTime.now().toUtc();
    final circle = await CircleAccess.requireCircle(session, circleId);

    final active = await CheckInService.activeCheckIn(session, circleId);
    final recent = await Utterance.db.find(
      session,
      where: (t) =>
          t.circleId.equals(circleId) &
          (t.createdAt > now.subtract(const Duration(minutes: 30))),
      orderBy: (t) => t.createdAt.desc(),
      limit: 30,
    );
    final latestMessage = await Utterance.db.findFirstRow(
      session,
      where: (t) =>
          t.circleId.equals(circleId) &
          t.kind.equals(UtteranceKind.familyMessage) &
          (t.createdAt > now.subtract(const Duration(days: 3))),
      orderBy: (t) => t.createdAt.desc(),
    );
    final urgent = await Alert.db.find(
      session,
      where: (t) =>
          t.circleId.equals(circleId) &
          t.resolvedAt.equals(null) &
          t.level.equals(AlertLevel.urgent),
      orderBy: (t) => t.createdAt.desc(),
    );
    final members = await CircleMember.db.find(
      session,
      where: (t) => t.circleId.equals(circleId),
      orderBy: (t) => t.joinedAt,
    );
    final slots = await CheckInSlot.db.find(
      session,
      where: (t) => t.circleId.equals(circleId),
    );

    String? acknowledgedBy;
    for (final alert in urgent) {
      acknowledgedBy ??= alert.acknowledgedByName;
    }

    return CompanionState(
      circleId: circleId,
      lovedOneName: circle.lovedOneName,
      status: circle.status,
      activeCheckIn: active,
      utterances: recent.reversed.toList(),
      latestMessage: latestMessage,
      helpActive: urgent.isNotEmpty,
      helpAcknowledgedBy: acknowledgedBy,
      caregiverNames: members.map((m) => m.displayName).toList(),
      nextCheckInAt: Schedules.nextCheckInAt(circle, slots, nowUtc: now),
      utcOffsetMinutes: circle.utcOffsetMinutes,
      serverTime: now,
      voiceBaseUrl: voiceBaseUrl(session),
    );
  }

  /// Absolute base URL of the `/voice/` route on the web server.
  static String voiceBaseUrl(Session session) {
    final web = session.serverpod.config.webServer;
    if (web == null) return '/voice/';
    final isDefaultPort =
        (web.publicScheme == 'https' && web.publicPort == 443) ||
        (web.publicScheme == 'http' && web.publicPort == 80);
    return Uri(
      scheme: web.publicScheme,
      host: web.publicHost,
      port: isDefaultPort ? null : web.publicPort,
      path: '/voice/',
    ).toString();
  }

  static bool _isActive(CheckIn checkIn) =>
      checkIn.status == CheckInStatus.pending ||
      checkIn.status == CheckInStatus.missed ||
      checkIn.status == CheckInStatus.unresponsive;
}
