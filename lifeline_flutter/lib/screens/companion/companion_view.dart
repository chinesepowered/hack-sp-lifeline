import 'package:flutter/material.dart';
import 'package:lifeline_client/lifeline_client.dart';

import '../../format.dart';
import '../../theme.dart';
import '../../widgets/common.dart';
import 'companion_controller.dart';

/// The loved one's screen: a calm clock most of the time, and three huge
/// buttons when Lifeline asks how they are.
class CompanionView extends StatefulWidget {
  final String deviceToken;

  /// Called when the server no longer recognizes this screen.
  final VoidCallback? onUnpaired;

  const CompanionView({super.key, required this.deviceToken, this.onUnpaired});

  @override
  State<CompanionView> createState() => _CompanionViewState();
}

class _CompanionViewState extends State<CompanionView> {
  late final CompanionController _c = CompanionController(widget.deviceToken)
    ..addListener(_changed);

  void _changed() {
    if (_c.live.fatal) widget.onUnpaired?.call();
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  Future<void> _run(Future<String?> Function() action) async {
    final problem = await action();
    if (problem != null && mounted) showSnack(context, problem, error: true);
  }

  @override
  Widget build(BuildContext context) {
    final state = _c.state;
    return Material(
      color: const Color(0xFFFFFBF5),
      child: Stack(
        children: [
          if (state == null)
            Center(
              child: _c.live.error != null
                  ? Text(
                      friendlyError(_c.live.error!),
                      style: const TextStyle(fontSize: 22),
                    )
                  : const CircularProgressIndicator(),
            )
          else
            _body(state),
          if (state != null && !_c.audioUnlocked)
            Positioned.fill(child: _TapToStart(onTap: _c.unlockAudio)),
        ],
      ),
    );
  }

  Widget _body(CompanionState s) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 720;
        final scale = (constraints.maxWidth / 1000).clamp(0.72, 1.25);
        final clock = _ClockPanel(state: s, scale: scale);
        final panel = _interaction(s, scale);
        return Column(
          children: [
            _TopBar(connected: _c.live.connected, name: s.lovedOneName),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  28 * scale,
                  8 * scale,
                  28 * scale,
                  12 * scale,
                ),
                child: wide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(flex: 9, child: clock),
                          SizedBox(width: 28 * scale),
                          Expanded(flex: 11, child: panel),
                        ],
                      )
                    : Column(
                        children: [
                          clock,
                          SizedBox(height: 16 * scale),
                          Expanded(child: panel),
                        ],
                      ),
              ),
            ),
            _CaptionBar(speaking: _c.speaking, scale: scale),
          ],
        );
      },
    );
  }

  Widget _interaction(CompanionState s, double scale) {
    final Widget child;
    if (s.helpActive) {
      child = _HelpPanel(
        key: const ValueKey('help'),
        state: s,
        scale: scale,
      );
    } else if (_c.recording) {
      child = _ListeningPanel(
        key: const ValueKey('listening'),
        levels: _c.recorder.levels,
        scale: scale,
        onDone: () => _run(_c.stopRecording),
        onCancel: _c.cancelRecording,
      );
    } else if (_c.thinking) {
      child = _ThinkingPanel(key: const ValueKey('thinking'), scale: scale);
    } else if (s.activeCheckIn != null) {
      child = _CheckInPanel(
        key: ValueKey('check-in-${s.activeCheckIn!.id}'),
        checkIn: s.activeCheckIn!,
        escalated: s.escalated,
        escalationAcknowledgedBy: s.escalationAcknowledgedBy,
        caregiverNames: s.caregiverNames,
        scale: scale,
        heard: _c.heard,
        busy: _c.busy,
        onOkay: () => _run(_c.imOkay),
        onTalk: () => _run(_c.startRecording),
        onHelp: () => _run(_c.needHelp),
      );
    } else {
      child = _IdlePanel(
        key: const ValueKey('idle'),
        state: s,
        scale: scale,
        heard: _c.heard,
        heardLevel: _c.heardLevel,
        busy: _c.busy,
        onReplay: _c.replay,
        onTalk: () => _run(_c.startRecording),
        onHelp: () => _run(_c.needHelp),
      );
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween(begin: 0.97, end: 1.0).animate(animation),
          child: child,
        ),
      ),
      child: child,
    );
  }
}

class _TopBar extends StatelessWidget {
  final bool connected;
  final String name;

