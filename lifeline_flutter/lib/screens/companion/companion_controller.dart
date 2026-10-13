import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:lifeline_client/lifeline_client.dart';

import '../../client.dart';
import '../../platform/browser.dart';
import '../../state/live_stream.dart';
import '../../widgets/common.dart';

/// Drives the companion screen: live state from the server, speaking new
/// lines out loud (one at a time, with captions), and sending answers.
class CompanionController extends ChangeNotifier {
  CompanionController(this.deviceToken) {
    live = LiveStream(() => client.companion.watch(deviceToken))
      ..addListener(_onState)
      ..start();
  }

  final String deviceToken;
  late final LiveStream<CompanionState> live;
  final _player = SpeechPlayer();
  final recorder = VoiceRecorder();
  final _played = <int>{};
  final _queue = Queue<Utterance>();
  bool _primed = false;
  bool _pumping = false;
  bool _disposed = false;
  Timer? _autoStop;
  Timer? _clearHeard;

  /// Browsers block sound until the person has tapped the page once.
  bool audioUnlocked = SpeechPlayer.canAutoplay;

  /// The line being spoken right now (shown as a caption).
  Utterance? speaking;

  bool recording = false;
  bool thinking = false;
  bool busy = false;

  /// What we heard in the last spoken answer, shown briefly.
  String? heard;
  TriageLevel? heardLevel;

  CompanionState? get state => live.value;

  void unlockAudio() {
    SpeechPlayer.unlock();
    audioUnlocked = true;
    _changed();
    _pump();
  }

  void _onState() {
    final s = live.value;
    if (s != null) {
      ServerClock.sync(s.serverTime);
      if (!_primed) {
        // Don't replay what was said before this screen was opened.
        _primed = true;
        for (final u in s.utterances) {
          if (s.serverTime.difference(u.createdAt).inSeconds > 25) {
            _played.add(u.id!);
          }
        }
      }
      for (final u in s.utterances) {
        if (_played.add(u.id!)) _queue.add(u);
      }
      _pump();
    }
    _changed();
  }

  Future<void> _pump() async {
    if (_pumping || !audioUnlocked || recording || _disposed) return;
    _pumping = true;
    try {
      while (_queue.isNotEmpty && !recording && !_disposed) {
        final utterance = _queue.removeFirst();
        speaking = utterance;
        _changed();
        await _speak(utterance);
        speaking = null;
        _changed();
        await Future<void>.delayed(const Duration(milliseconds: 350));
      }
    } finally {
      _pumping = false;
    }
  }

  /// Plays a family message again.
  Future<void> replay(Utterance utterance) async {
    if (recording) return;
    _queue.addFirst(utterance);
    await _pump();
  }

  Future<void> _speak(Utterance u) async {
    // Lines are logged so the demo video can be synced with the audio.
    // ignore: avoid_print
    print(
      '[lifeline-audio] start id=${u.id} kind=${u.kind.name} '
      'file=${u.audioPath ?? '-'}',
    );
    try {
      final path = u.audioPath;
      if (path != null) {
        await _player.playUrl('${_voiceBase()}$path');
      } else {
        await _player.speakFallback(_spokenText(u));
      }
    } catch (_) {
      try {
        await _player.speakFallback(_spokenText(u));
      } catch (_) {}
    }
    // ignore: avoid_print
    print('[lifeline-audio] end id=${u.id}');
  }

  String _voiceBase() {
    // Served by the same Serverpod web server as this app in production.
    final origin = pageOrigin;
    if (kReleaseMode && origin != null) return '$origin/voice/';
    return state?.voiceBaseUrl ?? '/voice/';
  }

  static String _spokenText(Utterance u) =>
      u.kind == UtteranceKind.familyMessage
      ? 'Here is a message from ${u.fromName ?? 'your family'}. ${u.text}'
      : u.text;

  Future<String?> imOkay() => _act(() => client.companion.imOkay(deviceToken));

  Future<String?> needHelp() =>
      _act(() => client.companion.needHelp(deviceToken));

  Future<String?> _act(Future<void> Function() action) async {
    busy = true;
    _changed();
    try {
      await action();
      return null;
    } catch (e) {
      return friendlyError(e);
    } finally {
      busy = false;
      _changed();
    }
  }

  /// Starts listening. Returns an error message if the mic is unavailable.
  Future<String?> startRecording() async {
    if (!VoiceRecorder.isSupported) {
      return 'Voice answers need a browser with microphone access.';
    }
    _player.stop();
    heard = null;
    try {
      await recorder.start();
    } catch (_) {
      return 'Please allow the microphone to answer by voice.';
    }
    recording = true;
    _changed();
    _autoStop = Timer(const Duration(seconds: 12), stopRecording);
    return null;
  }

  /// Stops listening and sends the answer for transcription and triage.
  Future<String?> stopRecording() async {
    _autoStop?.cancel();
    if (!recording) return null;
    recording = false;
    thinking = true;
    _changed();
    try {
      final audio = await recorder.stop();
      if (audio == null || audio.bytes.length < 800) {
        return "I didn't hear anything. Try again, a little closer.";
      }
      final result = await client.companion.answerByVoice(
        deviceToken,
        ByteData.sublistView(audio.bytes),
        audio.mimeType,
      );
      heard = result.transcript.isEmpty ? null : result.transcript;
      heardLevel = result.triageLevel;
      _clearHeard?.cancel();
      _clearHeard = Timer(const Duration(seconds: 20), () {
        heard = null;
        _changed();
      });
      return null;
    } catch (e) {
      return friendlyError(e);
    } finally {
      thinking = false;
      _changed();
      _pump();
    }
  }

  void cancelRecording() {
    _autoStop?.cancel();
    recorder.cancel();
    recording = false;
    _changed();
    _pump();
  }

  void _changed() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _autoStop?.cancel();
    _clearHeard?.cancel();
    _player.stop();
    recorder.cancel();
    live.dispose();
    super.dispose();
  }
}
