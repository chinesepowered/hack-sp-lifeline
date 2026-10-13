/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_type_check

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:lifeline_server/src/generated/dto/circle_summary.dart'
    as _iposvplt;
import 'package:lifeline_server/src/generated/dto/voice_option.dart'
    as _i05ls1zs;
import 'package:serverpod/protocol.dart' as _isp;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import 'dto/circle_settings.dart' as _i3ka3h96;
import 'dto/circle_signal.dart' as _i919q16d;
import 'dto/circle_snapshot.dart' as _ifhasew7;
import 'dto/circle_summary.dart' as _iu17mqvp;
import 'dto/companion_state.dart' as _iulcjp1w;
import 'dto/demo_setup.dart' as _i0j74by7;
import 'dto/pairing_result.dart' as _igma2i47;
import 'dto/voice_option.dart' as _iqedek9t;
import 'dto/voice_reply_result.dart' as _ituo13k3;
import 'enums/alert_kind.dart' as _i7t4x9tm;
import 'enums/alert_level.dart' as _iubt32n2;
import 'enums/check_in_kind.dart' as _ikmb3xjn;
import 'enums/check_in_status.dart' as _ijrvdr1p;
import 'enums/circle_status.dart' as _i6qvt1rc;
import 'enums/event_kind.dart' as _i27hojh9;
import 'enums/lifeline_error_code.dart' as _ij50bjyb;
import 'enums/member_role.dart' as _icimtxba;
import 'enums/response_method.dart' as _igp5zq1l;
import 'enums/triage_level.dart' as _istrf3zd;
import 'enums/utterance_kind.dart' as _ixwsitj3;
import 'future_calls_generated_models/check_in_future_call_scheduled_check_in_model.dart'
    as _icanq7pd;
import 'future_calls_generated_models/demo_cleanup_future_call_expire_model.dart'
    as _iah8bc35;
import 'future_calls_generated_models/escalation_future_call_no_response_model.dart'
    as _itbfoczd;
import 'lifeline_exception.dart' as _irswewhe;
import 'tables/alert.dart' as _ix65b5hp;
import 'tables/check_in.dart' as _i9wmztxc;
import 'tables/check_in_slot.dart' as _is1itcsv;
import 'tables/circle.dart' as _is1kwm8w;
import 'tables/circle_event.dart' as _ii1xfzkz;
import 'tables/circle_member.dart' as _isezf3zm;
import 'tables/companion_device.dart' as _i34wu1yp;
import 'tables/utterance.dart' as _ikx4o9d3;
import 'tables/voice_clip.dart' as _ibmgaguv;
export 'dto/circle_settings.dart';
export 'dto/circle_signal.dart';
export 'dto/circle_snapshot.dart';
export 'dto/circle_summary.dart';
export 'dto/companion_state.dart';
export 'dto/demo_setup.dart';
export 'dto/pairing_result.dart';
export 'dto/voice_option.dart';
export 'dto/voice_reply_result.dart';
export 'enums/alert_kind.dart';
export 'enums/alert_level.dart';
export 'enums/check_in_kind.dart';
export 'enums/check_in_status.dart';
export 'enums/circle_status.dart';
export 'enums/event_kind.dart';
export 'enums/lifeline_error_code.dart';
export 'enums/member_role.dart';
export 'enums/response_method.dart';
export 'enums/triage_level.dart';
export 'enums/utterance_kind.dart';
export 'lifeline_exception.dart';
export 'tables/alert.dart';
export 'tables/check_in.dart';
export 'tables/check_in_slot.dart';
export 'tables/circle.dart';
export 'tables/circle_event.dart';
export 'tables/circle_member.dart';
export 'tables/companion_device.dart';
export 'tables/utterance.dart';
export 'tables/voice_clip.dart';

