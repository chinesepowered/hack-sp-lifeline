import 'dart:async';

import 'recorded_audio.dart';

/// Non-web fallback. Lifeline's companion screen targets the browser, so on
/// other platforms audio and recording are simply unavailable.
class SpeechPlayer {
  Future<void> playUrl(String url) async {}

  Future<void> speakFallback(String text) async {}

  void stop() {}

  static bool get canAutoplay => true;

  static void unlock() {}
}

class VoiceRecorder {
  Stream<double> get levels => const Stream.empty();

  bool get isRecording => false;

  static bool get isSupported => false;

  Future<void> start() async =>
      throw UnsupportedError('Recording is only available on the web.');

  Future<RecordedAudio?> stop() async => null;

  void cancel() {}
}

abstract final class LocalStore {
  static final _values = <String, String>{};

  static String? read(String key) => _values[key];

  static void write(String key, String? value) {
    if (value == null) {
      _values.remove(key);
    } else {
      _values[key] = value;
    }
  }
}

String? get pageOrigin => null;
