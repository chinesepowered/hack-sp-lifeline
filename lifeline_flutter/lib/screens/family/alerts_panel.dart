import 'package:flutter/material.dart';
import 'package:lifeline_client/lifeline_client.dart';

import '../../client.dart';
import '../../format.dart';
import '../../state/live_stream.dart';
import '../../theme.dart';
import '../../widgets/common.dart';

/// Open alerts, newest first. "I'm on it" tells everyone, including the
/// loved one, that someone is handling it.
class AlertsPanel extends StatelessWidget {
  final CircleSnapshot snapshot;

  const AlertsPanel({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    if (snapshot.openAlerts.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        for (final alert in snapshot.openAlerts)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: _AlertCard(
              key: ValueKey(alert.id),
              alert: alert,
              circleId: snapshot.circle.id!,
            ),
          ),
      ],
    );
  }
}

class _AlertCard extends StatefulWidget {
  final Alert alert;
  final int circleId;

  const _AlertCard({super.key, required this.alert, required this.circleId});

  @override
  State<_AlertCard> createState() => _AlertCardState();
}

class _AlertCardState extends State<_AlertCard> {
  bool _busy = false;

  Future<void> _run(Future<void> Function() action) async {
    setState(() => _busy = true);
    try {
      await action();
    } catch (e) {
      if (mounted) showSnack(context, friendlyError(e), error: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final alert = widget.alert;
    final urgent = alert.level == AlertLevel.urgent;
    final color = urgent ? LifelineColors.alert : LifelineColors.concern;
    final soft = urgent ? LifelineColors.alertSoft : LifelineColors.concernSoft;
    final acknowledgedBy = alert.acknowledgedByName;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 350),
      builder: (context, t, child) => Opacity(
        opacity: t,
        child: Transform.translate(
          offset: Offset(0, 12 * (1 - t)),
          child: child,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 16, 16, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: color, width: urgent ? 2.5 : 1.5),
          boxShadow: [
            if (urgent)
              BoxShadow(
                color: color.withValues(alpha: 0.18),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: soft, shape: BoxShape.circle),
              child: Icon(_iconFor(alert.kind), color: color, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          alert.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: color,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Pill(
                        label: urgent ? 'URGENT' : 'FOLLOW UP',
                        color: color,
                        background: soft,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    alert.detail,
                    style: const TextStyle(fontSize: 15, height: 1.3),
                  ),
                  const SizedBox(height: 6),
                  TickerBuilder(
                    interval: const Duration(seconds: 15),
                    builder: (_) => Text(
                      acknowledgedBy != null
                          ? '$acknowledgedBy is on it · raised '
                                '${Fmt.ago(alert.createdAt, ServerClock.now())}'
                          : 'Raised ${Fmt.ago(alert.createdAt, ServerClock.now())}',
                      style: TextStyle(
                        fontSize: 13,
                        color: acknowledgedBy != null
                            ? LifelineColors.ok
                            : LifelineColors.muted,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (acknowledgedBy == null)
                  FilledButton.icon(
                    style: FilledButton.styleFrom(backgroundColor: color),
                    onPressed: _busy
                        ? null
                        : () => _run(
                            () => client.circle.acknowledgeAlert(
                              widget.circleId,
                              alert.id!,
                            ),
                          ),
                    icon: const Icon(Icons.directions_run_rounded),
                    label: const Text("I'm on it"),
                  ),
                if (acknowledgedBy == null) const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: _busy
                      ? null
                      : () => _run(
                          () => client.circle.resolveAlert(
                            widget.circleId,
                            alert.id!,
                          ),
                        ),
                  child: const Text('Resolve'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static IconData _iconFor(AlertKind kind) => switch (kind) {
    AlertKind.helpRequested => Icons.emergency_rounded,
    AlertKind.unresponsive => Icons.person_off_rounded,
    AlertKind.missedCheckIn => Icons.notifications_active_rounded,
    AlertKind.concern => Icons.chat_bubble_rounded,
  };
}
