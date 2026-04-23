// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FlatModel _$FlatModelFromJson(Map<String, dynamic> json) => _FlatModel(
  id: json['id'] as String,
  flat: (json['flat'] as num).toInt(),
  apartment: parseRelationId(json['apartment']),
  organization: parseRelationId(json['organization']),
  site: parseRelationId(json['site']),
  status: $enumDecode(_$FlatStatusEnumMap, json['status']),
  owner: parseRelationIdNullable(json['owner']),
  contract: parseRelationIdNullable(json['contract']),
  created: parsePbDate(json['created']),
  updated: parsePbDate(json['updated']),
  deleted: parsePbDateNullable(json['deleted']),
);

Map<String, dynamic> _$FlatModelToJson(_FlatModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'flat': instance.flat,
      'apartment': instance.apartment,
      'organization': instance.organization,
      'site': instance.site,
      'status': _$FlatStatusEnumMap[instance.status]!,
      'owner': instance.owner,
      'contract': instance.contract,
      'created': formatPbDate(instance.created),
      'updated': formatPbDate(instance.updated),
      'deleted': formatPbDateNullable(instance.deleted),
    };

const _$FlatStatusEnumMap = {
  FlatStatus.occupied: 'occupied',
  FlatStatus.vacant: 'vacant',
};
