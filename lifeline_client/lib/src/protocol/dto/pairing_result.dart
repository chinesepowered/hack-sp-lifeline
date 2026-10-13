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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

abstract class PairingResult
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PairingResult._({
    required this.deviceToken,
    required this.circleId,
    required this.lovedOneName,
  });

  factory PairingResult({
    required String deviceToken,
    required int circleId,
    required String lovedOneName,
  }) = _PairingResultImpl;

  factory PairingResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return PairingResult(
      deviceToken: jsonSerialization['deviceToken'] as String,
      circleId: jsonSerialization['circleId'] as int,
      lovedOneName: jsonSerialization['lovedOneName'] as String,
    );
  }

  /// Secret device token. Shown once; the server only keeps its hash.
  String deviceToken;

  int circleId;

  String lovedOneName;

  /// Returns a shallow copy of this [PairingResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PairingResult copyWith({
    String? deviceToken,
    int? circleId,
    String? lovedOneName,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PairingResult',
      'deviceToken': deviceToken,
      'circleId': circleId,
      'lovedOneName': lovedOneName,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PairingResult',
      'deviceToken': deviceToken,
      'circleId': circleId,
      'lovedOneName': lovedOneName,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _PairingResultImpl extends PairingResult {
  _PairingResultImpl({
    required String deviceToken,
    required int circleId,
    required String lovedOneName,
  }) : super._(
         deviceToken: deviceToken,
         circleId: circleId,
         lovedOneName: lovedOneName,
       );

  /// Returns a shallow copy of this [PairingResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PairingResult copyWith({
    String? deviceToken,
    int? circleId,
    String? lovedOneName,
  }) {
    return PairingResult(
      deviceToken: deviceToken ?? this.deviceToken,
      circleId: circleId ?? this.circleId,
      lovedOneName: lovedOneName ?? this.lovedOneName,
    );
  }
}
