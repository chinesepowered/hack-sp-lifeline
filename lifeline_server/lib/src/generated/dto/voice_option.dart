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

/// A curated ElevenLabs voice the family can pick for the companion.
abstract class VoiceOption
    implements _is.SerializableModel, _is.ProtocolSerialization {
  VoiceOption._({
    required this.voiceId,
    required this.name,
    required this.description,
  });

  factory VoiceOption({
    required String voiceId,
    required String name,
    required String description,
  }) = _VoiceOptionImpl;

  factory VoiceOption.fromJson(Map<String, dynamic> jsonSerialization) {
    return VoiceOption(
      voiceId: jsonSerialization['voiceId'] as String,
      name: jsonSerialization['name'] as String,
      description: jsonSerialization['description'] as String,
    );
  }

  String voiceId;

  String name;

  String description;

  /// Returns a shallow copy of this [VoiceOption]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  VoiceOption copyWith({
    String? voiceId,
    String? name,
    String? description,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VoiceOption',
      'voiceId': voiceId,
      'name': name,
      'description': description,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VoiceOption',
      'voiceId': voiceId,
      'name': name,
      'description': description,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _VoiceOptionImpl extends VoiceOption {
  _VoiceOptionImpl({
    required String voiceId,
    required String name,
    required String description,
  }) : super._(
         voiceId: voiceId,
         name: name,
         description: description,
       );

  /// Returns a shallow copy of this [VoiceOption]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  VoiceOption copyWith({
    String? voiceId,
    String? name,
    String? description,
  }) {
    return VoiceOption(
      voiceId: voiceId ?? this.voiceId,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}
