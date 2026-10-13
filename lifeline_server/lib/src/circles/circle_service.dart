import 'package:serverpod/serverpod.dart';

import '../checkins/check_in_service.dart';
import '../checkins/schedules.dart';
import '../common/codes.dart';
import '../common/local_time.dart';
import '../generated/protocol.dart';
import '../realtime/circle_channel.dart';
import '../voice/voice_catalog.dart';
import 'circle_access.dart';

/// Creating, joining and configuring care circles, and pairing tablets.
abstract final class CircleService {
  static const demoLifetime = Duration(hours: 12);

  static Future<Circle> create(
    Session session,
    CircleSettings settings, {
    required String userIdentifier,
    required String myName,
    String? relationship,
    bool isDemo = false,
  }) async {
    _validate(settings);
    final name = _cleanName(myName, field: 'Your name');
    final pairingCode = await _uniquePairingCode(session);
    final inviteCode = await _uniqueInviteCode(session);

    final circle = await session.db.transaction((tx) async {
      final circle = await Circle.db.insertRow(
        session,
        Circle(
          lovedOneName: _cleanName(settings.lovedOneName, field: 'Name'),
          voiceId: settings.voiceId,
          utcOffsetMinutes: settings.utcOffsetMinutes,
          graceSeconds: settings.graceSeconds,
          secondGraceSeconds: settings.secondGraceSeconds,
          pairingCode: pairingCode,
          inviteCode: inviteCode,
          isDemo: isDemo,
        ),
        transaction: tx,
      );
      await CircleMember.db.insertRow(
        session,
        CircleMember(
          circleId: circle.id!,
          userIdentifier: userIdentifier,
          displayName: name,
          relationship: relationship?.trim(),
          role: MemberRole.owner,
        ),
        transaction: tx,
      );
      await CheckInSlot.db.insert(
        session,
        _slotsFor(circle.id!, settings.slotMinutes),
        transaction: tx,
      );
      await CircleEvent.db.insertRow(
        session,
        CircleEvent(
          circleId: circle.id!,
          kind: EventKind.circleCreated,
          title: '$name started a care circle for ${circle.lovedOneName}',
          actorName: name,
        ),
        transaction: tx,
      );
      return circle;
    });

    await _scheduleAll(session, circle);
    return circle;
  }

  static Future<Circle> join(
    Session session,
    String inviteCode, {
    required String userIdentifier,
    required String myName,
    String? relationship,
  }) async {
    final circle = await Circle.db.findFirstRow(
      session,
      where: (t) => t.inviteCode.equals(inviteCode.trim().toUpperCase()),
    );
    if (circle == null) {
      await Future<void>.delayed(const Duration(milliseconds: 600));
      throw LifelineException(
        message: "That invite code didn't match a care circle.",
        code: LifelineErrorCode.invalidCode,
      );
    }
    final existing = await CircleMember.db.findFirstRow(
      session,
      where: (t) =>
          t.circleId.equals(circle.id) &
          t.userIdentifier.equals(userIdentifier),
    );
    if (existing != null) return circle;

    final name = _cleanName(myName, field: 'Your name');
    await CircleMember.db.insertRow(
      session,
      CircleMember(
        circleId: circle.id!,
        userIdentifier: userIdentifier,
        displayName: name,
        relationship: relationship?.trim(),
        role: MemberRole.caregiver,
      ),
    );
    await CircleEvent.db.insertRow(
      session,
      CircleEvent(
        circleId: circle.id!,
        kind: EventKind.memberJoined,
        title: '$name joined the circle',
        actorName: name,
      ),
    );
    await CircleChannel.notify(session, circle.id!, 'member-joined');
    return circle;
  }

  static Future<Circle> updateSettings(
    Session session,
    CircleMember member,
    CircleSettings settings,
  ) async {
    _validate(settings);
    final circle = await CircleAccess.requireCircle(session, member.circleId);
    final oldSlots = await CheckInSlot.db.find(
      session,
      where: (t) => t.circleId.equals(circle.id),
    );
    for (final slot in oldSlots) {
      await Schedules.cancelSlot(session, slot.id!);
    }

    final updated = await session.db.transaction((tx) async {
      await CheckInSlot.db.deleteWhere(
        session,
        where: (t) => t.circleId.equals(circle.id),
        transaction: tx,
      );
      await CheckInSlot.db.insert(
        session,
        _slotsFor(circle.id!, settings.slotMinutes),
        transaction: tx,
      );
      return Circle.db.updateRow(
        session,
        circle.copyWith(
          lovedOneName: _cleanName(settings.lovedOneName, field: 'Name'),
          voiceId: settings.voiceId,
          utcOffsetMinutes: settings.utcOffsetMinutes,
          graceSeconds: settings.graceSeconds,
          secondGraceSeconds: settings.secondGraceSeconds,
        ),
        transaction: tx,
      );
    });
    await _scheduleAll(session, updated);

    final times = ([
      ...settings.slotMinutes,
    ]..sort()).map(LocalTime.label).join(', ');
    await CircleEvent.db.insertRow(
      session,
      CircleEvent(
        circleId: circle.id!,
        kind: EventKind.settingsChanged,
        title: '${member.displayName} updated the settings',
        detail: 'Check-ins at $times',
        actorName: member.displayName,
      ),
    );
    await CircleChannel.notify(session, circle.id!, 'settings');
    return updated;
  }

