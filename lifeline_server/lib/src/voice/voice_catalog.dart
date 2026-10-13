import '../generated/protocol.dart';

/// Curated ElevenLabs voices that suit a calm, friendly companion.
abstract final class VoiceCatalog {
  static final voices = <VoiceOption>[
    VoiceOption(
      voiceId: 'hpp4J3VqNfWAUOO0d1Us',
      name: 'Bella',
      description: 'Warm and bright, American',
    ),
    VoiceOption(
      voiceId: 'Xb7hH8MSUJpSbSDYk0k2',
      name: 'Alice',
      description: 'Clear and kind, British',
    ),
    VoiceOption(
      voiceId: 'XrExE9yKIg1WjnnlVkGX',
      name: 'Matilda',
      description: 'Friendly and upbeat, American',
    ),
    VoiceOption(
      voiceId: 'JBFqnCBsd6RMkjVDRZzb',
      name: 'George',
      description: 'Warm storyteller, British',
    ),
    VoiceOption(
      voiceId: 'nPczCjzI2devNBz1zQrb',
      name: 'Brian',
      description: 'Deep and comforting, American',
    ),
  ];

  static String get defaultVoiceId => voices.first.voiceId;

  static bool isKnown(String voiceId) =>
      voices.any((voice) => voice.voiceId == voiceId);
}
