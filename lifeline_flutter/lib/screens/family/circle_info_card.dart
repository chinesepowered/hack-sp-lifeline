import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifeline_client/lifeline_client.dart';

import '../../client.dart';
import '../../format.dart';
import '../../theme.dart';
import '../../widgets/common.dart';
import 'settings_form.dart';

/// Who is in the circle, the schedule, and the codes to add people/screens.
class CircleInfoCard extends StatelessWidget {
  final CircleSnapshot snapshot;
  final List<VoiceOption> voices;

  const CircleInfoCard({
    super.key,
    required this.snapshot,
    required this.voices,
  });

  @override
  Widget build(BuildContext context) {
    final circle = snapshot.circle;
    final voice = voices.where((v) => v.voiceId == circle.voiceId).firstOrNull;

    return SectionCard(
      title: '${circle.lovedOneName}’s circle',
      icon: Icons.diversity_1_rounded,
      trailing: TextButton.icon(
        onPressed: () => showSettingsDialog(context, snapshot, voices),
        icon: const Icon(Icons.tune_rounded, size: 18),
        label: const Text('Settings'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final member in snapshot.members)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  InitialsAvatar(name: member.displayName, size: 34),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: member.displayName,
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          if (member.relationship?.isNotEmpty ?? false)
                            TextSpan(
                              text: ' · ${member.relationship}',
                              style: const TextStyle(
                                color: LifelineColors.muted,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (member.role == MemberRole.owner)
                    const Pill(
                      label: 'Organizer',
                      color: LifelineColors.teal,
                      background: LifelineColors.tealSoft,
                    ),
                ],
              ),
            ),
          const Divider(height: 22),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final slot in snapshot.slots)
                Chip(
                  avatar: const Icon(Icons.schedule_rounded, size: 16),
                  label: Text(
                    '${slot.label} · ${Fmt.minuteOfDay(slot.minuteOfDay)}',
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Voice: ${voice?.name ?? 'Custom'} (ElevenLabs) · '
            'escalates after ${Fmt.duration(circle.graceSeconds)}, then '
            '${Fmt.duration(circle.secondGraceSeconds)} more',
            style: const TextStyle(color: LifelineColors.muted, fontSize: 13.5),
          ),
          const Divider(height: 28),
          _CodeRow(
            label: 'Pair a tablet',
            hint: 'Open /tablet on the tablet and enter this code',
            code: circle.pairingCode,
            onRefresh: () => client.circle.newPairingCode(circle.id!),
          ),
          const SizedBox(height: 12),
          _CodeRow(
            label: 'Invite family',
            hint: 'Family members enter this in the Lifeline app',
            code: circle.inviteCode,
          ),
        ],
      ),
    );
  }
}

class _CodeRow extends StatelessWidget {
  final String label;
  final String hint;
  final String code;
  final Future<String> Function()? onRefresh;

  const _CodeRow({
    required this.label,
    required this.hint,
    required this.code,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
            Text(
              hint,
              style: const TextStyle(
                fontSize: 12.5,
                color: LifelineColors.muted,
              ),
            ),
          ],
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: LifelineColors.tealSoft,
          borderRadius: BorderRadius.circular(10),
        ),
        child: SelectableText(
          code,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 3,
            color: LifelineColors.teal,
          ),
        ),
      ),
      IconButton(
        tooltip: 'Copy $label code',
        onPressed: () {
          Clipboard.setData(ClipboardData(text: code));
          showSnack(context, 'Copied $code');
        },
        icon: const Icon(Icons.copy_rounded, size: 20),
      ),
      if (onRefresh != null)
        IconButton(
          tooltip: 'New code',
          onPressed: () async {
            try {
              await onRefresh!();
            } catch (e) {
              if (context.mounted) {
                showSnack(context, friendlyError(e), error: true);
              }
            }
          },
          icon: const Icon(Icons.refresh_rounded, size: 20),
        ),
    ],
  );
}
