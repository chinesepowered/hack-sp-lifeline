import 'package:flutter/material.dart';
import 'package:lifeline_client/lifeline_client.dart';

import '../../format.dart';
import '../../theme.dart';
import '../../widgets/common.dart';

/// A week of scheduled check-ins at a glance: one dot per check-in.
class HistoryCard extends StatelessWidget {
  final CircleSnapshot snapshot;

  const HistoryCard({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final days = [
      for (var i = 6; i >= 0; i--)
        DateTime(today.year, today.month, today.day - i),
    ];
    final scheduled = snapshot.recentCheckIns
        .where((c) => c.kind == CheckInKind.scheduled)
        .toList();

    CheckIn? find(DateTime day, CheckInSlot slot) {
      for (final c in scheduled) {
        final local = c.scheduledFor.toLocal();
        if (c.slotId == slot.id &&
            local.year == day.year &&
            local.month == day.month &&
            local.day == day.day) {
          return c;
        }
      }
      return null;
    }

    final finished = snapshot.recentCheckIns
        .where((c) => c.status != CheckInStatus.pending)
        .toList();
    final answered = finished.where((c) => c.respondedAt != null).toList();
    final replyTimes =
        answered
            .map((c) => c.respondedAt!.difference(c.promptedAt).inSeconds)
            .toList()
          ..sort();
    final median = replyTimes.isEmpty
        ? null
        : replyTimes[replyTimes.length ~/ 2];

    return SectionCard(
      title: 'Last 7 days',
      icon: Icons.insights_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(width: 92),
              for (final day in days)
                Expanded(
                  child: Center(
                    child: Text(
                      Fmt.shortWeekday(day),
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: LifelineColors.muted,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          for (final slot in snapshot.slots)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  SizedBox(
                    width: 92,
                    child: Text(
                      Fmt.minuteOfDay(slot.minuteOfDay),
                      style: const TextStyle(
                        fontSize: 13,
                        color: LifelineColors.muted,
                      ),
                    ),
                  ),
                  for (final day in days)
                    Expanded(child: Center(child: _Dot(find(day, slot)))),
                ],
              ),
            ),
          const SizedBox(height: 6),
          Wrap(
            spacing: 16,
            runSpacing: 6,
            children: [
              Text(
                '${answered.length} of ${finished.length} check-ins answered',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              if (median != null)
                Text(
                  'Typical reply: '
                  '${median < 60 ? '$median s' : '${median ~/ 60} min'}',
                  style: const TextStyle(color: LifelineColors.muted),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final CheckIn? checkIn;

  const _Dot(this.checkIn);

  @override
  Widget build(BuildContext context) {
    final c = checkIn;
    if (c == null) {
      return Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: LifelineColors.line, width: 2),
        ),
      );
    }
    final color = checkInColor(c.status);
    return Tooltip(
      message: [
        Fmt.ago(c.promptedAt, DateTime.now()),
        c.status.name,
        if (c.transcript != null) '“${c.transcript}”',
      ].join(' · '),
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: c.status == CheckInStatus.ok
            ? const Icon(Icons.check_rounded, size: 15, color: Colors.white)
            : const Icon(
                Icons.priority_high_rounded,
                size: 14,
                color: Colors.white,
              ),
      ),
    );
  }
}
