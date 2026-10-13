import 'package:flutter/material.dart';
import 'package:lifeline_client/lifeline_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../../client.dart';
import '../../theme.dart';
import '../../widgets/common.dart';
import 'dashboard_view.dart';
import 'settings_form.dart';

/// `/family`: sign in, create or join a circle, then the live dashboard.
class FamilyHome extends StatefulWidget {
  const FamilyHome({super.key});

  @override
  State<FamilyHome> createState() => _FamilyHomeState();
}

class _FamilyHomeState extends State<FamilyHome> {
  @override
  void initState() {
    super.initState();
    client.auth.authInfoListenable.addListener(_authChanged);
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(_authChanged);
    super.dispose();
  }

  void _authChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) =>
      client.auth.isAuthenticated ? const _Circles() : const _SignInPage();
}

class _SignInPage extends StatelessWidget {
  const _SignInPage();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const LifelineLogo()),
    body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Column(
            children: [
              const Text(
                'Look after the people you love',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              const Text(
                'Sign in to see how your family is doing and to get alerts.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: LifelineColors.muted),
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: SignInWidget(
                    client: client,
                    onError: (error) => showSnack(
                      context,
                      'Sign-in failed: $error',
                      error: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _Circles extends StatefulWidget {
  const _Circles();

  @override
  State<_Circles> createState() => _CirclesState();
}

class _CirclesState extends State<_Circles> {
  List<CircleSummary>? _circles;
  int? _selected;
  bool _onboarding = false;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load({int? select}) async {
    try {
      final circles = await client.circle.myCircles();
      setState(() {
        _circles = circles;
        _error = null;
        _onboarding = circles.isEmpty;
        _selected =
            select ??
            (circles.any((c) => c.circleId == _selected)
                ? _selected
                : circles.firstOrNull?.circleId);
      });
    } catch (e) {
      setState(() => _error = e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final circles = _circles;
    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(friendlyError(_error!)),
              const SizedBox(height: 12),
              OutlinedButton(onPressed: _load, child: const Text('Retry')),
            ],
          ),
        ),
      );
    }
    if (circles == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_onboarding || _selected == null) {
      return _Onboarding(
        canCancel: circles.isNotEmpty,
        onCancel: () => setState(() => _onboarding = false),
        onDone: (circleId) => _load(select: circleId),
      );
    }

    final current = circles.firstWhere((c) => c.circleId == _selected);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        title: Row(
          children: [
            const LifelineLogo(),
            const SizedBox(width: 24),
            if (circles.length > 1)
              DropdownButton<int>(
                value: _selected,
                underline: const SizedBox.shrink(),
                items: [
                  for (final c in circles)
                    DropdownMenuItem(
                      value: c.circleId,
                      child: Text(
                        '${c.lovedOneName}${c.isDemo ? ' (demo)' : ''}',
                      ),
                    ),
                ],
                onChanged: (id) => setState(() => _selected = id),
              )
            else
              Text(
                '${current.lovedOneName}’s circle',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            tooltip: 'Menu',
            icon: const Icon(Icons.account_circle_rounded, size: 30),
            onSelected: (value) async {
              if (value == 'new') setState(() => _onboarding = true);
              if (value == 'signout') await client.auth.signOutDevice();
            },
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: 'new',
                child: Text('Create or join a circle'),
              ),
              PopupMenuItem(value: 'signout', child: Text('Sign out')),
            ],
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1240),
          child: DashboardView(
            key: ValueKey(_selected),
            circleId: _selected!,
          ),
        ),
      ),
    );
  }
}

class _Onboarding extends StatefulWidget {
  final bool canCancel;
  final VoidCallback onCancel;
  final ValueChanged<int> onDone;

  const _Onboarding({
    required this.canCancel,
    required this.onCancel,
    required this.onDone,
  });

  @override
  State<_Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<_Onboarding> {
  final _myName = TextEditingController();
  final _relationship = TextEditingController();
  final _invite = TextEditingController();
  SettingsDraft? _draft;
  List<VoiceOption> _voices = const [];
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    client.circle.voices().then(
      (voices) {
        if (!mounted) return;
        setState(() {
          _voices = voices;
          _draft = SettingsDraft(voiceId: voices.first.voiceId);
        });
      },
      onError: (Object e) {
        if (mounted) showSnack(context, friendlyError(e), error: true);
      },
    );
  }

  @override
  void dispose() {
    _myName.dispose();
    _relationship.dispose();
    _invite.dispose();
    super.dispose();
  }

  Future<void> _submit(Future<CircleSnapshot> Function() action) async {
    setState(() => _busy = true);
    try {
      final snapshot = await action();
      widget.onDone(snapshot.circle.id!);
    } catch (e) {
      if (mounted) showSnack(context, friendlyError(e), error: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Widget _aboutMe() => Row(
    children: [
      Expanded(
        child: TextField(
          controller: _myName,
          decoration: const InputDecoration(labelText: 'Your first name'),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: TextField(
          controller: _relationship,
          decoration: const InputDecoration(
            labelText: 'Relationship',
            hintText: 'e.g. Daughter',
          ),
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final draft = _draft;
    return Scaffold(
      appBar: AppBar(
        title: const LifelineLogo(),
        leading: widget.canCancel
            ? IconButton(
                onPressed: widget.onCancel,
                icon: const Icon(Icons.close_rounded),
              )
            : null,
      ),
      body: draft == null
          ? const Center(child: CircularProgressIndicator())
          : DefaultTabController(
              length: 2,
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: Column(
                    children: [
                      const TabBar(
                        tabs: [
                          Tab(text: 'Start a care circle'),
                          Tab(text: 'Join with an invite code'),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            ListView(
                              padding: const EdgeInsets.all(24),
                              children: [
                                const Text(
                                  'Who are we looking after?',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                SettingsForm(draft: draft, voices: _voices),
                                const SizedBox(height: 22),
                                const Text(
                                  'About you',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                _aboutMe(),
                                const SizedBox(height: 24),
                                FilledButton(
                                  onPressed: _busy
                                      ? null
                                      : () => _submit(
                                          () => client.circle.createCircle(
                                            draft.toSettings(),
                                            _myName.text,
                                            _relationship.text,
                                          ),
                                        ),
                                  child: const Text('Create the circle'),
                                ),
                              ],
                            ),
                            ListView(
                              padding: const EdgeInsets.all(24),
                              children: [
                                TextField(
                                  controller: _invite,
                                  textCapitalization:
                                      TextCapitalization.characters,
                                  decoration: const InputDecoration(
                                    labelText: 'Invite code',
                                    helperText:
                                        'Ask whoever started the circle for it',
                                  ),
                                ),
                                const SizedBox(height: 16),
                                _aboutMe(),
                                const SizedBox(height: 24),
                                FilledButton(
                                  onPressed: _busy
                                      ? null
                                      : () => _submit(
                                          () => client.circle.joinCircle(
                                            _invite.text,
                                            _myName.text,
                                            _relationship.text,
                                          ),
                                        ),
                                  child: const Text('Join the circle'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
