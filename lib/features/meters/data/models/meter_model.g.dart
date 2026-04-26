// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MeterModel _$MeterModelFromJson(Map<String, dynamic> json) => _MeterModel(
  id: json['id'] as String,
  type: parseRelationIdNullable(json['type']),
  readDate: parsePbDateNullable(json['read_date']),
  previous: (json['previous'] as num?)?.toDouble(),
  current: (json['current'] as num?)?.toDouble(),
  usage: (json['usage'] as num?)?.toDouble(),
  flat: parseRelationIdNullable(json['flat']),
  created: parsePbDate(json['created']),
  updated: parsePbDate(json['updated']),
  deleted: parsePbDateNullable(json['deleted']),
);

Map<String, dynamic> _$MeterModelToJson(_MeterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'read_date': formatPbDateNullable(instance.readDate),
      'previous': instance.previous,
      'current': instance.current,
      'usage': instance.usage,
      'flat': instance.flat,
      'created': formatPbDate(instance.created),
      'updated': formatPbDate(instance.updated),
      'deleted': formatPbDateNullable(instance.deleted),
    };
