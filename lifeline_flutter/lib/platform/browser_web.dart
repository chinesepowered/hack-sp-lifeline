import 'dart:async';
import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:web/web.dart' as web;

import 'recorded_audio.dart';

/// Plays synthesized speech one clip at a time.
class SpeechPlayer {
  web.HTMLAudioElement? _current;
  Completer<void>? _done;

  /// Plays the MP3 at [url] and completes when it has finished.
  Future<void> playUrl(String url) async {
    stop();
    final audio = web.HTMLAudioElement()
      ..src = url
      ..preload = 'auto';
    final done = Completer<void>();
    _current = audio;
    _done = done;
    final ended = audio.onEnded.listen((_) {
      if (!done.isCompleted) done.complete();
    });
    final failed = audio.onError.listen((_) {
      if (!done.isCompleted) done.completeError(StateError('Audio failed'));
    });
    try {
      await audio.play().toDart;
      await done.future;
    } finally {
      await ended.cancel();
      await failed.cancel();
      if (identical(_current, audio)) _current = null;
    }
  }

  /// Speaks [text] with the browser's own voice: the fallback when the
  /// server could not synthesize audio.
  Future<void> speakFallback(String text) async {
    final synth = web.window.speechSynthesis;
    final utterance = web.SpeechSynthesisUtterance(text)
      ..rate = 0.92
      ..lang = 'en-US';
    final done = Completer<void>();
    utterance.onend = ((web.Event _) {
      if (!done.isCompleted) done.complete();
    }).toJS;
    utterance.onerror = ((web.Event _) {
      if (!done.isCompleted) done.complete();
    }).toJS;
    synth.speak(utterance);
    await done.future.timeout(const Duration(seconds: 40), onTimeout: () {});
  }

  void stop() {
    _current?.pause();
    _current = null;
    final done = _done;
    if (done != null && !done.isCompleted) done.complete();
    try {
      web.window.speechSynthesis.cancel();
    } catch (_) {}
  }

  /// Browsers only allow sound after the user has interacted with the page.
  static bool get canAutoplay {
    try {
      return web.window.navigator.userActivation.hasBeenActive;
    } catch (_) {
      return false;
    }
  }

  /// Call from a tap handler to unlock audio for the rest of the session
  /// (needed by Safari, harmless elsewhere).
  static void unlock() {
    try {
      final audio = web.HTMLAudioElement()
        ..src =
            'data:audio/wav;base64,UklGRiQAAABXQVZFZm10IBAAAAABAAEAQB8AAEAfAAABAAgAZGF0YQAAAAA='
        ..volume = 0;
      audio.play().toDart.ignore();
    } catch (_) {}
  }
}

/// Records a short spoken answer from the microphone.
class VoiceRecorder {
  web.MediaStream? _stream;
  web.MediaRecorder? _recorder;
  web.AudioContext? _audioContext;
  Timer? _meter;
  final _chunks = <web.Blob>[];
  final _levels = StreamController<double>.broadcast();
  String _mimeType = '';

  /// Microphone loudness from 0 to 1, about 15 times a second.
  Stream<double> get levels => _levels.stream;

  bool get isRecording => _recorder != null;

  static bool get isSupported {
    try {
      final navigator = web.window.navigator as JSObject;
      return navigator.has('mediaDevices') &&
          (web.window as JSObject).has('MediaRecorder');
    } catch (_) {
      return false;
    }
  }

  Future<void> start() async {
    final stream = await web.window.navigator.mediaDevices
        .getUserMedia(web.MediaStreamConstraints(audio: true.toJS))
        .toDart;
    _stream = stream;
    _chunks.clear();

    const preferred = [
      'audio/webm;codecs=opus',
      'audio/webm',
      'audio/ogg;codecs=opus',
      'audio/mp4',
    ];
    _mimeType = preferred.firstWhere(
      (type) => web.MediaRecorder.isTypeSupported(type),
      orElse: () => '',
    );
    final recorder = _mimeType.isEmpty
        ? web.MediaRecorder(stream)
        : web.MediaRecorder(
            stream,
            web.MediaRecorderOptions(
              mimeType: _mimeType,
              audioBitsPerSecond: 48000,
            ),
          );
    recorder.ondataavailable = ((web.BlobEvent event) {
      if (event.data.size > 0) _chunks.add(event.data);
    }).toJS;
    recorder.start(250);
    _recorder = recorder;
    _startMeter(stream);
  }

  void _startMeter(web.MediaStream stream) {
    try {
      final context = web.AudioContext();
      final analyser = context.createAnalyser()..fftSize = 512;
      context.createMediaStreamSource(stream).connect(analyser);
      _audioContext = context;
      final buffer = Uint8List(analyser.fftSize);
      final jsBuffer = buffer.toJS;
      _meter = Timer.periodic(const Duration(milliseconds: 66), (_) {
        analyser.getByteTimeDomainData(jsBuffer);
        final data = jsBuffer.toDart;
        var sum = 0.0;
        for (final sample in data) {
          final centered = (sample - 128) / 128;
          sum += centered * centered;
        }
        final rms = math.sqrt(sum / data.length);
        _levels.add(math.min(1, rms * 4));
      });
    } catch (_) {
      // The meter is decoration; recording works without it.
    }
  }

  /// Stops recording and returns the audio, or null if nothing was captured.
  Future<RecordedAudio?> stop() async {
    final recorder = _recorder;
    if (recorder == null) return null;
    final stopped = Completer<void>();
    recorder.onstop = ((web.Event _) {
      if (!stopped.isCompleted) stopped.complete();
    }).toJS;
    recorder.stop();
    await stopped.future.timeout(const Duration(seconds: 3), onTimeout: () {});
    final type = recorder.mimeType.isNotEmpty
        ? recorder.mimeType
        : (_mimeType.isEmpty ? 'audio/webm' : _mimeType);
    _release();

    if (_chunks.isEmpty) return null;
    final blob = web.Blob(_chunks.toJS, web.BlobPropertyBag(type: type));
    final buffer = await blob.arrayBuffer().toDart;
    _chunks.clear();
    return RecordedAudio(buffer.toDart.asUint8List(), type);
  }

  void cancel() {
    try {
      _recorder?.stop();
    } catch (_) {}
    _chunks.clear();
    _release();
  }

  void _release() {
    _meter?.cancel();
    _meter = null;
    _audioContext?.close().toDart.ignore();
    _audioContext = null;
    final tracks = _stream?.getTracks().toDart ?? const [];
    for (final track in tracks) {
      track.stop();
    }
    _stream = null;
    _recorder = null;
  }
}

/// Small persistent key-value store (localStorage).
abstract final class LocalStore {
  static String? read(String key) {
    try {
      return web.window.localStorage.getItem(key);
    } catch (_) {
      return null;
    }
  }

  static void write(String key, String? value) {
    try {
      if (value == null) {
        web.window.localStorage.removeItem(key);
      } else {
        web.window.localStorage.setItem(key, value);
      }
    } catch (_) {}
  }
}

/// The page's own origin, e.g. "https://lifeline.serverpod.space".
String? get pageOrigin {
  try {
    return web.window.location.origin;
  } catch (_) {
    return null;
  }
}
