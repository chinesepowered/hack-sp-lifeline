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

abstract class EscalationFutureCallNoResponseModel
    implements _is.SerializableModel, _is.ProtocolSerialization {
  EscalationFutureCallNoResponseModel._({
    required this.checkInId,
    required this.stage,
  });

  factory EscalationFutureCallNoResponseModel({
    required int checkInId,
    required int stage,
  }) = _EscalationFutureCallNoResponseModelImpl;

  factory EscalationFutureCallNoResponseModel.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return EscalationFutureCallNoResponseModel(
      checkInId: jsonSerialization['checkInId'] as int,
      stage: jsonSerialization['stage'] as int,
    );
  }

  int checkInId;

  int stage;

  /// Returns a shallow copy of this [EscalationFutureCallNoResponseModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  EscalationFutureCallNoResponseModel copyWith({
    int? checkInId,
    int? stage,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EscalationFutureCallNoResponseModel',
      'checkInId': checkInId,
      'stage': stage,
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

class _EscalationFutureCallNoResponseModelImpl
    extends EscalationFutureCallNoResponseModel {
  _EscalationFutureCallNoResponseModelImpl({
    required int checkInId,
    required int stage,
  }) : super._(
         checkInId: checkInId,
         stage: stage,
       );

  /// Returns a shallow copy of this [EscalationFutureCallNoResponseModel]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  EscalationFutureCallNoResponseModel copyWith({
    int? checkInId,
    int? stage,
  }) {
    return EscalationFutureCallNoResponseModel(
      checkInId: checkInId ?? this.checkInId,
      stage: stage ?? this.stage,
    );
  }
}
