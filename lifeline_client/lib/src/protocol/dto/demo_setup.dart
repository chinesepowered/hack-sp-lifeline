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

/// A ready-to-explore demo: a circle plus a paired virtual companion screen.
abstract class DemoSetup
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DemoSetup._({
    required this.circleId,
    required this.deviceToken,
  });

  factory DemoSetup({
    required int circleId,
    required String deviceToken,
  }) = _DemoSetupImpl;

  factory DemoSetup.fromJson(Map<String, dynamic> jsonSerialization) {
    return DemoSetup(
      circleId: jsonSerialization['circleId'] as int,
      deviceToken: jsonSerialization['deviceToken'] as String,
    );
  }

  int circleId;

  String deviceToken;

  /// Returns a shallow copy of this [DemoSetup]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DemoSetup copyWith({
    int? circleId,
    String? deviceToken,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DemoSetup',
      'circleId': circleId,
      'deviceToken': deviceToken,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DemoSetup',
      'circleId': circleId,
      'deviceToken': deviceToken,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _DemoSetupImpl extends DemoSetup {
  _DemoSetupImpl({
    required int circleId,
    required String deviceToken,
  }) : super._(
         circleId: circleId,
         deviceToken: deviceToken,
       );

  /// Returns a shallow copy of this [DemoSetup]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DemoSetup copyWith({
    int? circleId,
    String? deviceToken,
  }) {
    return DemoSetup(
      circleId: circleId ?? this.circleId,
      deviceToken: deviceToken ?? this.deviceToken,
    );
  }
}
