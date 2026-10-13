import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:lifeline_client/lifeline_client.dart';

/// Keeps a Serverpod streaming method subscribed and exposes its latest
/// value. Reconnects with exponential backoff when the connection drops
/// (sleeping laptop, flaky Wi-Fi, a new server deploy).
class LiveStream<T> extends ChangeNotifier {
  LiveStream(this._open, {this.poll});

  final Stream<T> Function() _open;

  /// Fetches the same value over plain HTTP. Used when WebSockets keep
  /// failing, e.g. behind a hospital or corporate proxy that blocks them.
  final Future<T> Function()? poll;

  /// True while values arrive by polling instead of the stream.
  bool polling = false;
  int _failures = 0;
  Timer? _pollTimer;

  T? value;
  Object? error;
  bool connected = false;

  /// Errors that reconnecting cannot fix, e.g. the circle was deleted.
  bool fatal = false;

  StreamSubscription<T>? _subscription;
  Timer? _retry;
  int _attempt = 0;
  bool _disposed = false;

  void start() => _connect();

  void _connect() {
    if (_disposed) return;
    _subscription?.cancel();
    _subscription = _open().listen(
      (next) {
        value = next;
        error = null;
        connected = true;
        fatal = false;
        _attempt = 0;
        _failures = 0;
        _stopPolling();
        _notify();
      },
      onError: (Object e) {
        fatal = _isFatal(e);
        if (!polling) {
          error = e;
          connected = false;
        }
        _notify();
        if (!fatal) _streamFailed();
      },
      onDone: () {
        if (!polling) connected = false;
        _notify();
        _streamFailed();
      },
      cancelOnError: true,
    );
  }

  void _streamFailed() {
    _failures++;
    if (poll != null && _failures >= 2) _startPolling();
    _scheduleRetry();
  }

  void _startPolling() {
    if (_pollTimer != null || _disposed) return;
    polling = true;
    Future<void> tick() async {
      try {
        final next = await poll!();
        if (_disposed || !polling) return;
        value = next;
        error = null;
        connected = true;
        _notify();
      } catch (e) {
        if (_isFatal(e)) {
          fatal = true;
          error = e;
          _stopPolling();
        }
        _notify();
      }
    }

    tick();
    _pollTimer = Timer.periodic(const Duration(seconds: 2), (_) => tick());
  }

  void _stopPolling() {
    _pollTimer?.cancel();
    _pollTimer = null;
    polling = false;
  }

  void _scheduleRetry() {
    if (_disposed) return;
    _retry?.cancel();
    // While polling works, retry the stream less often.
    final cap = polling ? 60000 : 15000;
    final millis = math.min(cap, 500 * math.pow(2, _attempt).toInt());
    _attempt++;
    _retry = Timer(Duration(milliseconds: millis), _connect);
  }

  /// Reconnect immediately, e.g. after the user taps "Retry".
  void reconnect() {
    _retry?.cancel();
    _attempt = 0;
    _connect();
  }

  static bool _isFatal(Object e) =>
      e is LifelineException &&
      (e.code == LifelineErrorCode.notAMember ||
          e.code == LifelineErrorCode.invalidDevice ||
          e.code == LifelineErrorCode.notFound);

  void _notify() {
    if (!_disposed) notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _retry?.cancel();
    _pollTimer?.cancel();
    _subscription?.cancel();
    super.dispose();
  }
}

/// Tracks the difference between the server's clock and this device's, so
/// countdowns are right even if the device clock is off.
class ServerClock {
  static Duration _skew = Duration.zero;

  static void sync(DateTime serverTime) {
    _skew = serverTime.toUtc().difference(DateTime.now().toUtc());
  }

  static DateTime now() => DateTime.now().toUtc().add(_skew);
}
