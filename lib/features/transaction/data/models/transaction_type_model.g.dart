// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionTypeModel _$TransactionTypeModelFromJson(
  Map<String, dynamic> json,
) => _TransactionTypeModel(
  id: json['id'] as String,
  type: json['type'] as String,
  description: json['description'] as String?,
  genre: $enumDecode(_$TransactionGenreEnumMap, json['genre']),
  organization: parseRelationId(json['organization']),
  created: parsePbDate(json['created']),
  updated: parsePbDate(json['updated']),
  deleted: parsePbDateNullable(json['deleted']),
);

Map<String, dynamic> _$TransactionTypeModelToJson(
  _TransactionTypeModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'type': instance.type,
  'description': instance.description,
  'genre': _$TransactionGenreEnumMap[instance.genre]!,
  'organization': instance.organization,
  'created': formatPbDate(instance.created),
  'updated': formatPbDate(instance.updated),
  'deleted': formatPbDateNullable(instance.deleted),
};

const _$TransactionGenreEnumMap = {
  TransactionGenre.debit: 'debit',
  TransactionGenre.credit: 'credit',
};
