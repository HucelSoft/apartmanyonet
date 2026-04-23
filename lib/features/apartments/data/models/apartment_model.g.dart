// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apartment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApartmentModel _$ApartmentModelFromJson(Map<String, dynamic> json) =>
    _ApartmentModel(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String?,
      flats: (json['flats'] as num).toInt(),
      floors: (json['floors'] as num).toInt(),
      blockName: json['block_name'] as String?,
      organization: parseRelationId(json['organization']),
      site: parseRelationId(json['site']),
      created: parsePbDate(json['created']),
      updated: parsePbDate(json['updated']),
      deleted: parsePbDateNullable(json['deleted']),
    );

Map<String, dynamic> _$ApartmentModelToJson(_ApartmentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'flats': instance.flats,
      'floors': instance.floors,
      'block_name': instance.blockName,
      'organization': instance.organization,
      'site': instance.site,
      'created': formatPbDate(instance.created),
      'updated': formatPbDate(instance.updated),
      'deleted': formatPbDateNullable(instance.deleted),
    };
