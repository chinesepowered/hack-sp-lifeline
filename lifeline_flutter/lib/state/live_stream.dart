import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:lifeline_client/lifeline_client.dart';

/// Keeps a Serverpod streaming method subscribed and exposes its latest
/// value. Reconnects with exponential backoff when the connection drops
/// (sleeping laptop, flaky Wi-Fi, a new server deploy).
class LiveStream<T> extends ChangeNotifier {
  LiveStream(this._open);

  final Stream<T> Function() _open;

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
        _notify();
      },
      onError: (Object e) {
        error = e;
        connected = false;
        fatal = _isFatal(e);
        _notify();
        if (!fatal) _scheduleRetry();
      },
      onDone: () {
        connected = false;
        _notify();
        _scheduleRetry();
      },
      cancelOnError: true,
    );
  }

  void _scheduleRetry() {
    if (_disposed) return;
    _retry?.cancel();
    final millis = math.min(15000, 500 * math.pow(2, _attempt).toInt());
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