  /// Pairs a tablet using the circle's one-time pairing code.
  static Future<PairingResult> pair(
    Session session,
    String pairingCode,
    String label,
  ) async {
    final code = pairingCode.replaceAll(RegExp(r'\s'), '');
    final circle = await Circle.db.findFirstRow(
      session,
      where: (t) => t.pairingCode.equals(code),
    );
    if (circle == null) {
      // Slow down guessing.
      await Future<void>.delayed(const Duration(seconds: 1));
      throw LifelineException(
        message: "That code didn't work. Check the code in the family app.",
        code: LifelineErrorCode.invalidCode,
      );
    }

    final token = Codes.deviceToken();
    await CompanionDevice.db.insertRow(
      session,
      CompanionDevice(
        circleId: circle.id!,
        tokenHash: Codes.hashToken(token),
        label: label.trim().isEmpty ? 'Companion screen' : label.trim(),
      ),
    );
    // Pairing codes are single use.
    await Circle.db.updateRow(
      session,
      circle.copyWith(pairingCode: await _uniquePairingCode(session)),
    );
    await _devicePairedEvent(session, circle);
    return PairingResult(
      deviceToken: token,
      circleId: circle.id!,
      lovedOneName: circle.lovedOneName,
    );
  }

  static Future<String> newPairingCode(
    Session session,
    CircleMember member,
  ) async {
    final circle = await CircleAccess.requireCircle(session, member.circleId);
    final code = await _uniquePairingCode(session);
    await Circle.db.updateRow(session, circle.copyWith(pairingCode: code));
    await CircleChannel.notify(session, circle.id!, 'pairing-code');
    return code;
  }

  /// A complete sandbox for trying Lifeline: a circle for "Rose" with a
  /// paired virtual companion screen, short escalation timers and a week of
  /// history. It deletes itself after [demoLifetime] via a future call.
  static Future<DemoSetup> createDemo(
    Session session, {
    required String userIdentifier,
    required String myName,
    required int utcOffsetMinutes,
  }) async {
    final circle = await create(
      session,
      CircleSettings(
        lovedOneName: 'Rose',
        voiceId: VoiceCatalog.defaultVoiceId,
        utcOffsetMinutes: utcOffsetMinutes,
        slotMinutes: [9 * 60, 19 * 60],
        // Shortened so a missed check-in escalates while you watch.
        graceSeconds: 30,
        secondGraceSeconds: 20,
      ),
      userIdentifier: userIdentifier,
      myName: myName,
      relationship: 'Daughter',
      isDemo: true,
    );
    await _seedHistory(session, circle);

    final token = Codes.deviceToken();
    await CompanionDevice.db.insertRow(
      session,
      CompanionDevice(
        circleId: circle.id!,
        tokenHash: Codes.hashToken(token),
        label: "Rose's kitchen tablet",
      ),
    );
    await _devicePairedEvent(session, circle);
    await CheckInService.deriveStatus(session, circle.id!).then(
      (status) => Circle.db.updateRow(session, circle.copyWith(status: status)),
    );

    await Schedules.expireDemoLater(session, circle.id!, demoLifetime);

    return DemoSetup(circleId: circle.id!, deviceToken: token);
  }

  static Future<void> expireDemo(Session session, int circleId) async {
    final circle = await Circle.db.findById(session, circleId);
    if (circle == null || !circle.isDemo) return;
    final slots = await CheckInSlot.db.find(
      session,
      where: (t) => t.circleId.equals(circleId),
    );
    for (final slot in slots) {
      await Schedules.cancelSlot(session, slot.id!);
    }
    final checkIns = await CheckIn.db.find(
      session,
      where: (t) => t.circleId.equals(circleId),
    );
    for (final checkIn in checkIns) {
      await Schedules.cancelEscalation(session, checkIn.id!);
    }
    // Members, check-ins, alerts, events and devices cascade.
    await Circle.db.deleteRow(session, circle);
    session.log('Expired demo circle $circleId');
  }

  // ---------------------------------------------------------------------------

