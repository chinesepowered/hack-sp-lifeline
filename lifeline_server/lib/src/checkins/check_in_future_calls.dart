import 'package:serverpod/serverpod.dart';

import '../circles/circle_service.dart';
import 'check_in_service.dart';

/// Fired by the recurring (cron) schedule of each check-in slot.
class CheckInFutureCall extends FutureCall {
  Future<void> scheduledCheckIn(Session session, int circleId, int slotId) =>
      CheckInService.startScheduled(session, circleId, slotId);
}

/// Fired when a check-in has gone unanswered. Stage 1 marks it missed,
/// re-prompts and warns the family; stage 2 raises an urgent alert.
///
/// Future calls run at least once, so escalation re-reads the check-in under
/// a row lock and only acts if it is still unanswered at the previous stage.
class EscalationFutureCall extends FutureCall {
  Future<void> noResponse(Session session, int checkInId, int stage) =>
      CheckInService.escalate(session, checkInId, stage);
}

/// Deletes demo circles after a while, so the public demo stays tidy.
class DemoCleanupFutureCall extends FutureCall {
  Future<void> expire(Session session, int circleId) =>
      CircleService.expireDemo(session, circleId);
}
