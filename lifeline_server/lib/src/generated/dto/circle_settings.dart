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

/// Everything a family can configure for their circle.
abstract class CircleSettings
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CircleSettings._({
    required this.lovedOneName,
    required this.voiceId,
    required this.utcOffsetMinutes,
    required this.slotMinutes,
    required this.graceSeconds,
    required this.secondGraceSeconds,
  });

  factory CircleSettings({
    required String lovedOneName,
    required String voiceId,
    required int utcOffsetMinutes,
    required List<int> slotMinutes,
    required int graceSeconds,
    required int secondGraceSeconds,
  }) = _CircleSettingsImpl;

  factory CircleSettings.fromJson(Map<String, dynamic> jsonSerialization) {
    return CircleSettings(
      lovedOneName: jsonSerialization['lovedOneName'] as String,
      voiceId: jsonSerialization['voiceId'] as String,
      utcOffsetMinutes: jsonSerialization['utcOffsetMinutes'] as int,
      slotMinutes: _ituap8d4.Protocol().deserialize<List<int>>(
        jsonSerialization['slotMinutes'],
      ),
      graceSeconds: jsonSerialization['graceSeconds'] as int,
      secondGraceSeconds: jsonSerialization['secondGraceSeconds'] as int,
    );
  }

  String lovedOneName;

  String voiceId;

  int utcOffsetMinutes;

  /// Daily check-in times, as minutes after local midnight.
  List<int> slotMinutes;

  int graceSeconds;

  int secondGraceSeconds;

  /// Returns a shallow copy of this [CircleSettings]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CircleSettings copyWith({
    String? lovedOneName,
    String? voiceId,
    int? utcOffsetMinutes,
    List<int>? slotMinutes,
    int? graceSeconds,
    int? secondGraceSeconds,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CircleSettings',
      'lovedOneName': lovedOneName,
      'voiceId': voiceId,
      'utcOffsetMinutes': utcOffsetMinutes,
      'slotMinutes': slotMinutes.toJson(),
      'graceSeconds': graceSeconds,
      'secondGraceSeconds': secondGraceSeconds,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CircleSettings',
      'lovedOneName': lovedOneName,
      'voiceId': voiceId,
      'utcOffsetMinutes': utcOffsetMinutes,
      'slotMinutes': slotMinutes.toJson(),
      'graceSeconds': graceSeconds,
      'secondGraceSeconds': secondGraceSeconds,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _CircleSettingsImpl extends CircleSettings {
  _CircleSettingsImpl({
    required String lovedOneName,
    required String voiceId,
    required int utcOffsetMinutes,
    required List<int> slotMinutes,
    required int graceSeconds,
    required int secondGraceSeconds,
  }) : super._(
         lovedOneName: lovedOneName,
         voiceId: voiceId,
         utcOffsetMinutes: utcOffsetMinutes,
         slotMinutes: slotMinutes,
         graceSeconds: graceSeconds,
         secondGraceSeconds: secondGraceSeconds,
       );

  /// Returns a shallow copy of this [CircleSettings]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CircleSettings copyWith({
    String? lovedOneName,
    String? voiceId,
    int? utcOffsetMinutes,
    List<int>? slotMinutes,
    int? graceSeconds,
    int? secondGraceSeconds,
  }) {
    return CircleSettings(
      lovedOneName: lovedOneName ?? this.lovedOneName,
      voiceId: voiceId ?? this.voiceId,
      utcOffsetMinutes: utcOffsetMinutes ?? this.utcOffsetMinutes,
      slotMinutes: slotMinutes ?? this.slotMinutes.map((e0) => e0).toList(),
      graceSeconds: graceSeconds ?? this.graceSeconds,
      secondGraceSeconds: secondGraceSeconds ?? this.secondGraceSeconds,
    );
  }
}
