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
import '../enums/member_role.dart' as _iw6qhlck;

/// A family member or friend in a care circle, linked to a Serverpod auth user.
abstract class CircleMember
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CircleMember._({
    this.id,
    required this.circleId,
    required this.displayName,
    this.relationship,
    required this.role,
    DateTime? joinedAt,
  }) : joinedAt = joinedAt ?? DateTime.now();

  factory CircleMember({
    int? id,
    required int circleId,
    required String displayName,
    String? relationship,
    required _iw6qhlck.MemberRole role,
    DateTime? joinedAt,
  }) = _CircleMemberImpl;

  factory CircleMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return CircleMember(
      id: jsonSerialization['id'] as int?,
      circleId: jsonSerialization['circleId'] as int,
      displayName: jsonSerialization['displayName'] as String,
      relationship: jsonSerialization['relationship'] as String?,
      role: _iw6qhlck.MemberRole.fromJson(
        (jsonSerialization['role'] as String),
      ),
      joinedAt: jsonSerialization['joinedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['joinedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int circleId;

  String displayName;

  String? relationship;

  _iw6qhlck.MemberRole role;

  DateTime joinedAt;

  /// Returns a shallow copy of this [CircleMember]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CircleMember copyWith({
    int? id,
    int? circleId,
    String? displayName,
    String? relationship,
    _iw6qhlck.MemberRole? role,
    DateTime? joinedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CircleMember',
      if (id != null) 'id': id,
      'circleId': circleId,
      'displayName': displayName,
      if (relationship != null) 'relationship': relationship,
      'role': role.toJson(),
      'joinedAt': joinedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CircleMember',
      if (id != null) 'id': id,
      'circleId': circleId,
      'displayName': displayName,
      if (relationship != null) 'relationship': relationship,
      'role': role.toJson(),
      'joinedAt': joinedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CircleMemberImpl extends CircleMember {
  _CircleMemberImpl({
    int? id,
    required int circleId,
    required String displayName,
    String? relationship,
    required _iw6qhlck.MemberRole role,
    DateTime? joinedAt,
  }) : super._(
         id: id,
         circleId: circleId,
         displayName: displayName,
         relationship: relationship,
         role: role,
         joinedAt: joinedAt,
       );

  /// Returns a shallow copy of this [CircleMember]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CircleMember copyWith({
    Object? id = _Undefined,
    int? circleId,
    String? displayName,
    Object? relationship = _Undefined,
    _iw6qhlck.MemberRole? role,
    DateTime? joinedAt,
  }) {
    return CircleMember(
      id: id is int? ? id : this.id,
      circleId: circleId ?? this.circleId,
      displayName: displayName ?? this.displayName,
      relationship: relationship is String? ? relationship : this.relationship,
      role: role ?? this.role,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}
