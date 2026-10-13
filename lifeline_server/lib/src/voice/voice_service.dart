import 'dart:async';
import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../common/codes.dart';
import '../generated/protocol.dart';
import 'eleven_labs.dart';

/// Speaks and listens through ElevenLabs.
///
/// Every synthesized sentence is content-addressed (model + voice + text) and
/// stored once in Serverpod file storage, indexed by the [VoiceClip] table.
/// Repeated phrases ("Wonderful, thank you Rose!") never hit the API twice,
/// and the `/voice/` web route can serve them with immutable cache headers.
abstract final class VoiceService {
  static const storageId = 'public';
  static const modelId = 'eleven_multilingual_v2';
  static const _apiKeyName = 'elevenLabsApiKey';

  /// Replaces the ElevenLabs engine, e.g. with a fake in tests.
  static VoiceEngine? engineOverride;

  static VoiceEngine? _engine;
  static String? _engineKey;

  static VoiceEngine? _engineFor(Session session) {
    if (engineOverride != null) return engineOverride;
    final key = session.passwords[_apiKeyName];
    if (key == null || key.isEmpty) return null;
    if (_engine == null || _engineKey != key) {
      _engine = ElevenLabsEngine(key);
      _engineKey = key;
    }
    return _engine;
  }

  static bool isAvailable(Session session) => _engineFor(session) != null;

  /// Returns the clip path (relative to the `/voice/` route) for [text]
  /// spoken in [voiceId], synthesizing and storing it on first use.
  ///
  /// Returns null if speech is unavailable; callers still save the text and
  /// the app falls back to the browser's own speech synthesis.
  static Future<String?> speak(
    Session session, {
    required String text,
    required String voiceId,
  }) async {
    final hash = Codes.contentHash([modelId, voiceId, text]);
    final fileName = '$hash.mp3';

    final cached = await VoiceClip.db.findFirstRow(
      session,
      where: (t) => t.hash.equals(hash),
    );
    if (cached != null) return fileName;

    final engine = _engineFor(session);
    if (engine == null) {
      session.log(
        'ElevenLabs key not configured; skipping speech synthesis.',
        level: LogLevel.warning,
      );
      return null;
    }

    try {
      final bytes = await engine
          .synthesize(text: text, voiceId: voiceId, modelId: modelId)
          .timeout(const Duration(seconds: 25));
      await session.storage.storeFile(
        storageId: storageId,
        path: storagePath(fileName),
        byteData: ByteData.sublistView(bytes),
      );
      try {
        await VoiceClip.db.insertRow(
          session,
          VoiceClip(
            hash: hash,
            voiceId: voiceId,
            modelId: modelId,
            text: text,
            storagePath: storagePath(fileName),
            byteLength: bytes.length,
          ),
        );
      } on DatabaseUniqueViolationException {
        // Another request synthesized the same clip concurrently. Fine.
      }
      return fileName;
    } catch (e, stackTrace) {
      session.log(
        'Speech synthesis failed',
        level: LogLevel.warning,
        exception: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  /// Transcribes a recorded answer with ElevenLabs Scribe.
  static Future<String> transcribe(
    Session session, {
    required ByteData audio,
    required String mimeType,
  }) async {
    final engine = _engineFor(session);
    if (engine == null) {
      throw LifelineException(
        message: 'Voice answers are not available right now.',
        code: LifelineErrorCode.voiceUnavailable,
      );
    }
    try {
      return await engine
          .transcribe(
            audio: Uint8List.sublistView(audio),
            mimeType: mimeType,
          )
          .timeout(const Duration(seconds: 30));
    } catch (e, stackTrace) {
      session.log(
        'Transcription failed',
        level: LogLevel.warning,
        exception: e,
        stackTrace: stackTrace,
      );
      throw LifelineException(
        message: "Sorry, I couldn't hear that. Please try again.",
        code: LifelineErrorCode.voiceUnavailable,
      );
    }
  }

  static String storagePath(String fileName) => 'voice/$fileName';

  /// Loads a stored clip, using the local cache for hot clips.
  static Future<ByteData?> load(Session session, String fileName) async {
    final cacheKey = 'voice-clip:$fileName';
    final hot = await session.caches.local.get<ByteData>(cacheKey);
    if (hot != null) return hot;
    try {
      final data = await session.storage.retrieveFile(
        storageId: storageId,
        path: storagePath(fileName),
      );
      await session.caches.local.put(
        cacheKey,
        data,
        lifetime: const Duration(hours: 1),
      );
      return data;
    } on CloudStorageFileNotFoundException {
      return null;
    }
  }
}