  const _TopBar({required this.connected, required this.name});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(24, 16, 24, 4),
    child: Row(
      children: [
        const LifelineLogo(size: 26),
        const Spacer(),
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: connected ? LifelineColors.ok : LifelineColors.missed,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          connected ? 'Connected to your family' : 'Reconnecting…',
          style: const TextStyle(
            fontSize: 15,
            color: LifelineColors.muted,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

class _ClockPanel extends StatelessWidget {
  final CompanionState state;
  final double scale;

  const _ClockPanel({required this.state, required this.scale});

  @override
  Widget build(BuildContext context) => TickerBuilder(
    interval: const Duration(seconds: 5),
    builder: (context) {
      final now = DateTime.now();
      final hour = now.hour;
      final greeting = hour >= 4 && hour < 12
          ? 'Good morning'
          : hour >= 12 && hour < 17
          ? 'Good afternoon'
          : 'Good evening';
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Fmt.longDate(now),
            style: TextStyle(
              fontSize: 24 * scale,
              color: LifelineColors.muted,
              fontWeight: FontWeight.w700,
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              Fmt.time(now),
              style: TextStyle(
                fontSize: 104 * scale,
                fontWeight: FontWeight.w700,
                height: 1.05,
                letterSpacing: -2,
              ),
            ),
          ),
          SizedBox(height: 10 * scale),
          Text(
            '$greeting, ${state.lovedOneName}',
            style: TextStyle(
              fontSize: 34 * scale,
              fontWeight: FontWeight.w700,
              color: LifelineColors.teal,
            ),
          ),
          if (state.nextCheckInAt != null) ...[
            SizedBox(height: 8 * scale),
            Text(
              'Next check-in at ${Fmt.time(state.nextCheckInAt!)}',
              style: TextStyle(
                fontSize: 20 * scale,
                color: LifelineColors.muted,
              ),
            ),
          ],
        ],
      );
    },
  );
}

/// A huge, high-contrast button with an icon and a one or two word label.
class _BigButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;
  final double height;
  final double scale;

  const _BigButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onPressed,
    required this.scale,
    this.height = 96,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
    height: height * scale,
    child: FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: color,
        disabledBackgroundColor: color.withValues(alpha: 0.5),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24 * scale),
        ),
        elevation: 2,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 40 * scale),
            SizedBox(width: 14 * scale),
            Text(
              label,
              style: TextStyle(
                fontSize: 30 * scale,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class _SpeechBubble extends StatelessWidget {
  final String text;
  final double scale;
  final IconData icon;

  const _SpeechBubble({
    required this.text,
    required this.scale,
    this.icon = Icons.record_voice_over_rounded,
  });

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: EdgeInsets.all(22 * scale),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(26 * scale),
      border: Border.all(color: LifelineColors.line, width: 1.5),
      boxShadow: const [
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 18,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 34 * scale, color: LifelineColors.teal),
        SizedBox(width: 14 * scale),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 26 * scale,
              height: 1.3,
              color: LifelineColors.ink,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    ),
  );
}

class _CheckInPanel extends StatelessWidget {
  final CheckIn checkIn;
  final bool escalated;
  final String? escalationAcknowledgedBy;
  final List<String> caregiverNames;
  final double scale;
  final String? heard;
  final bool busy;
  final VoidCallback onOkay;
  final VoidCallback onTalk;
  final VoidCallback onHelp;

  const _CheckInPanel({
    super.key,
    required this.checkIn,
    required this.escalated,
    required this.escalationAcknowledgedBy,
    required this.caregiverNames,
    required this.scale,
    required this.heard,
    required this.busy,
    required this.onOkay,
    required this.onTalk,
    required this.onHelp,
  });

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      if (escalated) ...[
        _EscalationBanner(
          helper: escalationAcknowledgedBy,
          family: caregiverNames,
          scale: scale,
        ),
        SizedBox(height: 16 * scale),
      ],
      _SpeechBubble(
        text: checkIn.status == CheckInStatus.pending
            ? checkIn.promptText.split('Tap the green').first.trim()
            : 'Are you there? Please let your family know you’re okay.',
        scale: scale,
      ),
      SizedBox(height: 22 * scale),
      _BigButton(
        label: 'I’m okay',
        icon: Icons.check_circle_rounded,
        color: LifelineColors.ok,
        onPressed: busy ? null : onOkay,
        height: 118,
        scale: scale,
      ),
      SizedBox(height: 16 * scale),
      Row(
        children: [
          Expanded(
            child: _BigButton(
              label: 'Tell me',
              icon: Icons.mic_rounded,
              color: LifelineColors.teal,
              onPressed: busy ? null : onTalk,
              scale: scale,
            ),
          ),
          SizedBox(width: 16 * scale),
          Expanded(
            child: _BigButton(
              label: 'I need help',
              icon: Icons.emergency_rounded,
              color: LifelineColors.alert,
              onPressed: busy ? null : onHelp,
              scale: scale,
            ),
          ),
        ],
      ),
    ],
  );
}

