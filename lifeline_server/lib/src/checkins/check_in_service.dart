import 'package:serverpod/serverpod.dart';

import '../circles/circle_access.dart';
import '../common/local_time.dart';
import '../generated/future_calls.dart';
import '../generated/protocol.dart';
import '../realtime/circle_channel.dart';
import '../voice/voice_service.dart';
import 'phrases.dart';

/// The heart of Lifeline: starting check-ins, recording answers, escalating
/// when nobody answers, and keeping the family informed in real time.
abstract final class CheckInService {
  static const _awaitingAnswer = {
    CheckInStatus.pending,
    CheckInStatus.missed,
    CheckInStatus.unresponsive,
  };

  /// Identifier shared by both escalation stages, so a single cancel stops
  /// whichever stage is scheduled.
  static String escalationId(int checkInId) => 'escalate-check-in-$checkInId';

  /// The latest check-in if it is still waiting for an answer.
  static Future<CheckIn?> activeCheckIn(
    Session session,
    int circleId, {
    Transaction? transaction,
    LockMode? lockMode,
  }) async {
    final latest = await CheckIn.db.findFirstRow(
      session,
      where: (t) => t.circleId.equals(circleId),
      orderBy: (t) => t.promptedAt.desc(),
      transaction: transaction,
      lockMode: lockMode,
    );
    if (latest == null || !_awaitingAnswer.contains(latest.status)) {
      return null;
    }
    return latest;
  }

  // ---------------------------------------------------------------------------
  // Starting check-ins
  // ---------------------------------------------------------------------------

  /// Entry point of the recurring future call for a check-in slot.
  static Future<void> startScheduled(
    Session session,
    int circleId,
    int slotId,
  ) async {
    final circle = await Circle.db.findById(session, circleId);
    final slot = await CheckInSlot.db.findById(session, slotId);
    if (circle == null || slot == null || slot.circleId != circleId) {
      session.log(
        'Scheduled check-in for missing circle/slot $circleId/$slotId',
        level: LogLevel.warning,
      );
      return;
    }
    await start(session, circle, kind: CheckInKind.scheduled, slot: slot);
  }

  /// Starts a check-in: records it, speaks the prompt on the companion screen
  /// and schedules the first escalation stage.
  static Future<CheckIn?> start(
    Session session,
    Circle circle, {
    required CheckInKind kind,
    CheckInSlot? slot,
    String? requestedBy,
  }) async {
    final circleId = circle.id!;
    final existing = await activeCheckIn(session, circleId);
    if (existing != null) {
      session.log('Circle $circleId already has an active check-in.');
      return kind == CheckInKind.onDemand ? existing : null;
    }

    final now = DateTime.now().toUtc();
    final local = LocalTime.nowLocal(circle.utcOffsetMinutes, nowUtc: now);
    final promptText = Phrases.prompt(circle.lovedOneName, local);
    final scheduledFor = slot == null
        ? now
        : LocalTime.latestOccurrence(
            slot.minuteOfDay,
            circle.utcOffsetMinutes,
            nowUtc: now,
          );

    final CheckIn checkIn;
    try {
      checkIn = await CheckIn.db.insertRow(
        session,
        CheckIn(
          circleId: circleId,
          kind: kind,
          slotId: slot?.id,
          scheduledFor: scheduledFor,
          promptedAt: now,
          promptText: promptText,
          status: CheckInStatus.pending,
        ),
      );
    } on DatabaseUniqueViolationException {
      // The unique (circle, occurrence) index makes a repeated run of the
      // same scheduled future call a no-op.
      session.log('Duplicate scheduled check-in for circle $circleId ignored.');
      return null;
    }

    await _event(
      session,
      circleId,
      EventKind.checkInSent,
      slot != null
          ? '${slot.label} check-in sent'
          : requestedBy != null
          ? '$requestedBy started a check-in'
          : 'Check-in sent',
      detail: promptText,
      actorName: requestedBy,
      checkInId: checkIn.id,
    );
    await _refreshStatus(session, circleId);
    await CircleChannel.notify(session, circleId, 'check-in-started');

    // Escalate if nobody answers within the grace period.
    await session.serverpod.futureCalls
        .callWithDelay(
          Duration(seconds: circle.graceSeconds),
          identifier: escalationId(checkIn.id!),
        )
        .escalation
        .noResponse(checkIn.id!, 1);

    await _say(
      session,
      circle,
      UtteranceKind.prompt,
      promptText,
      checkInId: checkIn.id,
    );
    return checkIn;
  }

  // ---------------------------------------------------------------------------
  // Answers from the companion screen
  // ---------------------------------------------------------------------------

