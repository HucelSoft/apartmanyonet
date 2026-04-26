// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meter_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MeterTypeModel _$MeterTypeModelFromJson(Map<String, dynamic> json) =>
    _MeterTypeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      organization: parseRelationId(json['organization']),
      created: parsePbDate(json['created']),
      updated: parsePbDate(json['updated']),
      deleted: parsePbDateNullable(json['deleted']),
    );

Map<String, dynamic> _$MeterTypeModelToJson(_MeterTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'organization': instance.organization,
      'created': formatPbDate(instance.created),
      'updated': formatPbDate(instance.updated),
      'deleted': formatPbDateNullable(instance.deleted),
    };
