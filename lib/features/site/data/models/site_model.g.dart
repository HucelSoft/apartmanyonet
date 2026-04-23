// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SiteModel _$SiteModelFromJson(Map<String, dynamic> json) => _SiteModel(
  id: json['id'] as String,
  name: json['name'] as String,
  address: json['address'] as String?,
  organization: parseRelationId(json['organization']),
  created: parsePbDate(json['created']),
  updated: parsePbDate(json['updated']),
  deleted: parsePbDateNullable(json['deleted']),
);

Map<String, dynamic> _$SiteModelToJson(_SiteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'organization': instance.organization,
      'created': formatPbDate(instance.created),
      'updated': formatPbDate(instance.updated),
      'deleted': formatPbDateNullable(instance.deleted),
    };