  /// Records an answer (or a spontaneous voice note) from the loved one.
  static Future<void> respond(
    Session session,
    Circle circle, {
    required ResponseMethod method,
    required TriageLevel level,
    List<String> reasons = const [],
    String? transcript,
  }) async {
    final circleId = circle.id!;
    final now = DateTime.now().toUtc();
    final status = switch (level) {
      TriageLevel.ok => CheckInStatus.ok,
      TriageLevel.concern => CheckInStatus.concern,
      TriageLevel.urgent => CheckInStatus.help,
    };

    // Lock the check-in row so an escalation running at the same moment
    // either sees the answer or is seen by it, never half of each.
    final answered = await session.db.transaction((tx) async {
      final active = await activeCheckIn(
        session,
        circleId,
        transaction: tx,
        lockMode: LockMode.forUpdate,
      );
      if (active == null) return null;
      return CheckIn.db.updateRow(
        session,
        active.copyWith(
          status: status,
          respondedAt: now,
          responseMethod: method,
          transcript: transcript,
          triageLevel: level,
          triageReasons: reasons,
        ),
        transaction: tx,
      );
    });

    if (answered != null) {
      await session.serverpod.futureCalls.cancel(escalationId(answered.id!));
      await _autoResolveUnanswered(session, circle, answered);
    }

    final name = circle.lovedOneName;
    final family = await _familyNames(session, circleId);
    final quote = transcript == null || transcript.isEmpty
        ? null
        : '“$transcript”';
    final how = method == ResponseMethod.button
        ? 'Answered with the button'
        : 'Answered by voice';
    final took = answered == null
        ? null
        : _human(now.difference(answered.promptedAt));

    switch (level) {
      case TriageLevel.ok:
        await _event(
          session,
          circleId,
          answered != null ? EventKind.checkedInOk : EventKind.voiceNote,
          answered != null ? '$name is OK' : '$name left a voice note',
          detail: [
            quote ?? how,
            if (took != null) 'replied in $took',
          ].join(' · '),
          actorName: name,
          checkInId: answered?.id,
        );
      case TriageLevel.concern:
        await Alert.db.insertRow(
          session,
          Alert(
            circleId: circleId,
            checkInId: answered?.id,
            kind: AlertKind.concern,
            level: AlertLevel.warning,
            title: '$name may need a call',
            detail: [?quote, reasons.join(', ')].join(' · '),
          ),
        );
        await _event(
          session,
          circleId,
          EventKind.concernReported,
          '$name mentioned something',
          detail: [?quote, reasons.join(', ')].join(' · '),
          actorName: name,
          checkInId: answered?.id,
        );
      case TriageLevel.urgent:
        await Alert.db.insertRow(
          session,
          Alert(
            circleId: circleId,
            checkInId: answered?.id,
            kind: AlertKind.helpRequested,
            level: AlertLevel.urgent,
            title: '$name needs help',
            detail: quote ?? reasons.join(', '),
          ),
        );
        await _event(
          session,
          circleId,
          EventKind.helpRequested,
          '$name asked for help',
          detail: quote ?? reasons.join(', '),
          actorName: name,
          checkInId: answered?.id,
        );
    }

    await _refreshStatus(session, circleId);
    await CircleChannel.notify(session, circleId, 'answered');

    await _say(
      session,
      circle,
      UtteranceKind.reply,
      switch (level) {
        TriageLevel.ok => Phrases.okReply(name, family),
        TriageLevel.concern => Phrases.concernReply(name, family),
        TriageLevel.urgent => Phrases.helpReply(name, family),
      },
      checkInId: answered?.id,
    );
  }

  /// Asks again when a spoken answer could not be understood.
  static Future<void> didNotCatch(Session session, Circle circle) => _say(
    session,
    circle,
    UtteranceKind.reprompt,
    Phrases.didNotCatch(circle.lovedOneName),
  );

  // ---------------------------------------------------------------------------
  // Escalation (future call)
  // ---------------------------------------------------------------------------

