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
import '../enums/utterance_kind.dart' as _ivoke19u;

/// A line spoken on the companion screen, voiced by ElevenLabs.
abstract class Utterance
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Utterance._({
    this.id,
    required this.circleId,
    required this.kind,
    required this.text,
    this.audioPath,
    this.fromName,
    this.checkInId,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Utterance({
    int? id,
    required int circleId,
    required _ivoke19u.UtteranceKind kind,
    required String text,
    String? audioPath,
    String? fromName,
    int? checkInId,
    DateTime? createdAt,
  }) = _UtteranceImpl;

  factory Utterance.fromJson(Map<String, dynamic> jsonSerialization) {
    return Utterance(
      id: jsonSerialization['id'] as int?,
      circleId: jsonSerialization['circleId'] as int,
      kind: _ivoke19u.UtteranceKind.fromJson(
        (jsonSerialization['kind'] as String),
      ),
      text: jsonSerialization['text'] as String,
      audioPath: jsonSerialization['audioPath'] as String?,
      fromName: jsonSerialization['fromName'] as String?,
      checkInId: jsonSerialization['checkInId'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int circleId;

  _ivoke19u.UtteranceKind kind;

  String text;

  /// Path of the synthesized MP3 under the /voice/ web route, or null if
  /// synthesis was unavailable (the app then falls back to on-device TTS).
  String? audioPath;

  String? fromName;

  int? checkInId;

  DateTime createdAt;

  /// Returns a shallow copy of this [Utterance]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Utterance copyWith({
    int? id,
    int? circleId,
    _ivoke19u.UtteranceKind? kind,
    String? text,
    String? audioPath,
    String? fromName,
    int? checkInId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Utterance',
      if (id != null) 'id': id,
      'circleId': circleId,
      'kind': kind.toJson(),
      'text': text,
      if (audioPath != null) 'audioPath': audioPath,
      if (fromName != null) 'fromName': fromName,
      if (checkInId != null) 'checkInId': checkInId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Utterance',
      if (id != null) 'id': id,
      'circleId': circleId,
      'kind': kind.toJson(),
      'text': text,
      if (audioPath != null) 'audioPath': audioPath,
      if (fromName != null) 'fromName': fromName,
      if (checkInId != null) 'checkInId': checkInId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UtteranceImpl extends Utterance {
  _UtteranceImpl({
    int? id,
    required int circleId,
    required _ivoke19u.UtteranceKind kind,
    required String text,
    String? audioPath,
    String? fromName,
    int? checkInId,
    DateTime? createdAt,
  }) : super._(
         id: id,
         circleId: circleId,
         kind: kind,
         text: text,
         audioPath: audioPath,
         fromName: fromName,
         checkInId: checkInId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Utterance]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Utterance copyWith({
    Object? id = _Undefined,
    int? circleId,
    _ivoke19u.UtteranceKind? kind,
    String? text,
    Object? audioPath = _Undefined,
    Object? fromName = _Undefined,
    Object? checkInId = _Undefined,
    DateTime? createdAt,
  }) {
    return Utterance(
      id: id is int? ? id : this.id,
      circleId: circleId ?? this.circleId,
      kind: kind ?? this.kind,
      text: text ?? this.text,
      audioPath: audioPath is String? ? audioPath : this.audioPath,
      fromName: fromName is String? ? fromName : this.fromName,
      checkInId: checkInId is int? ? checkInId : this.checkInId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
