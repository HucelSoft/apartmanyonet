// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OrganizationModel _$OrganizationModelFromJson(Map<String, dynamic> json) =>
    _OrganizationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      code: (json['code'] as num?)?.toDouble(),
      created: parsePbDate(json['created']),
      updated: parsePbDate(json['updated']),
      deleted: parsePbDateNullable(json['deleted']),
    );

Map<String, dynamic> _$OrganizationModelToJson(_OrganizationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'created': formatPbDate(instance.created),
      'updated': formatPbDate(instance.updated),
      'deleted': formatPbDateNullable(instance.deleted),
    };
