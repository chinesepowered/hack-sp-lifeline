import 'package:serverpod/serverpod.dart';

import '../common/codes.dart';
import '../generated/protocol.dart';

/// Authorization checks shared by the endpoints.
///
/// Family members are Serverpod auth users and must belong to the circle.
/// Companion screens have no account: they present a device token that was
/// issued at pairing time, of which only the SHA-256 hash is stored.
abstract final class CircleAccess {
  static String userIdentifier(Session session) {
    final auth = session.authenticated;
    if (auth == null) {
      throw LifelineException(
        message: 'Please sign in first.',
        code: LifelineErrorCode.notAMember,
      );
    }
    return auth.userIdentifier;
  }

  static Future<CircleMember> requireMember(
    Session session,
    int circleId,
  ) async {
    final userId = userIdentifier(session);
    final member = await CircleMember.db.findFirstRow(
      session,
      where: (t) =>
          t.circleId.equals(circleId) & t.userIdentifier.equals(userId),
    );
    if (member == null) {
      throw LifelineException(
        message: "You're not a member of this care circle.",
        code: LifelineErrorCode.notAMember,
      );
    }
    return member;
  }

  static Future<Circle> requireCircle(Session session, int circleId) async {
    final circle = await Circle.db.findById(session, circleId);
    if (circle == null) {
      throw LifelineException(
        message: 'This care circle no longer exists.',
        code: LifelineErrorCode.notFound,
      );
    }
    return circle;
  }

  static Future<CompanionDevice> requireDevice(
    Session session,
    String deviceToken,
  ) async {
    final device = await CompanionDevice.db.findFirstRow(
      session,
      where: (t) => t.tokenHash.equals(Codes.hashToken(deviceToken)),
    );
    if (device == null) {
      throw LifelineException(
        message: 'This screen is no longer paired. Please pair it again.',
        code: LifelineErrorCode.invalidDevice,
      );
    }
    return device;
  }
}
