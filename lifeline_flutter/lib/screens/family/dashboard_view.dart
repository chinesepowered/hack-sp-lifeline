import 'package:flutter/material.dart';
import 'package:lifeline_client/lifeline_client.dart';

import '../../client.dart';
import '../../state/live_stream.dart';
import '../../theme.dart';
import '../../widgets/common.dart';
import 'actions_card.dart';
import 'alerts_panel.dart';
import 'circle_info_card.dart';
import 'history_card.dart';
import 'status_hero.dart';
import 'timeline_card.dart';

/// The family's live view of a circle, fed by `client.circle.watch`.
class DashboardView extends StatefulWidget {
  final int circleId;

  /// Inside the demo's split screen: tighter padding.
  final bool embedded;

  const DashboardView({
    super.key,
    required this.circleId,
    this.embedded = false,
  });

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late final LiveStream<CircleSnapshot> _live;
  List<VoiceOption> _voices = const [];

  @override
  void initState() {
    super.initState();
    _live =
        LiveStream(
            () => client.circle.watch(widget.circleId),
            poll: () => client.circle.snapshot(widget.circleId),
          )
          ..addListener(_onUpdate)
          ..start();
    client.circle.voices().then((v) {
      if (mounted) setState(() => _voices = v);
    }, onError: (_) {});
  }

  void _onUpdate() {
    final value = _live.value;
    if (value != null) ServerClock.sync(value.serverTime);
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _live.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final snapshot = _live.value;
    if (snapshot == null) {
      if (_live.error != null) {
        return _Problem(
          message: friendlyError(_live.error!),
          onRetry: _live.fatal ? null : _live.reconnect,
        );
      }
      return const Center(child: CircularProgressIndicator());
    }

    final pad = widget.embedded ? 18.0 : 24.0;
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 900;
        final left = <Widget>[
          ActionsCard(snapshot: snapshot, voices: _voices),
          const SizedBox(height: 16),
          HistoryCard(snapshot: snapshot),
        ];
        final right = <Widget>[
          TimelineCard(snapshot: snapshot),
          const SizedBox(height: 16),
          CircleInfoCard(snapshot: snapshot, voices: _voices),
        ];
        return Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(pad, pad - 4, pad, pad + 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  StatusHero(snapshot: snapshot),
                  AlertsPanel(snapshot: snapshot),
                  const SizedBox(height: 16),
                  if (wide)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 11,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: left,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: right,
                          ),
                        ),
                      ],
                    )
                  else ...[
                    ...left,
                    const SizedBox(height: 16),
                    ...right,
                  ],
                ],
              ),
            ),
            if (!_live.connected)
              const Positioned(
                top: 8,
                right: 8,
                child: Pill(
                  label: 'Reconnecting…',
                  color: LifelineColors.missed,
                  background: LifelineColors.missedSoft,
                  icon: Icons.wifi_off_rounded,
                ),
              ),
          ],
        );
      },
    );
  }
}

class _Problem extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const _Problem({required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.cloud_off_rounded,
            size: 48,
            color: LifelineColors.muted,
          ),
          const SizedBox(height: 12),
          Text(message, textAlign: TextAlign.center),
          if (onRetry != null) ...[
            const SizedBox(height: 12),
            OutlinedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ],
      ),
    ),
  );
}
