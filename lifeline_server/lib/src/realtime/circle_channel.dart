import 'dart:async';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Real-time plumbing for a care circle, built on Serverpod server events.
///
/// Anything that changes a circle posts a [CircleSignal] to the circle's
/// channel. Streaming endpoint methods listen to [changes] and push a fresh
/// snapshot to every connected dashboard and companion screen.
abstract final class CircleChannel {
  static String name(int circleId) => 'circle-$circleId';

  /// Tells every listener that [circleId] changed.
  static Future<void> notify(
    Session session,
    int circleId,
    String reason,
  ) async {
    await session.messages.postMessage(
      name(circleId),
      CircleSignal(circleId: circleId, reason: reason),
    );
  }

  /// Emits whenever the circle changes, coalescing bursts of signals.
  ///
  /// A periodic [heartbeat] also emits, because some state is time based
  /// ("last seen", countdowns) and because, without Redis, a signal posted
  /// on another server instance would not reach this one.
  static Stream<void> changes(
    Session session,
    int circleId, {
    Duration heartbeat = const Duration(seconds: 20),
    Duration debounce = const Duration(milliseconds: 150),
  }) {
    late final StreamController<void> controller;
    StreamSubscription<CircleSignal>? signals;
    Timer? heartbeatTimer;
    Timer? debounceTimer;

    void schedule() {
      debounceTimer?.cancel();
      debounceTimer = Timer(debounce, () {
        if (!controller.isClosed) controller.add(null);
      });
    }

    controller = StreamController<void>(
      onListen: () {
        signals = session.messages
            .createStream<CircleSignal>(name(circleId))
            .listen((_) => schedule(), onError: (_) {});
        heartbeatTimer = Timer.periodic(heartbeat, (_) => schedule());
      },
      onCancel: () async {
        heartbeatTimer?.cancel();
        debounceTimer?.cancel();
        await signals?.cancel();
      },
    );
    return controller.stream;
  }
}
