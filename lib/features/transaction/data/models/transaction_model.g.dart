// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    _TransactionModel(
      id: json['id'] as String,
      amount: (json['amount'] as num?)?.toDouble(),
      type: parseRelationId(json['type']),
      description: json['description'] as String?,
      date: parsePbDate(json['date']),
      dueDate: parsePbDateNullable(json['due_date']),
      paymentDate: parsePbDateNullable(json['payment_date']),
      status: $enumDecode(_$RecordStatusEnumMap, json['status']),
      organization: parseRelationId(json['organization']),
      site: parseRelationId(json['site']),
      apartment: parseRelationId(json['apartment']),
      flat: parseRelationId(json['flat']),
      created: parsePbDate(json['created']),
      updated: parsePbDate(json['updated']),
      deleted: parsePbDateNullable(json['deleted']),
    );

Map<String, dynamic> _$TransactionModelToJson(_TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'type': instance.type,
      'description': instance.description,
      'date': formatPbDate(instance.date),
      'due_date': formatPbDateNullable(instance.dueDate),
      'payment_date': formatPbDateNullable(instance.paymentDate),
      'status': _$RecordStatusEnumMap[instance.status]!,
      'organization': instance.organization,
      'site': instance.site,
      'apartment': instance.apartment,
      'flat': instance.flat,
      'created': formatPbDate(instance.created),
      'updated': formatPbDate(instance.updated),
      'deleted': formatPbDateNullable(instance.deleted),
    };

const _$RecordStatusEnumMap = {
  RecordStatus.pending: 'pending',
  RecordStatus.completed: 'completed',
  RecordStatus.cancelled: 'cancelled',
};