/// Shown above the buttons once the family has been alerted that nobody
/// answered, so the loved one can still say they're fine.
class _EscalationBanner extends StatelessWidget {
  final String? helper;
  final List<String> family;
  final double scale;

  const _EscalationBanner({
    required this.helper,
    required this.family,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    final names = family.isEmpty
        ? 'your family'
        : family.map((n) => n.split(' ').first).join(' and ');
    final text = helper != null
        ? '$helper is checking on you now.'
        : 'Lifeline has let $names know.';
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20 * scale,
        vertical: 14 * scale,
      ),
      decoration: BoxDecoration(
        color: helper != null
            ? LifelineColors.okSoft
            : LifelineColors.alertSoft,
        borderRadius: BorderRadius.circular(20 * scale),
      ),
      child: Row(
        children: [
          Icon(
            helper != null
                ? Icons.directions_run_rounded
                : Icons.notifications_active_rounded,
            color: helper != null ? LifelineColors.ok : LifelineColors.alert,
            size: 32 * scale,
          ),
          SizedBox(width: 12 * scale),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 22 * scale,
                fontWeight: FontWeight.w700,
                color: helper != null
                    ? LifelineColors.ok
                    : LifelineColors.alert,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IdlePanel extends StatelessWidget {
  final CompanionState state;
  final double scale;
  final String? heard;
  final TriageLevel? heardLevel;
  final bool busy;
  final void Function(Utterance) onReplay;
  final VoidCallback onTalk;
  final VoidCallback onHelp;

  const _IdlePanel({
    super.key,
    required this.state,
    required this.scale,
    required this.heard,
    required this.heardLevel,
    required this.busy,
    required this.onReplay,
    required this.onTalk,
    required this.onHelp,
  });

  @override
  Widget build(BuildContext context) {
    final message = state.latestMessage;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (heard != null)
          _SpeechBubble(
            text: 'You said: “$heard”',
            scale: scale,
            icon: Icons.hearing_rounded,
          )
        else if (message != null)
          _MessageCard(message: message, scale: scale, onReplay: onReplay)
        else
          _SpeechBubble(
            text: 'All is well. Your family can see you’re okay.',
            scale: scale,
            icon: Icons.favorite_rounded,
          ),
        SizedBox(height: 22 * scale),
        _BigButton(
          label: 'Talk to my family',
          icon: Icons.mic_rounded,
          color: LifelineColors.teal,
          onPressed: busy ? null : onTalk,
          scale: scale,
        ),
        SizedBox(height: 16 * scale),
        _BigButton(
          label: 'I need help',
          icon: Icons.emergency_rounded,
          color: LifelineColors.alert,
          onPressed: busy ? null : onHelp,
          scale: scale,
        ),
      ],
    );
  }
}

class _MessageCard extends StatelessWidget {
  final Utterance message;
  final double scale;
  final void Function(Utterance) onReplay;

  const _MessageCard({
    required this.message,
    required this.scale,
    required this.onReplay,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(22 * scale),
    decoration: BoxDecoration(
      color: LifelineColors.tealSoft,
      borderRadius: BorderRadius.circular(26 * scale),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            InitialsAvatar(
              name: message.fromName ?? 'Family',
              size: 40 * scale,
            ),
            SizedBox(width: 12 * scale),
            Expanded(
              child: Text(
                'Message from ${message.fromName ?? 'your family'} · '
                '${Fmt.time(message.createdAt)}',
                style: TextStyle(
                  fontSize: 19 * scale,
                  fontWeight: FontWeight.w700,
                  color: LifelineColors.teal,
                ),
              ),
            ),
            IconButton(
              tooltip: 'Play the message again',
              iconSize: 44 * scale,
              onPressed: () => onReplay(message),
              icon: const Icon(
                Icons.play_circle_fill_rounded,
                color: LifelineColors.teal,
              ),
            ),
          ],
        ),
        SizedBox(height: 10 * scale),
        Text(
          message.text,
          style: TextStyle(
            fontSize: 26 * scale,
            height: 1.3,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

class _ListeningPanel extends StatelessWidget {
  final Stream<double> levels;
  final double scale;
  final VoidCallback onDone;
  final VoidCallback onCancel;

  const _ListeningPanel({
    super.key,
    required this.levels,
    required this.scale,
    required this.onDone,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      StreamBuilder<double>(
        stream: levels,
        initialData: 0,
        builder: (context, snapshot) {
          final level = snapshot.data ?? 0;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 90),
            width: (150 + 90 * level) * scale,
            height: (150 + 90 * level) * scale,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: LifelineColors.teal.withValues(alpha: 0.12 + 0.2 * level),
            ),
            alignment: Alignment.center,
            child: Container(
              width: 130 * scale,
              height: 130 * scale,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: LifelineColors.teal,
              ),
              child: Icon(
                Icons.mic_rounded,
                color: Colors.white,
                size: 70 * scale,
              ),
            ),
          );
        },
      ),
      SizedBox(height: 22 * scale),
      Text(
        'I’m listening…',
        style: TextStyle(fontSize: 34 * scale, fontWeight: FontWeight.w700),
      ),
      Text(
        'Tell me how you are, then tap “Done”.',
        style: TextStyle(fontSize: 22 * scale, color: LifelineColors.muted),
      ),
      SizedBox(height: 22 * scale),
      SizedBox(
        width: double.infinity,
        child: _BigButton(
          label: 'Done',
          icon: Icons.stop_circle_rounded,
          color: LifelineColors.teal,
          onPressed: onDone,
          scale: scale,
        ),
      ),
      TextButton(
        onPressed: onCancel,
        child: Text('Cancel', style: TextStyle(fontSize: 20 * scale)),
      ),
    ],
  );
}

class _ThinkingPanel extends StatelessWidget {
  final double scale;

  const _ThinkingPanel({super.key, required this.scale});

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox.square(
        dimension: 90 * scale,
        child: const CircularProgressIndicator(strokeWidth: 8),
      ),
      SizedBox(height: 24 * scale),
      Text(
        'Got it, one moment…',
        style: TextStyle(fontSize: 32 * scale, fontWeight: FontWeight.w700),
      ),
    ],
  );
}

