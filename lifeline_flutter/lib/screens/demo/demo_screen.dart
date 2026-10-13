import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../client.dart';
import '../../platform/browser.dart';
import '../../state/stores.dart';
import '../../theme.dart';
import '../../widgets/common.dart';
import '../companion/companion_view.dart';
import '../family/dashboard_view.dart';

/// `/demo`: one click gives you both sides of Lifeline, live: Rose's tablet
/// on the left and Sam's family app on the right, talking to one Serverpod
/// backend. Nothing is mocked.
class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  DemoSession? _session;
  bool _starting = false;
  String? _error;

  Future<void> _start({bool fresh = false}) async {
    SpeechPlayer.unlock();
    setState(() {
      _starting = true;
      _error = null;
    });
    try {
      if (!client.auth.isAuthenticated) {
        Object? failure;
        await AnonymousAuthController(
          client: client,
          onError: (e) => failure = e,
        ).login();
        if (failure != null || !client.auth.isAuthenticated) {
          throw failure ?? StateError('Sign-in failed');
        }
      }

      var session = fresh ? null : DemoSession.load();
      if (session != null) {
        try {
          await client.circle.snapshot(session.circleId);
        } catch (_) {
          session = null;
        }
      }
      if (session == null) {
        final setup = await client.circle.createDemo(
          'Sam',
          DateTime.now().timeZoneOffset.inMinutes,
        );
        session = DemoSession(
          setup.circleId,
          setup.deviceToken,
          DateTime.now().toUtc(),
        )..save();
      }
      setState(() => _session = session);
    } catch (e) {
      setState(() => _error = friendlyError(e));
    } finally {
      if (mounted) setState(() => _starting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = _session;
    return Scaffold(
      backgroundColor: const Color(0xFFF1EBE1),
      body: SafeArea(
        child: Column(
          children: [
            _DemoBar(
              running: session != null,
              onReset: _starting ? null : () => _start(fresh: true),
            ),
            Expanded(
              child: session == null
                  ? _Intro(
                      starting: _starting,
                      error: _error,
                      onStart: () => _start(),
                    )
                  : _SplitView(
                      key: ValueKey(session.circleId),
                      session: session,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DemoBar extends StatelessWidget {
  final bool running;
  final VoidCallback? onReset;

  const _DemoBar({required this.running, required this.onReset});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(24, 14, 18, 6),
    child: Row(
      children: [
        InkWell(
          onTap: () => Navigator.of(context).pushNamed('/'),
          child: const LifelineLogo(size: 26),
        ),
        const SizedBox(width: 14),
        const Pill(
          label: 'LIVE DEMO',
          color: LifelineColors.heart,
          background: Color(0xFFFDE5DF),
          icon: Icons.circle,
        ),
        const SizedBox(width: 14),
        const Expanded(
          child: Text(
            'Two real apps, one Serverpod backend. Everything updates live.',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: LifelineColors.muted, fontSize: 15),
          ),
        ),
        if (running)
          TextButton.icon(
            onPressed: onReset,
            icon: const Icon(Icons.restart_alt_rounded),
            label: const Text('New demo'),
          ),
      ],
    ),
  );
}

class _Intro extends StatelessWidget {
  final bool starting;
  final String? error;
  final VoidCallback onStart;

  const _Intro({
    required this.starting,
    required this.error,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) => Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LifelineMark(size: 56),
                const SizedBox(height: 16),
                const Text(
                  'Meet Rose and Sam',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Rose is 84 and lives alone. Sam, her daughter, lives an hour '
                  'away. On the left is Rose’s kitchen tablet; on the right, '
                  'Sam’s family app. Turn your sound on.',
                  style: TextStyle(fontSize: 17, height: 1.4),
                ),
                const SizedBox(height: 18),
                for (final step in const [
                  (
                    'Press “Check in with Rose now”',
                    Icons.record_voice_over_rounded,
                  ),
                  (
                    'Answer on the tablet: a button, or your voice',
                    Icons.mic_rounded,
                  ),
                  (
                    'Or ignore it, and watch Lifeline escalate',
                    Icons.campaign_rounded,
                  ),
                  (
                    'Send Rose a message: she hears it out loud',
                    Icons.chat_rounded,
                  ),
                ])
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Icon(step.$2, color: LifelineColors.teal, size: 22),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            step.$1,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 20),
                if (error != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      error!,
                      style: const TextStyle(color: LifelineColors.alert),
                    ),
                  ),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: starting ? null : onStart,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(58),
                      textStyle: const TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    icon: starting
                        ? const SizedBox.square(
                            dimension: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.play_arrow_rounded),
                    label: Text(
                      starting
                          ? 'Setting up Rose’s home…'
                          : 'Start the live demo',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Creates a private sandbox circle that deletes itself after '
                  '12 hours. Escalation timers are shortened to seconds.',
                  style: TextStyle(fontSize: 13, color: LifelineColors.muted),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class _SplitView extends StatelessWidget {
  final DemoSession session;

  const _SplitView({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final tablet = CompanionView(deviceToken: session.deviceToken);
    final family = DashboardView(circleId: session.circleId, embedded: true);
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 1100) {
          return DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(text: 'Rose’s tablet'),
                    Tab(text: 'Sam’s family app'),
                  ],
                ),
                Expanded(child: TabBarView(children: [tablet, family])),
              ],
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.fromLTRB(18, 4, 18, 18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 47,
                child: _Labeled(
                  label: 'Rose’s tablet · at home',
                  icon: Icons.tablet_mac_rounded,
                  child: _TabletFrame(child: tablet),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                flex: 53,
                child: _Labeled(
                  label: 'Sam’s family app',
                  icon: Icons.phone_iphone_rounded,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: ColoredBox(
                      color: LifelineColors.paper,
                      child: family,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Labeled extends StatelessWidget {
  final String label;
  final IconData icon;
  final Widget child;

  const _Labeled({
    required this.label,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 6, bottom: 8),
        child: Row(
          children: [
            Icon(icon, size: 18, color: LifelineColors.muted),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: LifelineColors.muted,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
      Expanded(child: child),
    ],
  );
}

class _TabletFrame extends StatelessWidget {
  final Widget child;

  const _TabletFrame({required this.child});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFF22272B),
      borderRadius: BorderRadius.circular(34),
      boxShadow: const [
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 30,
          offset: Offset(0, 12),
        ),
      ],
    ),
    child: ClipRRect(borderRadius: BorderRadius.circular(22), child: child),
  );
}
