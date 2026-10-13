import 'package:flutter/material.dart';
import 'package:lifeline_client/lifeline_client.dart';

import '../../format.dart';
import '../../state/live_stream.dart';
import '../../theme.dart';
import '../../widgets/common.dart';

/// Everything that happened in the circle, live.
class TimelineCard extends StatelessWidget {
  final CircleSnapshot snapshot;
  final int maxItems;

  const TimelineCard({super.key, required this.snapshot, this.maxItems = 14});

  @override
  Widget build(BuildContext context) {
    final events = snapshot.recentEvents.take(maxItems).toList();
    return SectionCard(
      title: 'Activity',
      icon: Icons.history_rounded,
      trailing: const Pill(
        label: 'LIVE',
        color: LifelineColors.ok,
        background: LifelineColors.okSoft,
        icon: Icons.circle,
      ),
      child: events.isEmpty
          ? const Text(
              'Nothing yet. Check-ins and messages will appear here.',
              style: TextStyle(color: LifelineColors.muted),
            )
          : TickerBuilder(
              interval: const Duration(seconds: 20),
              builder: (context) {
                final now = ServerClock.now();
                return Column(
                  children: [
                    for (var i = 0; i < events.length; i++)
                      _EventTile(
                        key: ValueKey(events[i].id),
                        event: events[i],
                        now: now,
                        last: i == events.length - 1,
                      ),
                  ],
                );
              },
            ),
    );
  }
}

class _EventTile extends StatelessWidget {
  final CircleEvent event;
  final DateTime now;
  final bool last;

  const _EventTile({
    super.key,
    required this.event,
    required this.now,
    required this.last,
  });

  @override
  Widget build(BuildContext context) {
    final (icon, color) = _look(event.kind);
    final fresh = now.difference(event.createdAt).inSeconds < 8;
    final tile = IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 17, color: color),
              ),
              if (!last)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: LifelineColors.line,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: last ? 0 : 14, top: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          event.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        Fmt.ago(event.createdAt, now),
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: LifelineColors.muted,
                        ),
                      ),
                    ],
                  ),
                  if (event.detail != null && event.detail!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        event.detail!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13.5,
                          color: LifelineColors.muted,
                          height: 1.3,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    if (!fresh) return tile;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      builder: (context, t, child) => Opacity(
        opacity: t,
        child: Transform.translate(
          offset: Offset(0, -10 * (1 - t)),
          child: child,
        ),
      ),
      child: tile,
    );
  }

  static (IconData, Color) _look(EventKind kind) => switch (kind) {
    EventKind.circleCreated => (Icons.favorite_rounded, LifelineColors.heart),
    EventKind.memberJoined => (Icons.person_add_rounded, LifelineColors.teal),
    EventKind.devicePaired => (Icons.tablet_mac_rounded, LifelineColors.teal),
    EventKind.checkInSent => (
      Icons.record_voice_over_rounded,
      LifelineColors.awaiting,
    ),
    EventKind.checkedInOk => (Icons.check_circle_rounded, LifelineColors.ok),
    EventKind.concernReported => (
      Icons.chat_bubble_rounded,
      LifelineColors.concern,
    ),
    EventKind.helpRequested => (Icons.emergency_rounded, LifelineColors.alert),
    EventKind.checkInMissed => (
      Icons.notifications_active_rounded,
      LifelineColors.missed,
    ),
    EventKind.escalated => (Icons.campaign_rounded, LifelineColors.alert),
    EventKind.alertAcknowledged => (
      Icons.directions_run_rounded,
      LifelineColors.ok,
    ),
    EventKind.alertResolved => (Icons.task_alt_rounded, LifelineColors.ok),
    EventKind.messageSent => (Icons.campaign_rounded, LifelineColors.teal),
    EventKind.voiceNote => (Icons.mic_rounded, LifelineColors.teal),
    EventKind.settingsChanged => (Icons.tune_rounded, LifelineColors.muted),
  };
}