  static Future<void> _scheduleAll(Session session, Circle circle) async {
    final slots = await CheckInSlot.db.find(
      session,
      where: (t) => t.circleId.equals(circle.id),
    );
    for (final slot in slots) {
      await Schedules.scheduleSlot(session, circle, slot);
    }
  }

  static List<CheckInSlot> _slotsFor(int circleId, List<int> minutes) =>
      (minutes.toSet().toList()..sort())
          .map(
            (minute) => CheckInSlot(
              circleId: circleId,
              minuteOfDay: minute,
              label: Schedules.labelFor(minute),
            ),
          )
          .toList();

  static Future<void> _devicePairedEvent(Session session, Circle circle) async {
    await CircleEvent.db.insertRow(
      session,
      CircleEvent(
        circleId: circle.id!,
        kind: EventKind.devicePaired,
        title: "${circle.lovedOneName}'s companion screen is connected",
      ),
    );
    await CircleChannel.notify(session, circle.id!, 'device-paired');
  }

  /// Gives the demo a believable last week: mostly fine, one sore back.
  static Future<void> _seedHistory(Session session, Circle circle) async {
    final slots = await CheckInSlot.db.find(
      session,
      where: (t) => t.circleId.equals(circle.id),
      orderBy: (t) => t.minuteOfDay,
    );
    final now = DateTime.now().toUtc();
    final history = <CheckIn>[];
    for (var day = 6; day >= 0; day--) {
      for (final slot in slots) {
        final at = LocalTime.latestOccurrence(
          slot.minuteOfDay,
          circle.utcOffsetMinutes,
          nowUtc: now,
        ).subtract(Duration(days: day));
        final concern = day == 3 && slot.minuteOfDay < 12 * 60;
        if (day == 0 && at.isAfter(now.subtract(const Duration(minutes: 30)))) {
          continue; // Too recent to look like history.
        }
        final voice = day.isEven;
        history.add(
          CheckIn(
            circleId: circle.id!,
            kind: CheckInKind.scheduled,
            slotId: slot.id,
            scheduledFor: at,
            promptedAt: at,
            promptText: 'How are you feeling?',
            status: concern ? CheckInStatus.concern : CheckInStatus.ok,
            respondedAt: at.add(Duration(minutes: 1 + (day * 7) % 9)),
            responseMethod: concern || voice
                ? ResponseMethod.voice
                : ResponseMethod.button,
            transcript: concern
                ? 'My back is a bit sore today.'
                : voice
                ? "I'm fine, thank you dear."
                : null,
            triageLevel: concern ? TriageLevel.concern : TriageLevel.ok,
            triageReasons: concern ? ['Mentioned pain'] : ['Sounds well'],
          ),
        );
      }
    }
    await CheckIn.db.insert(session, history);
  }

  static void _validate(CircleSettings s) {
    String? problem;
    if (s.lovedOneName.trim().isEmpty || s.lovedOneName.trim().length > 40) {
      problem = 'Please enter a name of up to 40 characters.';
    } else if (!VoiceCatalog.isKnown(s.voiceId)) {
      problem = 'Please choose one of the available voices.';
    } else if (s.slotMinutes.isEmpty || s.slotMinutes.length > 6) {
      problem = 'Choose between one and six check-in times.';
    } else if (s.slotMinutes.any((m) => m < 0 || m >= 24 * 60)) {
      problem = 'Check-in times must be within the day.';
    } else if (s.graceSeconds < 10 || s.graceSeconds > 4 * 3600) {
      problem = 'The reply window must be between 10 seconds and 4 hours.';
    } else if (s.secondGraceSeconds < 10 || s.secondGraceSeconds > 4 * 3600) {
      problem = 'The escalation window must be between 10 seconds and 4 hours.';
    } else if (s.utcOffsetMinutes.abs() > 14 * 60) {
      problem = 'Invalid time zone.';
    }
    if (problem != null) {
      throw LifelineException(
        message: problem,
        code: LifelineErrorCode.invalidInput,
      );
    }
  }

  static String _cleanName(String value, {required String field}) {
    final name = value.trim().replaceAll(RegExp(r'\s+'), ' ');
    if (name.isEmpty || name.length > 40) {
      throw LifelineException(
        message: '$field should be between 1 and 40 characters.',
        code: LifelineErrorCode.invalidInput,
      );
    }
    return name;
  }

  static Future<String> _uniquePairingCode(Session session) async {
    while (true) {
      final code = Codes.pairingCode();
      final taken = await Circle.db.count(
        session,
        where: (t) => t.pairingCode.equals(code),
      );
      if (taken == 0) return code;
    }
  }

  static Future<String> _uniqueInviteCode(Session session) async {
    while (true) {
      final code = Codes.inviteCode();
      final taken = await Circle.db.count(
        session,
        where: (t) => t.inviteCode.equals(code),
      );
      if (taken == 0) return code;
    }
  }
}
