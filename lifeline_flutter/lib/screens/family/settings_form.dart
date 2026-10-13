import 'package:flutter/material.dart';
import 'package:lifeline_client/lifeline_client.dart';

import '../../client.dart';
import '../../format.dart';
import '../../platform/browser.dart';
import '../../theme.dart';
import '../../widgets/common.dart';

/// Editable copy of a circle's settings.
class SettingsDraft {
  String lovedOneName;
  String voiceId;
  Set<int> slotMinutes;
  int graceSeconds;
  int secondGraceSeconds;

  SettingsDraft({
    this.lovedOneName = '',
    required this.voiceId,
    Set<int>? slotMinutes,
    this.graceSeconds = 15 * 60,
    this.secondGraceSeconds = 15 * 60,
  }) : slotMinutes = slotMinutes ?? {9 * 60, 19 * 60};

  factory SettingsDraft.from(Circle circle, List<CheckInSlot> slots) =>
      SettingsDraft(
        lovedOneName: circle.lovedOneName,
        voiceId: circle.voiceId,
        slotMinutes: slots.map((s) => s.minuteOfDay).toSet(),
        graceSeconds: circle.graceSeconds,
        secondGraceSeconds: circle.secondGraceSeconds,
      );

  CircleSettings toSettings() => CircleSettings(
    lovedOneName: lovedOneName.trim(),
    voiceId: voiceId,
    utcOffsetMinutes: DateTime.now().timeZoneOffset.inMinutes,
    slotMinutes: slotMinutes.toList()..sort(),
    graceSeconds: graceSeconds,
    secondGraceSeconds: secondGraceSeconds,
  );
}

const _windows = <int, String>{
  20: '20 seconds (demo)',
  120: '2 minutes',
  300: '5 minutes',
  900: '15 minutes',
  1800: '30 minutes',
  3600: '1 hour',
};

const _presetTimes = [
  8 * 60,
  9 * 60,
  12 * 60,
  15 * 60,
  18 * 60,
  19 * 60,
  21 * 60,
];

/// The fields shared by "create a circle" and "settings".
class SettingsForm extends StatefulWidget {
  final SettingsDraft draft;
  final List<VoiceOption> voices;
  final bool showName;

  const SettingsForm({
    super.key,
    required this.draft,
    required this.voices,
    this.showName = true,
  });

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _player = SpeechPlayer();
  String? _previewing;

  SettingsDraft get d => widget.draft;

  @override
  void dispose() {
    _player.stop();
    super.dispose();
  }

  Future<void> _preview(VoiceOption voice) async {
    setState(() => _previewing = voice.voiceId);
    try {
      final name = d.lovedOneName.trim().isEmpty ? 'there' : d.lovedOneName;
      final url = await client.circle.previewVoice(voice.voiceId, name);
      if (url != null) {
        await _player.playUrl(url);
      } else {
        await _player.speakFallback("Hello $name, I'm ${voice.name}.");
      }
    } catch (e) {
      if (mounted) showSnack(context, friendlyError(e), error: true);
    } finally {
      if (mounted) setState(() => _previewing = null);
    }
  }

  Future<void> _addCustomTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 0),
    );
    if (picked != null) {
      setState(() => d.slotMinutes.add(picked.hour * 60 + picked.minute));
    }
  }

  @override
  Widget build(BuildContext context) {
    final times = {..._presetTimes, ...d.slotMinutes}.toList()..sort();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showName) ...[
          TextFormField(
            initialValue: d.lovedOneName,
            decoration: const InputDecoration(
              labelText: 'Their first name',
              hintText: 'e.g. Rose',
              helperText: 'The companion uses it when speaking',
            ),
            onChanged: (v) => d.lovedOneName = v,
          ),
          const SizedBox(height: 22),
        ],
        const _Label('Daily check-in times'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final minute in times)
              FilterChip(
                label: Text(Fmt.minuteOfDay(minute)),
                selected: d.slotMinutes.contains(minute),
                onSelected: (on) => setState(() {
                  if (on) {
                    d.slotMinutes.add(minute);
                  } else if (d.slotMinutes.length > 1) {
                    d.slotMinutes.remove(minute);
                  }
                }),
              ),
            ActionChip(
              avatar: const Icon(Icons.add_rounded, size: 18),
              label: const Text('Other time'),
              onPressed: _addCustomTime,
            ),
          ],
        ),
        const SizedBox(height: 22),
        Row(
          children: [
            Expanded(
              child: _WindowPicker(
                label: 'Alert family if no answer after',
                value: d.graceSeconds,
                onChanged: (v) => setState(() => d.graceSeconds = v),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _WindowPicker(
                label: 'Then mark urgent after',
                value: d.secondGraceSeconds,
                onChanged: (v) => setState(() => d.secondGraceSeconds = v),
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        const _Label('Companion voice (ElevenLabs)'),
        RadioGroup<String>(
          groupValue: d.voiceId,
          onChanged: (v) => setState(() => d.voiceId = v!),
          child: Column(
            children: [
              for (final voice in widget.voices)
                RadioListTile<String>(
                  value: voice.voiceId,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    voice.name,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text(voice.description),
                  secondary: IconButton(
                    tooltip: 'Hear ${voice.name}',
                    onPressed: _previewing == null
                        ? () => _preview(voice)
                        : null,
                    icon: _previewing == voice.voiceId
                        ? const SizedBox.square(
                            dimension: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(
                            Icons.play_circle_fill_rounded,
                            color: LifelineColors.teal,
                            size: 30,
                          ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _WindowPicker extends StatelessWidget {
  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  const _WindowPicker({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final options = {..._windows};
    options.putIfAbsent(value, () => Fmt.duration(value));
    return DropdownButtonFormField<int>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(labelText: label),
      items: [
        for (final entry in options.entries)
          DropdownMenuItem(value: entry.key, child: Text(entry.value)),
      ],
      onChanged: (v) => onChanged(v!),
    );
  }
}

class _Label extends StatelessWidget {
  final String text;

  const _Label(this.text);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
    ),
  );
}

Future<void> showSettingsDialog(
  BuildContext context,
  CircleSnapshot snapshot,
  List<VoiceOption> voices,
) async {
  final draft = SettingsDraft.from(snapshot.circle, snapshot.slots);
  await showDialog<void>(
    context: context,
    builder: (context) {
      var saving = false;
      return StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Circle settings'),
          content: SizedBox(
            width: 560,
            child: SingleChildScrollView(
              child: SettingsForm(draft: draft, voices: voices),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: saving
                  ? null
                  : () async {
                      setState(() => saving = true);
                      try {
                        await client.circle.updateSettings(
                          snapshot.circle.id!,
                          draft.toSettings(),
                        );
                        if (context.mounted) Navigator.pop(context);
                      } catch (e) {
                        setState(() => saving = false);
                        if (context.mounted) {
                          showSnack(context, friendlyError(e), error: true);
                        }
                      }
                    },
              child: const Text('Save'),
            ),
          ],
        ),
      );
    },
  );
}
