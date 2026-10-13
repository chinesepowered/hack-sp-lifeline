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
import 'package:lifeline_server/src/generated/protocol.dart' as _ituap8d4;
import 'package:serverpod/serverpod.dart' as _is;
import '../enums/triage_level.dart' as _i69p18mx;

/// What the server heard when the loved one answered by voice.
abstract class VoiceReplyResult
    implements _is.SerializableModel, _is.ProtocolSerialization {
  VoiceReplyResult._({
    required this.transcript,
    required this.triageLevel,
    required this.reasons,
  });

  factory VoiceReplyResult({
    required String transcript,
    required _i69p18mx.TriageLevel triageLevel,
    required List<String> reasons,
  }) = _VoiceReplyResultImpl;

  factory VoiceReplyResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return VoiceReplyResult(
      transcript: jsonSerialization['transcript'] as String,
      triageLevel: _i69p18mx.TriageLevel.fromJson(
        (jsonSerialization['triageLevel'] as String),
      ),
      reasons: _ituap8d4.Protocol().deserialize<List<String>>(
        jsonSerialization['reasons'],
      ),
    );
  }

  String transcript;

  _i69p18mx.TriageLevel triageLevel;

  List<String> reasons;

  /// Returns a shallow copy of this [VoiceReplyResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  VoiceReplyResult copyWith({
    String? transcript,
    _i69p18mx.TriageLevel? triageLevel,
    List<String>? reasons,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VoiceReplyResult',
      'transcript': transcript,
      'triageLevel': triageLevel.toJson(),
      'reasons': reasons.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VoiceReplyResult',
      'transcript': transcript,
      'triageLevel': triageLevel.toJson(),
      'reasons': reasons.toJson(),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _VoiceReplyResultImpl extends VoiceReplyResult {
  _VoiceReplyResultImpl({
    required String transcript,
    required _i69p18mx.TriageLevel triageLevel,
    required List<String> reasons,
  }) : super._(
         transcript: transcript,
         triageLevel: triageLevel,
         reasons: reasons,
       );

  /// Returns a shallow copy of this [VoiceReplyResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  VoiceReplyResult copyWith({
    String? transcript,
    _i69p18mx.TriageLevel? triageLevel,
    List<String>? reasons,
  }) {
    return VoiceReplyResult(
      transcript: transcript ?? this.transcript,
      triageLevel: triageLevel ?? this.triageLevel,
      reasons: reasons ?? this.reasons.map((e0) => e0).toList(),
    );
  }
}
