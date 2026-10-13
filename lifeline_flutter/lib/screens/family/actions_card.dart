import 'package:flutter/material.dart';
import 'package:lifeline_client/lifeline_client.dart';

import '../../client.dart';
import '../../theme.dart';
import '../../widgets/common.dart';

/// "Check in now" and typed messages that are spoken on the tablet.
class ActionsCard extends StatefulWidget {
  final CircleSnapshot snapshot;
  final List<VoiceOption> voices;

  const ActionsCard({super.key, required this.snapshot, required this.voices});

  @override
  State<ActionsCard> createState() => _ActionsCardState();
}

class _ActionsCardState extends State<ActionsCard> {
  final _message = TextEditingController();
  bool _checkingIn = false;
  bool _sending = false;

  @override
  void dispose() {
    _message.dispose();
    super.dispose();
  }

  int get _circleId => widget.snapshot.circle.id!;

  Future<void> _checkInNow() async {
    setState(() => _checkingIn = true);
    try {
      await client.circle.checkInNow(_circleId);
    } catch (e) {
      if (mounted) showSnack(context, friendlyError(e), error: true);
    } finally {
      if (mounted) setState(() => _checkingIn = false);
    }
  }

  Future<void> _send([String? preset]) async {
    final text = (preset ?? _message.text).trim();
    if (text.isEmpty) return;
    setState(() => _sending = true);
    try {
      await client.circle.sendMessage(_circleId, text);
      _message.clear();
      if (mounted) {
        showSnack(
          context,
          'Sent. ${widget.snapshot.circle.lovedOneName} will hear it now.',
        );
      }
    } catch (e) {
      if (mounted) showSnack(context, friendlyError(e), error: true);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final circle = widget.snapshot.circle;
    final name = circle.lovedOneName;
    final active = widget.snapshot.activeCheckIn != null;
    final voiceName =
        widget.voices
            .where((v) => v.voiceId == circle.voiceId)
            .firstOrNull
            ?.name ??
        'the companion';
    final first = widget.snapshot.me.displayName.split(' ').first;

    return SectionCard(
      title: 'Reach out to $name',
      icon: Icons.volunteer_activism_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FilledButton.icon(
            onPressed: active || _checkingIn ? null : _checkInNow,
            icon: _checkingIn
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.record_voice_over_rounded),
            label: Text(
              active ? 'Check-in in progress…' : 'Check in with $name now',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _message,
            minLines: 1,
            maxLines: 3,
            maxLength: 400,
            textInputAction: TextInputAction.send,
            onSubmitted: (_) => _send(),
            decoration: InputDecoration(
              labelText: 'Message for $name',
              hintText: 'Type a message to be read aloud…',
              helperText: 'Spoken on $name’s tablet in $voiceName’s voice',
              counterText: '',
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 6),
                child: IconButton(
                  tooltip: 'Send message',
                  onPressed: _sending ? null : () => _send(),
                  icon: _sending
                      ? const SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(
                          Icons.send_rounded,
                          color: LifelineColors.teal,
                        ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final preset in [
                "I'm on my way, see you soon.",
                'Love you! Call you tonight. $first',
                "Don't forget your afternoon tablets.",
              ])
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(0, 38),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    textStyle: const TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    foregroundColor: LifelineColors.ink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _sending ? null : () => _send(preset),
                  child: Text(preset),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