  static Future<void> escalate(
    Session session,
    int checkInId,
    int stage,
  ) async {
    final escalated = await session.db.transaction((tx) async {
      final checkIn = await CheckIn.db.findById(
        session,
        checkInId,
        transaction: tx,
        lockMode: LockMode.forUpdate,
      );
      if (checkIn == null || checkIn.escalationStage >= stage) return null;
      final expected = stage == 1
          ? CheckInStatus.pending
          : CheckInStatus.missed;
      if (checkIn.status != expected) return null;
      return CheckIn.db.updateRow(
        session,
        checkIn.copyWith(
          status: stage == 1
              ? CheckInStatus.missed
              : CheckInStatus.unresponsive,
          escalationStage: stage,
        ),
        transaction: tx,
      );
    });
    // Answered in the meantime, or a repeated run of this future call.
    if (escalated == null) return;

    final circle = await Circle.db.findById(session, escalated.circleId);
    if (circle == null) return;
    final circleId = circle.id!;
    final name = circle.lovedOneName;
    final waited = _human(
      DateTime.now().toUtc().difference(escalated.promptedAt),
    );

    if (stage == 1) {
      await Alert.db.insertRow(
        session,
        Alert(
          circleId: circleId,
          checkInId: checkInId,
          kind: AlertKind.missedCheckIn,
          level: AlertLevel.warning,
          title: "$name hasn't answered",
          detail: 'No answer after $waited. Lifeline asked again.',
        ),
      );
      await _event(
        session,
        circleId,
        EventKind.checkInMissed,
        'Check-in missed',
        detail: 'No answer after $waited · asking again',
        checkInId: checkInId,
      );
      await _refreshStatus(session, circleId);
      await CircleChannel.notify(session, circleId, 'missed');

      await session.serverpod.futureCalls
          .callWithDelay(
            Duration(seconds: circle.secondGraceSeconds),
            identifier: escalationId(checkInId),
          )
          .escalation
          .noResponse(checkInId, 2);

      await _say(
        session,
        circle,
        UtteranceKind.reprompt,
        Phrases.reprompt(name),
        checkInId: checkInId,
      );
    } else {
      await Alert.db.insertRow(
        session,
        Alert(
          circleId: circleId,
          checkInId: checkInId,
          kind: AlertKind.unresponsive,
          level: AlertLevel.urgent,
          title: '$name is not responding',
          detail: 'No answer for $waited. Please check on $name now.',
        ),
      );
      await _event(
        session,
        circleId,
        EventKind.escalated,
        'Escalated to the whole family',
        detail: 'No answer for $waited',
        checkInId: checkInId,
      );
      await _refreshStatus(session, circleId);
      await CircleChannel.notify(session, circleId, 'unresponsive');

      final family = await _familyNames(session, circleId);
      await _say(
        session,
        circle,
        UtteranceKind.notice,
        Phrases.unresponsiveNotice(name, family),
        checkInId: checkInId,
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Family actions
  // ---------------------------------------------------------------------------

  static Future<void> acknowledge(
    Session session,
    CircleMember member,
    int alertId,
  ) async {
    final alert = await _alertFor(session, member, alertId);
    if (alert.acknowledgedAt != null || alert.resolvedAt != null) return;

    await Alert.db.updateRow(
      session,
      alert.copyWith(
        acknowledgedAt: DateTime.now().toUtc(),
        acknowledgedByName: member.displayName,
      ),
    );
    await _event(
      session,
      alert.circleId,
      EventKind.alertAcknowledged,
      '${member.displayName} is on it',
      detail: alert.title,
      actorName: member.displayName,
      checkInId: alert.checkInId,
    );
    await CircleChannel.notify(session, alert.circleId, 'acknowledged');

    if (alert.kind == AlertKind.missedCheckIn) return;
    final circle = await CircleAccess.requireCircle(session, alert.circleId);
    final helper = Phrases.familyNames([member.displayName]);
    await _say(
      session,
      circle,
      UtteranceKind.notice,
      alert.level == AlertLevel.urgent
          ? Phrases.acknowledged(circle.lovedOneName, helper)
          : '${circle.lovedOneName}, $helper got your message and will '
                'check in with you soon.',
      checkInId: alert.checkInId,
    );
  }

  static Future<void> resolve(
    Session session,
    CircleMember member,
    int alertId,
  ) async {
    final alert = await _alertFor(session, member, alertId);
    if (alert.resolvedAt != null) return;

    await Alert.db.updateRow(
      session,
      alert.copyWith(
        resolvedAt: DateTime.now().toUtc(),
        resolvedByName: member.displayName,
      ),
    );
    await _event(
      session,
      alert.circleId,
      EventKind.alertResolved,
      '${member.displayName} marked it resolved',
      detail: alert.title,
      actorName: member.displayName,
      checkInId: alert.checkInId,
    );
    await _refreshStatus(session, alert.circleId);
    await CircleChannel.notify(session, alert.circleId, 'resolved');
  }

  /// A typed message from the family, spoken aloud on the companion screen.
  static Future<void> sendMessage(
    Session session,
    CircleMember member,
    String text,
  ) async {
    final message = text.trim();
    if (message.isEmpty || message.length > 400) {
      throw LifelineException(
        message: 'Messages can be up to 400 characters.',
        code: LifelineErrorCode.invalidInput,
      );
    }
    final circle = await CircleAccess.requireCircle(session, member.circleId);
    await _event(
      session,
      member.circleId,
      EventKind.messageSent,
      '${member.displayName} sent a voice message',
      detail: message,
      actorName: member.displayName,
    );
    await CircleChannel.notify(session, member.circleId, 'message');
    await _say(
      session,
      circle,
      UtteranceKind.familyMessage,
      message,
      spokenText: Phrases.familyMessage(
        Phrases.familyNames([member.displayName]),
        message,
      ),
      fromName: member.displayName,
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  /// The circle status is derived from open alerts and the latest check-in,
  /// and stored on the circle for quick listing.
  static Future<CircleStatus> deriveStatus(Session session, int circleId) async {
    final openAlerts = await Alert.db.find(
      session,
      where: (t) => t.circleId.equals(circleId) & t.resolvedAt.equals(null),
    );
    if (openAlerts.any((a) => a.level == AlertLevel.urgent)) {
      return CircleStatus.alert;
    }
    final latest = await CheckIn.db.findFirstRow(
      session,
      where: (t) => t.circleId.equals(circleId),
      orderBy: (t) => t.promptedAt.desc(),
    );
    if (latest?.status == CheckInStatus.pending) return CircleStatus.awaiting;
    if (openAlerts.any((a) => a.kind == AlertKind.missedCheckIn)) {
      return CircleStatus.missed;
    }
    if (openAlerts.isNotEmpty) return CircleStatus.concern;
    if (latest == null) return CircleStatus.quiet;
    return CircleStatus.ok;
  }

  static Future<void> _refreshStatus(Session session, int circleId) async {
    final circle = await Circle.db.findById(session, circleId);
    if (circle == null) return;
    final status = await deriveStatus(session, circleId);
    if (status == circle.status) return;
    await Circle.db.updateRow(
      session,
      circle.copyWith(status: status, statusChangedAt: DateTime.now().toUtc()),
    );
  }

  /// When an overdue check-in is finally answered, its "missed" and "not
  /// responding" alerts are no longer needed.
  static Future<void> _autoResolveUnanswered(
    Session session,
    Circle circle,
    CheckIn checkIn,
  ) async {
    final alerts = await Alert.db.find(
      session,
      where: (t) =>
          t.checkInId.equals(checkIn.id) &
          t.resolvedAt.equals(null) &
          t.kind.inSet({AlertKind.missedCheckIn, AlertKind.unresponsive}),
    );
    final now = DateTime.now().toUtc();
    for (final alert in alerts) {
      await Alert.db.updateRow(
        session,
        alert.copyWith(resolvedAt: now, resolvedByName: circle.lovedOneName),
      );
    }
  }

  static Future<Alert> _alertFor(
    Session session,
    CircleMember member,
    int alertId,
  ) async {
    final alert = await Alert.db.findById(session, alertId);
    if (alert == null || alert.circleId != member.circleId) {
      throw LifelineException(
        message: 'That alert no longer exists.',
        code: LifelineErrorCode.notFound,
      );
    }
    return alert;
  }

  static Future<String> _familyNames(Session session, int circleId) async {
    final members = await CircleMember.db.find(
      session,
      where: (t) => t.circleId.equals(circleId),
      orderBy: (t) => t.joinedAt,
    );
    return Phrases.familyNames(members.map((m) => m.displayName).toList());
  }

  /// Speaks [text] on the companion screen (via ElevenLabs when available).
  static Future<Utterance> _say(
    Session session,
    Circle circle,
    UtteranceKind kind,
    String text, {
    String? spokenText,
    String? fromName,
    int? checkInId,
  }) async {
    final audioPath = await VoiceService.speak(
      session,
      text: spokenText ?? text,
      voiceId: circle.voiceId,
    );
    final utterance = await Utterance.db.insertRow(
      session,
      Utterance(
        circleId: circle.id!,
        kind: kind,
        text: text,
        audioPath: audioPath,
        fromName: fromName,
        checkInId: checkInId,
      ),
    );
    await CircleChannel.notify(session, circle.id!, 'utterance');
    return utterance;
  }

  static Future<void> _event(
    Session session,
    int circleId,
    EventKind kind,
    String title, {
    String? detail,
    String? actorName,
    int? checkInId,
  }) async {
    await CircleEvent.db.insertRow(
      session,
      CircleEvent(
        circleId: circleId,
        kind: kind,
        title: title,
        detail: detail,
        actorName: actorName,
        checkInId: checkInId,
      ),
    );
  }

  /// "12 seconds", "3 minutes", "1 hour 5 minutes".
  static String _human(Duration d) {
    if (d.inSeconds < 60) {
      final s = d.inSeconds < 1 ? 1 : d.inSeconds;
      return '$s second${s == 1 ? '' : 's'}';
    }
    if (d.inMinutes < 60) {
      return '${d.inMinutes} minute${d.inMinutes == 1 ? '' : 's'}';
    }
    final h = d.inHours;
    final m = d.inMinutes % 60;
    return '$h hour${h == 1 ? '' : 's'}'
        '${m == 0 ? '' : ' $m minute${m == 1 ? '' : 's'}'}';
  }
}
