/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: depend_on_referenced_packages

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _ida;
import 'package:clock/clock.dart' as _io0w16m8;
import 'package:serverpod/serverpod.dart' as _is;
import '../checkins/check_in_future_calls.dart' as _ik2zzklx;
import 'future_calls_generated_models/check_in_future_call_scheduled_check_in_model.dart'
    as _icanq7pd;
import 'future_calls_generated_models/demo_cleanup_future_call_expire_model.dart'
    as _iah8bc35;
import 'future_calls_generated_models/escalation_future_call_no_response_model.dart'
    as _itbfoczd;

/// Invokes a future call.
typedef _InvokeFutureCall =
    Future<void> Function(String name, _is.SerializableModel? object);

extension ServerpodFutureCallsGetter on _is.Serverpod {
  /// Generated future calls.
  FutureCalls get futureCalls => FutureCalls();
}

class FutureCalls extends _is.FutureCallDispatch<_FutureCallRef> {
  FutureCalls._();

  factory FutureCalls() {
    return _instance;
  }

  static final FutureCalls _instance = FutureCalls._();

  _is.FutureCallManager? _futureCallManager;

  String? _serverId;

  String get _effectiveServerId {
    if (_serverId == null) {
      throw StateError('FutureCalls is not initialized.');
    }
    return _serverId!;
  }

  _is.FutureCallManager get _effectiveFutureCallManager {
    if (_futureCallManager == null) {
      throw StateError('FutureCalls is not initialized.');
    }
    return _futureCallManager!;
  }

  @override
  void initialize(
    _is.FutureCallManager futureCallManager,
    String serverId,
  ) {
    var registeredFutureCalls = <String, _is.InvokableFutureCall>{
      'CheckInScheduledCheckInFutureCall': CheckInScheduledCheckInFutureCall(),
      'EscalationNoResponseFutureCall': EscalationNoResponseFutureCall(),
      'DemoCleanupExpireFutureCall': DemoCleanupExpireFutureCall(),
    };
    _futureCallManager = futureCallManager;
    _serverId = serverId;
    for (final entry in registeredFutureCalls.entries) {
      _futureCallManager?.registerFutureCall(entry.value, entry.key);
    }
  }

  @override
  _FutureCallRef callAtTime(
    DateTime time, {
    String? identifier,
  }) {
    return _FutureCallRef(
      (name, object) {
        return _effectiveFutureCallManager.scheduleFutureCall(
          name,
          object,
          time,
          _effectiveServerId,
          identifier,
        );
      },
    );
  }

  @override
  _FutureCallRef callWithDelay(
    Duration delay, {
    String? identifier,
  }) {
    return _FutureCallRef(
      (name, object) {
        return _effectiveFutureCallManager.scheduleFutureCall(
          name,
          object,
          DateTime.now().toUtc().add(delay),
          _effectiveServerId,
          identifier,
        );
      },
    );
  }

  @override
  _is.RecurringFutureCallDispatch<_FutureCallRef> callRecurring({
    String? identifier,
  }) {
    return _RecurringFutureCallDispatchImpl(
      _effectiveFutureCallManager,
      _effectiveServerId,
      identifier,
    );
  }

  @override
  Future<void> cancel(String identifier) async {
    await _effectiveFutureCallManager.cancelFutureCall(identifier);
  }
}

class _RecurringFutureCallDispatchImpl
    extends _is.RecurringFutureCallDispatch<_FutureCallRef> {
  _RecurringFutureCallDispatchImpl(
    this._futureCallManager,
    this._serverId,
    this._identifier,
  );

  final _is.FutureCallManager _futureCallManager;

  final String _serverId;

  final String? _identifier;

  @override
  _FutureCallRef cron(String cronExpression) {
    return _FutureCallRef(
      (name, object) {
        return _futureCallManager.scheduleFutureCall(
          name,
          object,
          _is.Cron.parse(cronExpression).nextTime(),
          _serverId,
          _identifier,
          scheduling: _is.CronFutureCallScheduling(cron: cronExpression),
        );
      },
    );
  }

  @override
  _FutureCallRef every(
    Duration interval, {
    DateTime? start,
  }) {
    final now = _io0w16m8.clock.now().toUtc();
    return _FutureCallRef(
      (name, object) {
        return _futureCallManager.scheduleFutureCall(
          name,
          object,
          start ?? now.add(interval),
          _serverId,
          _identifier,
          scheduling: _is.IntervalFutureCallScheduling(
            interval: interval,
            start: start,
          ),
        );
      },
    );
  }
}

class _FutureCallRef {
  _FutureCallRef(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  late final checkIn = _CheckInFutureCallDispatcher(_invokeFutureCall);

  late final escalation = _EscalationFutureCallDispatcher(_invokeFutureCall);

  late final demoCleanup = _DemoCleanupFutureCallDispatcher(_invokeFutureCall);
}

class _CheckInFutureCallDispatcher {
  _CheckInFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> scheduledCheckIn(
    int circleId,
    int slotId,
  ) {
    var object = _icanq7pd.CheckInFutureCallScheduledCheckInModel(
      circleId: circleId,
      slotId: slotId,
    );
    return _invokeFutureCall(
      'CheckInScheduledCheckInFutureCall',
      object,
    );
  }
}

class _EscalationFutureCallDispatcher {
  _EscalationFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> noResponse(
    int checkInId,
    int stage,
  ) {
    var object = _itbfoczd.EscalationFutureCallNoResponseModel(
      checkInId: checkInId,
      stage: stage,
    );
    return _invokeFutureCall(
      'EscalationNoResponseFutureCall',
      object,
    );
  }
}

class _DemoCleanupFutureCallDispatcher {
  _DemoCleanupFutureCallDispatcher(this._invokeFutureCall);

  final _InvokeFutureCall _invokeFutureCall;

  Future<void> expire(int circleId) {
    var object = _iah8bc35.DemoCleanupFutureCallExpireModel(circleId: circleId);
    return _invokeFutureCall(
      'DemoCleanupExpireFutureCall',
      object,
    );
  }
}

class CheckInScheduledCheckInFutureCall
    extends _is.FutureCall<_icanq7pd.CheckInFutureCallScheduledCheckInModel>
    implements
        _is.InvokableFutureCall<
          _icanq7pd.CheckInFutureCallScheduledCheckInModel
        > {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _icanq7pd.CheckInFutureCallScheduledCheckInModel? object,
  ) async {
    if (object != null) {
      await _ik2zzklx.CheckInFutureCall().scheduledCheckIn(
        session,
        object.circleId,
        object.slotId,
      );
    }
  }
}

class EscalationNoResponseFutureCall
    extends _is.FutureCall<_itbfoczd.EscalationFutureCallNoResponseModel>
    implements
        _is.InvokableFutureCall<_itbfoczd.EscalationFutureCallNoResponseModel> {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _itbfoczd.EscalationFutureCallNoResponseModel? object,
  ) async {
    if (object != null) {
      await _ik2zzklx.EscalationFutureCall().noResponse(
        session,
        object.checkInId,
        object.stage,
      );
    }
  }
}

class DemoCleanupExpireFutureCall
    extends _is.FutureCall<_iah8bc35.DemoCleanupFutureCallExpireModel>
    implements
        _is.InvokableFutureCall<_iah8bc35.DemoCleanupFutureCallExpireModel> {
  @override
  _ida.Future<void> invoke(
    _is.Session session,
    _iah8bc35.DemoCleanupFutureCallExpireModel? object,
  ) async {
    if (object != null) {
      await _ik2zzklx.DemoCleanupFutureCall().expire(
        session,
        object.circleId,
      );
    }
  }
}
