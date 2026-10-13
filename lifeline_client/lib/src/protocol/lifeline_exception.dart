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
import 'enums/lifeline_error_code.dart' as _ij50bjyb;

/// A typed error sent to the app, e.g. a wrong pairing code.
abstract class LifelineException
    implements
        _isc.SerializableException,
        _isc.SerializableModel,
        _isc.ProtocolSerialization {
  LifelineException._({
    required this.message,
    required this.code,
  });

  factory LifelineException({
    required String message,
    required _ij50bjyb.LifelineErrorCode code,
  }) = _LifelineExceptionImpl;

  factory LifelineException.fromJson(Map<String, dynamic> jsonSerialization) {
    return LifelineException(
      message: jsonSerialization['message'] as String,
      code: _ij50bjyb.LifelineErrorCode.fromJson(
        (jsonSerialization['code'] as String),
      ),
    );
  }

  String message;

  _ij50bjyb.LifelineErrorCode code;

  /// Returns a shallow copy of this [LifelineException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  LifelineException copyWith({
    String? message,
    _ij50bjyb.LifelineErrorCode? code,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LifelineException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'LifelineException',
      'message': message,
      'code': code.toJson(),
    };
  }

  @override
  String toString() {
    return 'LifelineException(message: $message, code: $code)';
  }
}

class _LifelineExceptionImpl extends LifelineException {
  _LifelineExceptionImpl({
    required String message,
    required _ij50bjyb.LifelineErrorCode code,
  }) : super._(
         message: message,
         code: code,
       );

  /// Returns a shallow copy of this [LifelineException]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  LifelineException copyWith({
    String? message,
    _ij50bjyb.LifelineErrorCode? code,
  }) {
    return LifelineException(
      message: message ?? this.message,
      code: code ?? this.code,
    );
  }
}
