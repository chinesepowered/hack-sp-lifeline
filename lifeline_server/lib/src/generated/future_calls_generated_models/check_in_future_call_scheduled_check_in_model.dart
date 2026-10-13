/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;

abstract class CheckInFutureCallScheduledCheckInModel
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CheckInFutureCallScheduledCheckInModel._({
    required this.circleId,
    required this.slotId,
  });

  factory CheckInFutureCallScheduledCheckInModel({
    required int circleId,
    required int slotId,
  }) = _CheckInFutureCallScheduledCheckInModelImpl;

  factory CheckInFutureCallScheduledCheckInModel.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CheckInFutureCallScheduledCheckInModel(
      circleId: jsonSerialization['circleId'] as int,
      slotId: jsonSerialization['slotId'] as int,
    );
  }

  int circleId;

  int slotId;

  /// Returns a shallow copy of this [CheckInFutureCallScheduledCheckInModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CheckInFutureCallScheduledCheckInModel copyWith({
    int? circleId,
    int? slotId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CheckInFutureCallScheduledCheckInModel',
      'circleId': circleId,
      'slotId': slotId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {};
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _CheckInFutureCallScheduledCheckInModelImpl
    extends CheckInFutureCallScheduledCheckInModel {
  _CheckInFutureCallScheduledCheckInModelImpl({
    required int circleId,
    required int slotId,
  }) : super._(
         circleId: circleId,
         slotId: slotId,
       );

  /// Returns a shallow copy of this [CheckInFutureCallScheduledCheckInModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CheckInFutureCallScheduledCheckInModel copyWith({
    int? circleId,
    int? slotId,
  }) {
    return CheckInFutureCallScheduledCheckInModel(
      circleId: circleId ?? this.circleId,
      slotId: slotId ?? this.slotId,
    );
  }
}