class _HelpPanel extends StatefulWidget {
  final CompanionState state;
  final double scale;

  const _HelpPanel({super.key, required this.state, required this.scale});

  @override
  State<_HelpPanel> createState() => _HelpPanelState();
}

class _HelpPanelState extends State<_HelpPanel>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.state;
    final scale = widget.scale;
    final helper = s.helpAcknowledgedBy;
    final family = s.caregiverNames.isEmpty
        ? 'your family'
        : s.caregiverNames.map((n) => n.split(' ').first).join(' and ');
    final acknowledged = helper != null;
    final color = acknowledged ? LifelineColors.ok : LifelineColors.alert;
    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, child) => Container(
        padding: EdgeInsets.all(30 * scale),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30 * scale),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25 + 0.25 * _pulse.value),
              blurRadius: 24 + 20 * _pulse.value,
            ),
          ],
        ),
        child: child,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            acknowledged
                ? Icons.directions_run_rounded
                : Icons.notifications_active_rounded,
            color: Colors.white,
            size: 96 * scale,
          ),
          SizedBox(height: 16 * scale),
          Text(
            acknowledged ? '$helper is on it' : 'Help is on the way',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 42 * scale,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10 * scale),
          Text(
            acknowledged
                ? '$helper has seen your alert and is on it.'
                : 'We’ve alerted $family. Stay where you are.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 24 * scale),
          ),
        ],
      ),
    );
  }
}

class _CaptionBar extends StatelessWidget {
  final Utterance? speaking;
  final double scale;

  const _CaptionBar({required this.speaking, required this.scale});

  @override
  Widget build(BuildContext context) {
    final u = speaking;
    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      child: u == null
          ? SizedBox(width: double.infinity, height: 16 * scale)
          : Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(
                24 * scale,
                0,
                24 * scale,
                18 * scale,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 22 * scale,
                vertical: 16 * scale,
              ),
              decoration: BoxDecoration(
                color: LifelineColors.ink,
                borderRadius: BorderRadius.circular(20 * scale),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.volume_up_rounded,
                    color: Colors.white,
                    size: 30 * scale,
                  ),
                  SizedBox(width: 14 * scale),
                  Expanded(
                    child: Semantics(
                      liveRegion: true,
                      child: Text(
                        u.kind == UtteranceKind.familyMessage
                            ? '${u.fromName ?? 'Family'}: ${u.text}'
                            : u.text,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22 * scale,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class _TapToStart extends StatelessWidget {
  final VoidCallback onTap;

  const _TapToStart({required this.onTap});

  @override
  Widget build(BuildContext context) => Material(
    color: LifelineColors.ink.withValues(alpha: 0.82),
    child: InkWell(
      onTap: onTap,
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.touch_app_rounded, color: Colors.white, size: 84),
            SizedBox(height: 16),
            Text(
              'Tap anywhere to start',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'This lets Lifeline speak out loud.',
              style: TextStyle(color: Colors.white70, fontSize: 20),
            ),
          ],
        ),
      ),
    ),
  );
}
