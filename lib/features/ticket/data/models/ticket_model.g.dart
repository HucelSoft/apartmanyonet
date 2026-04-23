// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TicketModel _$TicketModelFromJson(Map<String, dynamic> json) => _TicketModel(
  id: json['id'] as String,
  title: json['title'] as String?,
  description: json['description'] as String?,
  priority: $enumDecodeNullable(
    _$TicketPriorityEnumMap,
    json['priority'],
    unknownValue: JsonKey.nullForUndefinedEnumValue,
  ),
  status: $enumDecodeNullable(
    _$RecordStatusEnumMap,
    json['status'],
    unknownValue: JsonKey.nullForUndefinedEnumValue,
  ),
  resident: parseRelationIdNullable(json['resident']),
  flat: parseRelationIdNullable(json['flat']),
  organization: parseRelationIdNullable(json['organization']),
  photos: json['photos'] as String?,
  created: parsePbDate(json['created']),
  updated: parsePbDate(json['updated']),
  deleted: parsePbDateNullable(json['deleted']),
);

Map<String, dynamic> _$TicketModelToJson(_TicketModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'priority': _$TicketPriorityEnumMap[instance.priority],
      'status': _$RecordStatusEnumMap[instance.status],
      'resident': instance.resident,
      'flat': instance.flat,
      'organization': instance.organization,
      'photos': instance.photos,
      'created': formatPbDate(instance.created),
      'updated': formatPbDate(instance.updated),
      'deleted': formatPbDateNullable(instance.deleted),
    };

const _$TicketPriorityEnumMap = {
  TicketPriority.low: 'low',
  TicketPriority.medium: 'medium',
  TicketPriority.high: 'high',
  TicketPriority.veryHigh: 'very high',
  TicketPriority.urgent: 'urgent',
};

const _$RecordStatusEnumMap = {
  RecordStatus.pending: 'pending',
  RecordStatus.completed: 'completed',
  RecordStatus.cancelled: 'cancelled',
};