class Protocol extends _is.DatabaseSerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._().._registerHostProtocols();

  static List<_isp.TableDefinition> get targetTableDefinitions => [
    _isp.TableDefinition(
      name: 'alert',
      dartName: 'Alert',
      schema: 'public',
      module: 'lifeline',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'circleId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'checkInId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'kind',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:AlertKind',
        ),
        _isp.ColumnDefinition(
          name: 'level',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:AlertLevel',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'detail',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'acknowledgedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'acknowledgedByName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'resolvedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'resolvedByName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'alert_fk_0',
          columns: ['circleId'],
          referenceTable: 'circle',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'alert_circle_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'circleId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'resolvedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'check_in',
      dartName: 'CheckIn',
      schema: 'public',
      module: 'lifeline',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'circleId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'kind',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:CheckInKind',
        ),
        _isp.ColumnDefinition(
          name: 'slotId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'scheduledFor',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'promptedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _isp.ColumnDefinition(
          name: 'promptText',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:CheckInStatus',
        ),
        _isp.ColumnDefinition(
          name: 'escalationStage',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
          columnDefault: '0',
        ),
        _isp.ColumnDefinition(
          name: 'respondedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _isp.ColumnDefinition(
          name: 'responseMethod',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:ResponseMethod?',
        ),
        _isp.ColumnDefinition(
          name: 'transcript',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'triageLevel',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'protocol:TriageLevel?',
        ),
        _isp.ColumnDefinition(
          name: 'triageReasons',
          columnType: _isp.ColumnType.json,
          isNullable: true,
          dartType: 'List<String>?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'check_in_fk_0',
          columns: ['circleId'],
          referenceTable: 'circle',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'check_in_circle_prompted_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'circleId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'promptedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'check_in_occurrence_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'circleId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'scheduledFor',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'check_in_slot',
      dartName: 'CheckInSlot',
      schema: 'public',
      module: 'lifeline',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'circleId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'minuteOfDay',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'label',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'check_in_slot_fk_0',
          columns: ['circleId'],
          referenceTable: 'circle',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'check_in_slot_circle_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'circleId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'circle',
      dartName: 'Circle',
      schema: 'public',
      module: 'lifeline',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'lovedOneName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'voiceId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'utcOffsetMinutes',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'graceSeconds',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'secondGraceSeconds',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'pairingCode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'inviteCode',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'status',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:CircleStatus',
          columnDefault: '\'quiet\'',
        ),
        _isp.ColumnDefinition(
          name: 'statusChangedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'isDemo',
          columnType: _isp.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'circle_pairing_code_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'pairingCode',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'circle_invite_code_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'inviteCode',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'circle_event',
      dartName: 'CircleEvent',
      schema: 'public',
      module: 'lifeline',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'circleId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'kind',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:EventKind',
        ),
        _isp.ColumnDefinition(
          name: 'title',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'detail',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'actorName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'checkInId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'circle_event_fk_0',
          columns: ['circleId'],
          referenceTable: 'circle',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'circle_event_circle_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'circleId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'circle_member',
      dartName: 'CircleMember',
      schema: 'public',
      module: 'lifeline',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'circleId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'userIdentifier',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'displayName',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'relationship',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'role',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:MemberRole',
        ),
        _isp.ColumnDefinition(
          name: 'joinedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'circle_member_fk_0',
          columns: ['circleId'],
          referenceTable: 'circle',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'circle_member_unique_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'circleId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userIdentifier',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _isp.IndexDefinition(
          indexName: 'circle_member_user_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'userIdentifier',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'companion_device',
      dartName: 'CompanionDevice',
      schema: 'public',
      module: 'lifeline',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'circleId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'tokenHash',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'label',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'pairedAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
        _isp.ColumnDefinition(
          name: 'lastSeenAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'companion_device_fk_0',
          columns: ['circleId'],
          referenceTable: 'circle',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'companion_device_token_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'tokenHash',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'utterance',
      dartName: 'Utterance',
      schema: 'public',
      module: 'lifeline',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'circleId',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'kind',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:UtteranceKind',
        ),
        _isp.ColumnDefinition(
          name: 'text',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'audioPath',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'fromName',
          columnType: _isp.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _isp.ColumnDefinition(
          name: 'checkInId',
          columnType: _isp.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [
        _isp.ForeignKeyDefinition(
          constraintName: 'utterance_fk_0',
          columns: ['circleId'],
          referenceTable: 'circle',
          referenceTableSchema: 'public',
          referenceColumns: ['id'],
          onUpdate: _isp.ForeignKeyAction.noAction,
          onDelete: _isp.ForeignKeyAction.cascade,
          matchType: null,
        ),
      ],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'utterance_circle_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'circleId',
            ),
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _isp.TableDefinition(
      name: 'voice_clip',
      dartName: 'VoiceClip',
      schema: 'public',
      module: 'lifeline',
      columns: [
        _isp.ColumnDefinition(
          name: 'id',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'serial',
        ),
        _isp.ColumnDefinition(
          name: 'hash',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'voiceId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'modelId',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'text',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'storagePath',
          columnType: _isp.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _isp.ColumnDefinition(
          name: 'byteLength',
          columnType: _isp.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _isp.ColumnDefinition(
          name: 'createdAt',
          columnType: _isp.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
          columnDefault: 'now',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _isp.IndexDefinition(
          indexName: 'voice_clip_hash_idx',
          tableSpace: null,
          elements: [
            _isp.IndexElementDefinition(
              type: _isp.IndexElementDefinitionType.column,
              definition: 'hash',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._iais.Protocol.targetTableDefinitions,
    ..._iacs.Protocol.targetTableDefinitions,
    ..._isp.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on _is.DeserializationClassNameNotFoundException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i3ka3h96.CircleSettings) {
      return _i3ka3h96.CircleSettings.fromJson(data) as T;
    }
    if (t == _i919q16d.CircleSignal) {
      return _i919q16d.CircleSignal.fromJson(data) as T;
    }
    if (t == _ifhasew7.CircleSnapshot) {
      return _ifhasew7.CircleSnapshot.fromJson(data) as T;
    }
    if (t == _iu17mqvp.CircleSummary) {
      return _iu17mqvp.CircleSummary.fromJson(data) as T;
    }
    if (t == _iulcjp1w.CompanionState) {
      return _iulcjp1w.CompanionState.fromJson(data) as T;
    }
    if (t == _i0j74by7.DemoSetup) {
      return _i0j74by7.DemoSetup.fromJson(data) as T;
    }
    if (t == _igma2i47.PairingResult) {
      return _igma2i47.PairingResult.fromJson(data) as T;
    }
    if (t == _iqedek9t.VoiceOption) {
      return _iqedek9t.VoiceOption.fromJson(data) as T;
    }
    if (t == _ituo13k3.VoiceReplyResult) {
      return _ituo13k3.VoiceReplyResult.fromJson(data) as T;
    }
    if (t == _i7t4x9tm.AlertKind) {
      return _i7t4x9tm.AlertKind.fromJson(data) as T;
    }
    if (t == _iubt32n2.AlertLevel) {
      return _iubt32n2.AlertLevel.fromJson(data) as T;
    }
    if (t == _ikmb3xjn.CheckInKind) {
      return _ikmb3xjn.CheckInKind.fromJson(data) as T;
    }
    if (t == _ijrvdr1p.CheckInStatus) {
      return _ijrvdr1p.CheckInStatus.fromJson(data) as T;
    }
    if (t == _i6qvt1rc.CircleStatus) {
      return _i6qvt1rc.CircleStatus.fromJson(data) as T;
    }
    if (t == _i27hojh9.EventKind) {
      return _i27hojh9.EventKind.fromJson(data) as T;
    }
    if (t == _ij50bjyb.LifelineErrorCode) {
      return _ij50bjyb.LifelineErrorCode.fromJson(data) as T;
    }
    if (t == _icimtxba.MemberRole) {
      return _icimtxba.MemberRole.fromJson(data) as T;
    }
    if (t == _igp5zq1l.ResponseMethod) {
      return _igp5zq1l.ResponseMethod.fromJson(data) as T;
    }
    if (t == _istrf3zd.TriageLevel) {
      return _istrf3zd.TriageLevel.fromJson(data) as T;
    }
    if (t == _ixwsitj3.UtteranceKind) {
      return _ixwsitj3.UtteranceKind.fromJson(data) as T;
    }
    if (t == _icanq7pd.CheckInFutureCallScheduledCheckInModel) {
      return _icanq7pd.CheckInFutureCallScheduledCheckInModel.fromJson(data)
          as T;
    }
    if (t == _iah8bc35.DemoCleanupFutureCallExpireModel) {
      return _iah8bc35.DemoCleanupFutureCallExpireModel.fromJson(data) as T;
    }
    if (t == _itbfoczd.EscalationFutureCallNoResponseModel) {
      return _itbfoczd.EscalationFutureCallNoResponseModel.fromJson(data) as T;
    }
    if (t == _irswewhe.LifelineException) {
      return _irswewhe.LifelineException.fromJson(data) as T;
    }
    if (t == _ix65b5hp.Alert) {
      return _ix65b5hp.Alert.fromJson(data) as T;
    }
    if (t == _i9wmztxc.CheckIn) {
      return _i9wmztxc.CheckIn.fromJson(data) as T;
    }
    if (t == _is1itcsv.CheckInSlot) {
      return _is1itcsv.CheckInSlot.fromJson(data) as T;
    }
    if (t == _is1kwm8w.Circle) {
      return _is1kwm8w.Circle.fromJson(data) as T;
    }
    if (t == _ii1xfzkz.CircleEvent) {
      return _ii1xfzkz.CircleEvent.fromJson(data) as T;
    }
    if (t == _isezf3zm.CircleMember) {
      return _isezf3zm.CircleMember.fromJson(data) as T;
    }
    if (t == _i34wu1yp.CompanionDevice) {
      return _i34wu1yp.CompanionDevice.fromJson(data) as T;
    }
    if (t == _ikx4o9d3.Utterance) {
      return _ikx4o9d3.Utterance.fromJson(data) as T;
    }
    if (t == _ibmgaguv.VoiceClip) {
      return _ibmgaguv.VoiceClip.fromJson(data) as T;
    }
    if (t == _is.getType<_i3ka3h96.CircleSettings?>()) {
      return (data != null ? _i3ka3h96.CircleSettings.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i919q16d.CircleSignal?>()) {
      return (data != null ? _i919q16d.CircleSignal.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ifhasew7.CircleSnapshot?>()) {
      return (data != null ? _ifhasew7.CircleSnapshot.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iu17mqvp.CircleSummary?>()) {
      return (data != null ? _iu17mqvp.CircleSummary.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iulcjp1w.CompanionState?>()) {
      return (data != null ? _iulcjp1w.CompanionState.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i0j74by7.DemoSetup?>()) {
      return (data != null ? _i0j74by7.DemoSetup.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_igma2i47.PairingResult?>()) {
      return (data != null ? _igma2i47.PairingResult.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_iqedek9t.VoiceOption?>()) {
      return (data != null ? _iqedek9t.VoiceOption.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ituo13k3.VoiceReplyResult?>()) {
      return (data != null ? _ituo13k3.VoiceReplyResult.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i7t4x9tm.AlertKind?>()) {
      return (data != null ? _i7t4x9tm.AlertKind.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_iubt32n2.AlertLevel?>()) {
      return (data != null ? _iubt32n2.AlertLevel.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ikmb3xjn.CheckInKind?>()) {
      return (data != null ? _ikmb3xjn.CheckInKind.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ijrvdr1p.CheckInStatus?>()) {
      return (data != null ? _ijrvdr1p.CheckInStatus.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_i6qvt1rc.CircleStatus?>()) {
      return (data != null ? _i6qvt1rc.CircleStatus.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i27hojh9.EventKind?>()) {
      return (data != null ? _i27hojh9.EventKind.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ij50bjyb.LifelineErrorCode?>()) {
      return (data != null ? _ij50bjyb.LifelineErrorCode.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_icimtxba.MemberRole?>()) {
      return (data != null ? _icimtxba.MemberRole.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_igp5zq1l.ResponseMethod?>()) {
      return (data != null ? _igp5zq1l.ResponseMethod.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_istrf3zd.TriageLevel?>()) {
      return (data != null ? _istrf3zd.TriageLevel.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ixwsitj3.UtteranceKind?>()) {
      return (data != null ? _ixwsitj3.UtteranceKind.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_icanq7pd.CheckInFutureCallScheduledCheckInModel?>()) {
      return (data != null
              ? _icanq7pd.CheckInFutureCallScheduledCheckInModel.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_iah8bc35.DemoCleanupFutureCallExpireModel?>()) {
      return (data != null
              ? _iah8bc35.DemoCleanupFutureCallExpireModel.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_itbfoczd.EscalationFutureCallNoResponseModel?>()) {
      return (data != null
              ? _itbfoczd.EscalationFutureCallNoResponseModel.fromJson(data)
              : null)
          as T;
    }
    if (t == _is.getType<_irswewhe.LifelineException?>()) {
      return (data != null ? _irswewhe.LifelineException.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ix65b5hp.Alert?>()) {
      return (data != null ? _ix65b5hp.Alert.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i9wmztxc.CheckIn?>()) {
      return (data != null ? _i9wmztxc.CheckIn.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_is1itcsv.CheckInSlot?>()) {
      return (data != null ? _is1itcsv.CheckInSlot.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_is1kwm8w.Circle?>()) {
      return (data != null ? _is1kwm8w.Circle.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ii1xfzkz.CircleEvent?>()) {
      return (data != null ? _ii1xfzkz.CircleEvent.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_isezf3zm.CircleMember?>()) {
      return (data != null ? _isezf3zm.CircleMember.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_i34wu1yp.CompanionDevice?>()) {
      return (data != null ? _i34wu1yp.CompanionDevice.fromJson(data) : null)
          as T;
    }
    if (t == _is.getType<_ikx4o9d3.Utterance?>()) {
      return (data != null ? _ikx4o9d3.Utterance.fromJson(data) : null) as T;
    }
    if (t == _is.getType<_ibmgaguv.VoiceClip?>()) {
      return (data != null ? _ibmgaguv.VoiceClip.fromJson(data) : null) as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_isezf3zm.CircleMember>) {
      return (data as List)
              .map((e) => deserialize<_isezf3zm.CircleMember>(e))
              .toList()
          as T;
    }
    if (t == List<_is1itcsv.CheckInSlot>) {
      return (data as List)
              .map((e) => deserialize<_is1itcsv.CheckInSlot>(e))
              .toList()
          as T;
    }
    if (t == List<_i9wmztxc.CheckIn>) {
      return (data as List)
              .map((e) => deserialize<_i9wmztxc.CheckIn>(e))
              .toList()
          as T;
    }
    if (t == List<_ix65b5hp.Alert>) {
      return (data as List).map((e) => deserialize<_ix65b5hp.Alert>(e)).toList()
          as T;
    }
    if (t == List<_ii1xfzkz.CircleEvent>) {
      return (data as List)
              .map((e) => deserialize<_ii1xfzkz.CircleEvent>(e))
              .toList()
          as T;
    }
    if (t == List<_ikx4o9d3.Utterance>) {
      return (data as List)
              .map((e) => deserialize<_ikx4o9d3.Utterance>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _is.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i05ls1zs.VoiceOption>) {
      return (data as List)
              .map((e) => deserialize<_i05ls1zs.VoiceOption>(e))
              .toList()
          as T;
    }
    if (t == List<_iposvplt.CircleSummary>) {
      return (data as List)
              .map((e) => deserialize<_iposvplt.CircleSummary>(e))
              .toList()
          as T;
    }
    try {
      return _iais.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _iacs.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _isp.Protocol().deserialize<T>(data, t);
    } on _is.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i3ka3h96.CircleSettings => 'CircleSettings',
      _i919q16d.CircleSignal => 'CircleSignal',
      _ifhasew7.CircleSnapshot => 'CircleSnapshot',
      _iu17mqvp.CircleSummary => 'CircleSummary',
      _iulcjp1w.CompanionState => 'CompanionState',
      _i0j74by7.DemoSetup => 'DemoSetup',
      _igma2i47.PairingResult => 'PairingResult',
      _iqedek9t.VoiceOption => 'VoiceOption',
      _ituo13k3.VoiceReplyResult => 'VoiceReplyResult',
      _i7t4x9tm.AlertKind => 'AlertKind',
      _iubt32n2.AlertLevel => 'AlertLevel',
      _ikmb3xjn.CheckInKind => 'CheckInKind',
      _ijrvdr1p.CheckInStatus => 'CheckInStatus',
      _i6qvt1rc.CircleStatus => 'CircleStatus',
      _i27hojh9.EventKind => 'EventKind',
      _ij50bjyb.LifelineErrorCode => 'LifelineErrorCode',
      _icimtxba.MemberRole => 'MemberRole',
      _igp5zq1l.ResponseMethod => 'ResponseMethod',
      _istrf3zd.TriageLevel => 'TriageLevel',
      _ixwsitj3.UtteranceKind => 'UtteranceKind',
      _icanq7pd.CheckInFutureCallScheduledCheckInModel =>
        'CheckInFutureCallScheduledCheckInModel',
      _iah8bc35.DemoCleanupFutureCallExpireModel =>
        'DemoCleanupFutureCallExpireModel',
      _itbfoczd.EscalationFutureCallNoResponseModel =>
        'EscalationFutureCallNoResponseModel',
      _irswewhe.LifelineException => 'LifelineException',
      _ix65b5hp.Alert => 'Alert',
      _i9wmztxc.CheckIn => 'CheckIn',
      _is1itcsv.CheckInSlot => 'CheckInSlot',
      _is1kwm8w.Circle => 'Circle',
      _ii1xfzkz.CircleEvent => 'CircleEvent',
      _isezf3zm.CircleMember => 'CircleMember',
      _i34wu1yp.CompanionDevice => 'CompanionDevice',
      _ikx4o9d3.Utterance => 'Utterance',
      _ibmgaguv.VoiceClip => 'VoiceClip',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('lifeline.', '');
    }

    switch (data) {
      case _i3ka3h96.CircleSettings():
        return 'CircleSettings';
      case _i919q16d.CircleSignal():
        return 'CircleSignal';
      case _ifhasew7.CircleSnapshot():
        return 'CircleSnapshot';
      case _iu17mqvp.CircleSummary():
        return 'CircleSummary';
      case _iulcjp1w.CompanionState():
        return 'CompanionState';
      case _i0j74by7.DemoSetup():
        return 'DemoSetup';
      case _igma2i47.PairingResult():
        return 'PairingResult';
      case _iqedek9t.VoiceOption():
        return 'VoiceOption';
      case _ituo13k3.VoiceReplyResult():
        return 'VoiceReplyResult';
      case _i7t4x9tm.AlertKind():
        return 'AlertKind';
      case _iubt32n2.AlertLevel():
        return 'AlertLevel';
      case _ikmb3xjn.CheckInKind():
        return 'CheckInKind';
      case _ijrvdr1p.CheckInStatus():
        return 'CheckInStatus';
      case _i6qvt1rc.CircleStatus():
        return 'CircleStatus';
      case _i27hojh9.EventKind():
        return 'EventKind';
      case _ij50bjyb.LifelineErrorCode():
        return 'LifelineErrorCode';
      case _icimtxba.MemberRole():
        return 'MemberRole';
      case _igp5zq1l.ResponseMethod():
        return 'ResponseMethod';
      case _istrf3zd.TriageLevel():
        return 'TriageLevel';
      case _ixwsitj3.UtteranceKind():
        return 'UtteranceKind';
      case _icanq7pd.CheckInFutureCallScheduledCheckInModel():
        return 'CheckInFutureCallScheduledCheckInModel';
      case _iah8bc35.DemoCleanupFutureCallExpireModel():
        return 'DemoCleanupFutureCallExpireModel';
      case _itbfoczd.EscalationFutureCallNoResponseModel():
        return 'EscalationFutureCallNoResponseModel';
      case _irswewhe.LifelineException():
        return 'LifelineException';
      case _ix65b5hp.Alert():
        return 'Alert';
      case _i9wmztxc.CheckIn():
        return 'CheckIn';
      case _is1itcsv.CheckInSlot():
        return 'CheckInSlot';
      case _is1kwm8w.Circle():
        return 'Circle';
      case _ii1xfzkz.CircleEvent():
        return 'CircleEvent';
      case _isezf3zm.CircleMember():
        return 'CircleMember';
      case _i34wu1yp.CompanionDevice():
        return 'CompanionDevice';
      case _ikx4o9d3.Utterance():
        return 'Utterance';
      case _ibmgaguv.VoiceClip():
        return 'VoiceClip';
    }
    className = _iais.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_idp.$className';
    }
    className = _iacs.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.')
          ? className
          : 'serverpod_auth_core.$className';
    }
    className = _isp.Protocol().getClassNameForObject(data);
    if (className != null) {
      return className.contains('.') ? className : 'serverpod.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'CircleSettings') {
      return deserialize<_i3ka3h96.CircleSettings>(data['data']);
    }
    if (dataClassName == 'CircleSignal') {
      return deserialize<_i919q16d.CircleSignal>(data['data']);
    }
    if (dataClassName == 'CircleSnapshot') {
      return deserialize<_ifhasew7.CircleSnapshot>(data['data']);
    }
    if (dataClassName == 'CircleSummary') {
      return deserialize<_iu17mqvp.CircleSummary>(data['data']);
    }
    if (dataClassName == 'CompanionState') {
      return deserialize<_iulcjp1w.CompanionState>(data['data']);
    }
    if (dataClassName == 'DemoSetup') {
      return deserialize<_i0j74by7.DemoSetup>(data['data']);
    }
    if (dataClassName == 'PairingResult') {
      return deserialize<_igma2i47.PairingResult>(data['data']);
    }
    if (dataClassName == 'VoiceOption') {
      return deserialize<_iqedek9t.VoiceOption>(data['data']);
    }
    if (dataClassName == 'VoiceReplyResult') {
      return deserialize<_ituo13k3.VoiceReplyResult>(data['data']);
    }
    if (dataClassName == 'AlertKind') {
      return deserialize<_i7t4x9tm.AlertKind>(data['data']);
    }
    if (dataClassName == 'AlertLevel') {
      return deserialize<_iubt32n2.AlertLevel>(data['data']);
    }
    if (dataClassName == 'CheckInKind') {
      return deserialize<_ikmb3xjn.CheckInKind>(data['data']);
    }
    if (dataClassName == 'CheckInStatus') {
      return deserialize<_ijrvdr1p.CheckInStatus>(data['data']);
    }
    if (dataClassName == 'CircleStatus') {
      return deserialize<_i6qvt1rc.CircleStatus>(data['data']);
    }
    if (dataClassName == 'EventKind') {
      return deserialize<_i27hojh9.EventKind>(data['data']);
    }
    if (dataClassName == 'LifelineErrorCode') {
      return deserialize<_ij50bjyb.LifelineErrorCode>(data['data']);
    }
    if (dataClassName == 'MemberRole') {
      return deserialize<_icimtxba.MemberRole>(data['data']);
    }
    if (dataClassName == 'ResponseMethod') {
      return deserialize<_igp5zq1l.ResponseMethod>(data['data']);
    }
    if (dataClassName == 'TriageLevel') {
      return deserialize<_istrf3zd.TriageLevel>(data['data']);
    }
    if (dataClassName == 'UtteranceKind') {
      return deserialize<_ixwsitj3.UtteranceKind>(data['data']);
    }
    if (dataClassName == 'CheckInFutureCallScheduledCheckInModel') {
      return deserialize<_icanq7pd.CheckInFutureCallScheduledCheckInModel>(
        data['data'],
      );
    }
    if (dataClassName == 'DemoCleanupFutureCallExpireModel') {
      return deserialize<_iah8bc35.DemoCleanupFutureCallExpireModel>(
        data['data'],
      );
    }
    if (dataClassName == 'EscalationFutureCallNoResponseModel') {
      return deserialize<_itbfoczd.EscalationFutureCallNoResponseModel>(
        data['data'],
      );
    }
    if (dataClassName == 'LifelineException') {
      return deserialize<_irswewhe.LifelineException>(data['data']);
    }
    if (dataClassName == 'Alert') {
      return deserialize<_ix65b5hp.Alert>(data['data']);
    }
    if (dataClassName == 'CheckIn') {
      return deserialize<_i9wmztxc.CheckIn>(data['data']);
    }
    if (dataClassName == 'CheckInSlot') {
      return deserialize<_is1itcsv.CheckInSlot>(data['data']);
    }
    if (dataClassName == 'Circle') {
      return deserialize<_is1kwm8w.Circle>(data['data']);
    }
    if (dataClassName == 'CircleEvent') {
      return deserialize<_ii1xfzkz.CircleEvent>(data['data']);
    }
    if (dataClassName == 'CircleMember') {
      return deserialize<_isezf3zm.CircleMember>(data['data']);
    }
    if (dataClassName == 'CompanionDevice') {
      return deserialize<_i34wu1yp.CompanionDevice>(data['data']);
    }
    if (dataClassName == 'Utterance') {
      return deserialize<_ikx4o9d3.Utterance>(data['data']);
    }
    if (dataClassName == 'VoiceClip') {
      return deserialize<_ibmgaguv.VoiceClip>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _iais.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _iacs.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _isp.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  void _registerHostProtocols() {
    _iais.Protocol().registerHostProtocol('lifeline', this);
    _iacs.Protocol().registerHostProtocol('lifeline', this);
  }

  @override
  _is.Table? getTableForType(Type t) {
    {
      var table = _iais.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _iacs.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _isp.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _ix65b5hp.Alert:
        return _ix65b5hp.Alert.t;
      case _i9wmztxc.CheckIn:
        return _i9wmztxc.CheckIn.t;
      case _is1itcsv.CheckInSlot:
        return _is1itcsv.CheckInSlot.t;
      case _is1kwm8w.Circle:
        return _is1kwm8w.Circle.t;
      case _ii1xfzkz.CircleEvent:
        return _ii1xfzkz.CircleEvent.t;
      case _isezf3zm.CircleMember:
        return _isezf3zm.CircleMember.t;
      case _i34wu1yp.CompanionDevice:
        return _i34wu1yp.CompanionDevice.t;
      case _ikx4o9d3.Utterance:
        return _ikx4o9d3.Utterance.t;
      case _ibmgaguv.VoiceClip:
        return _ibmgaguv.VoiceClip.t;
    }
    return null;
  }

  @override
  List<_isp.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'lifeline';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _iais.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _iacs.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
