import 'package:flutter/material.dart';
import 'package:lifeline_client/lifeline_client.dart';

import '../../format.dart';
import '../../state/live_stream.dart';
import '../../theme.dart';
import '../../widgets/common.dart';

/// The big card at the top of the dashboard: how is our person right now?
class StatusHero extends StatelessWidget {
  final CircleSnapshot snapshot;

  const StatusHero({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return TickerBuilder(
      builder: (context) {
        final now = ServerClock.now();
        final circle = snapshot.circle;
        final style = StatusStyle.of(circle.status);
        final view = _describe(now);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
          padding: const EdgeInsets.fromLTRB(22, 20, 22, 20),
          decoration: BoxDecoration(
            color: style.soft,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: style.color.withValues(alpha: 0.35)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _PulsingIcon(
                    icon: style.icon,
                    color: style.color,
                    pulsing:
                        circle.status == CircleStatus.awaiting ||
                        circle.status == CircleStatus.missed ||
                        circle.status == CircleStatus.alert,
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Semantics(
                          liveRegion: true,
                          child: Text(
                            view.headline,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: style.color,
                              height: 1.15,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          view.detail,
                          style: const TextStyle(
                            fontSize: 16,
                            color: LifelineColors.ink,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (view.progress != null) ...[
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: LinearProgressIndicator(
                    value: view.progress,
                    minHeight: 8,
                    color: style.color,
                    backgroundColor: style.color.withValues(alpha: 0.15),
                  ),
                ),
              ],
              const SizedBox(height: 16),
              Wrap(
                spacing: 18,
                runSpacing: 8,
                children: [
                  _Fact(
                    icon: Icons.tablet_mac_rounded,
                    text: _deviceText(now),
                    color: _deviceOnline(now)
                        ? LifelineColors.ok
                        : LifelineColors.muted,
                  ),
                  if (snapshot.nextCheckInAt != null)
                    _Fact(
                      icon: Icons.event_repeat_rounded,
                      text:
                          'Next check-in ${Fmt.time(snapshot.nextCheckInAt!)}',
                    ),
                  _Fact(
                    icon: Icons.timer_outlined,
                    text: 'Reply window ${Fmt.duration(circle.graceSeconds)}',
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  _HeroView _describe(DateTime now) {
    final circle = snapshot.circle;
    final name = circle.lovedOneName;
    final active = snapshot.activeCheckIn;
    CheckIn? lastAnswered;
    for (final c in snapshot.recentCheckIns) {
      if (c.respondedAt != null) {
        lastAnswered = c;
        break;
      }
    }

    switch (circle.status) {
      case CircleStatus.quiet:
        return _HeroView(
          'Ready for the first check-in',
          snapshot.nextCheckInAt == null
              ? 'Add a check-in time to get started.'
              : '$name will be asked at ${Fmt.time(snapshot.nextCheckInAt!)}.',
        );
      case CircleStatus.ok:
        final answered = lastAnswered;
        return _HeroView(
          '$name is OK',
          answered == null
              ? 'Everything looks fine.'
              : 'Checked in ${Fmt.ago(answered.respondedAt!, now)}'
                    '${_how(answered)}',
        );
      case CircleStatus.awaiting:
        if (active == null) return _HeroView('Waiting for $name', '');
        final deadline = active.promptedAt.add(
          Duration(seconds: circle.graceSeconds),
        );
        final left = deadline.difference(now);
        return _HeroView(
          'Waiting for $name to answer…',
          'Asked ${Fmt.ago(active.promptedAt, now)}. If there is no answer, '
              'the family is alerted in ${Fmt.countdown(left)}.',
          progress: _progress(active.promptedAt, deadline, now),
        );
      case CircleStatus.concern:
        final alert = snapshot.openAlerts.firstOrNull;
        return _HeroView(
          '$name may need a call',
          alert?.detail ?? 'Something came up in the last check-in.',
        );
      case CircleStatus.missed:
        final missed = snapshot.openAlerts
            .where((a) => a.kind == AlertKind.missedCheckIn)
            .firstOrNull;
        if (missed == null) return _HeroView("$name hasn't answered", '');
        final deadline = missed.createdAt.add(
          Duration(seconds: circle.secondGraceSeconds),
        );
        return _HeroView(
          "$name hasn't answered",
          'Lifeline asked again. Escalating to everyone in '
              '${Fmt.countdown(deadline.difference(now))}.',
          progress: _progress(missed.createdAt, deadline, now),
        );
      case CircleStatus.alert:
        final urgent = snapshot.openAlerts
            .where((a) => a.level == AlertLevel.urgent)
            .firstOrNull;
        final ack = urgent?.acknowledgedByName;
        return _HeroView(
          urgent?.title ?? '$name needs help',
          ack != null
              ? '$ack is on it. ${urgent?.detail ?? ''}'
              : urgent?.detail ?? 'Please check on $name now.',
        );
    }
  }

  static String _how(CheckIn c) {
    if (c.responseMethod == ResponseMethod.voice && c.transcript != null) {
      return ' · “${c.transcript}”';
    }
    return c.responseMethod == ResponseMethod.voice
        ? ' · by voice'
        : ' · tapped “I’m okay”';
  }

  static double _progress(DateTime start, DateTime end, DateTime now) {
    final total = end.difference(start).inMilliseconds;
    if (total <= 0) return 1;
    return (now.difference(start).inMilliseconds / total).clamp(0.0, 1.0);
  }

  bool _deviceOnline(DateTime now) {
    final seen = snapshot.companionLastSeenAt;
    return seen != null && now.difference(seen).inSeconds < 90;
  }

  String _deviceText(DateTime now) {
    if (snapshot.deviceCount == 0) return 'No tablet paired yet';
    final seen = snapshot.companionLastSeenAt;
    if (_deviceOnline(now)) return 'Tablet online';
    if (seen == null) return 'Tablet not connected yet';
    return 'Tablet last seen ${Fmt.ago(seen, now)}';
  }
}

class _HeroView {
  final String headline;
  final String detail;
  final double? progress;

  _HeroView(this.headline, this.detail, {this.progress});
}

class _Fact extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;

  const _Fact({
    required this.icon,
    required this.text,
    this.color = LifelineColors.muted,
  });

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 18, color: color),
      const SizedBox(width: 6),
      Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: color == LifelineColors.muted ? LifelineColors.muted : color,
          fontWeight: FontWeight.w700,
        ),
      ),
    ],
  );
}

class _PulsingIcon extends StatefulWidget {
  final IconData icon;
  final Color color;
  final bool pulsing;

  const _PulsingIcon({
    required this.icon,
    required this.color,
    required this.pulsing,
  });

  @override
  State<_PulsingIcon> createState() => _PulsingIconState();
}

class _PulsingIconState extends State<_PulsingIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  );

  @override
  void initState() {
    super.initState();
    if (widget.pulsing) _controller.repeat();
  }

  @override
  void didUpdateWidget(covariant _PulsingIcon old) {
    super.didUpdateWidget(old);
    if (widget.pulsing && !_controller.isAnimating) _controller.repeat();
    if (!widget.pulsing && _controller.isAnimating) _controller.reset();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: 64,
    child: AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = _controller.value;
        return Stack(
          alignment: Alignment.center,
          children: [
            if (widget.pulsing)
              Container(
                width: 48 + 16 * t,
                height: 48 + 16 * t,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.color.withValues(alpha: 0.25 * (1 - t)),
                ),
              ),
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: widget.color,
                shape: BoxShape.circle,
              ),
              child: Icon(widget.icon, color: Colors.white, size: 28),
            ),
          ],
        );
      },
    ),
  );
}
