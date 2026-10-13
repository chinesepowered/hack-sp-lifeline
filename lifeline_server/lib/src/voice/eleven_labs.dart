import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

/// Text-to-speech and speech-to-text, abstracted so tests can use a fake.
abstract interface class VoiceEngine {
  /// Synthesizes [text] with [voiceId] and returns MP3 bytes.
  Future<Uint8List> synthesize({
    required String text,
    required String voiceId,
    required String modelId,
  });

  /// Transcribes recorded audio and returns the text.
  Future<String> transcribe({
    required Uint8List audio,
    required String mimeType,
  });
}

class ElevenLabsException implements Exception {
  final int statusCode;
  final String body;

  ElevenLabsException(this.statusCode, this.body);

  @override
  String toString() => 'ElevenLabsException($statusCode): $body';
}

/// Minimal ElevenLabs REST client: TTS and Scribe speech-to-text.
class ElevenLabsEngine implements VoiceEngine {
  static final _base = Uri.parse('https://api.elevenlabs.io');

  final String apiKey;
  final http.Client _http;

  ElevenLabsEngine(this.apiKey, {http.Client? httpClient})
    : _http = httpClient ?? http.Client();

  @override
  Future<Uint8List> synthesize({
    required String text,
    required String voiceId,
    required String modelId,
  }) async {
    final uri = _base.replace(
      path: '/v1/text-to-speech/$voiceId',
      queryParameters: {'output_format': 'mp3_44100_128'},
    );
    final response = await _http.post(
      uri,
      headers: {
        'xi-api-key': apiKey,
        'Content-Type': 'application/json',
        'Accept': 'audio/mpeg',
      },
      body: jsonEncode({
        'text': text,
        'model_id': modelId,
        'voice_settings': {
          // A touch slower and steadier than default: easier to follow for
          // older listeners and people with hearing loss.
          'stability': 0.6,
          'similarity_boost': 0.8,
          'speed': 0.92,
        },
      }),
    );
    if (response.statusCode != 200) {
      throw ElevenLabsException(response.statusCode, response.body);
    }
    return response.bodyBytes;
  }

  @override
  Future<String> transcribe({
    required Uint8List audio,
    required String mimeType,
  }) async {
    final request =
        http.MultipartRequest('POST', _base.replace(path: '/v1/speech-to-text'))
          ..headers['xi-api-key'] = apiKey
          ..fields['model_id'] = 'scribe_v2'
          ..fields['tag_audio_events'] = 'false'
          ..files.add(
            http.MultipartFile.fromBytes(
              'file',
              audio,
              filename: 'answer.${_extensionFor(mimeType)}',
            ),
          );
    final streamed = await _http.send(request);
    final body = await streamed.stream.bytesToString();
    if (streamed.statusCode != 200) {
      throw ElevenLabsException(streamed.statusCode, body);
    }
    final json = jsonDecode(body) as Map<String, dynamic>;
    return (json['text'] as String? ?? '').trim();
  }

  static String _extensionFor(String mimeType) {
    if (mimeType.contains('webm')) return 'webm';
    if (mimeType.contains('ogg')) return 'ogg';
    if (mimeType.contains('mp4') || mimeType.contains('aac')) return 'm4a';
    if (mimeType.contains('wav')) return 'wav';
    if (mimeType.contains('mpeg') || mimeType.contains('mp3')) return 'mp3';
    return 'webm';
  }
}
