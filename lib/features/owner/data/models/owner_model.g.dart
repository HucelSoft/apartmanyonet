// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OwnerModel _$OwnerModelFromJson(Map<String, dynamic> json) => _OwnerModel(
  id: json['id'] as String,
  name: json['name'] as String?,
  surname: json['surname'] as String?,
  type: $enumDecodeNullable(
    _$PersonTypeEnumMap,
    json['type'],
    unknownValue: JsonKey.nullForUndefinedEnumValue,
  ),
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  organization: parseRelationIdNullable(json['organization']),
  created: parsePbDate(json['created']),
  updated: parsePbDate(json['updated']),
  deleted: parsePbDateNullable(json['deleted']),
);

Map<String, dynamic> _$OwnerModelToJson(_OwnerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'type': _$PersonTypeEnumMap[instance.type],
      'email': instance.email,
      'phone': instance.phone,
      'organization': instance.organization,
      'created': formatPbDate(instance.created),
      'updated': formatPbDate(instance.updated),
      'deleted': formatPbDateNullable(instance.deleted),
    };

const _$PersonTypeEnumMap = {
  PersonType.individual: 'individual',
  PersonType.corporate: 'corporate',
};
