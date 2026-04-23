// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContractModel _$ContractModelFromJson(Map<String, dynamic> json) =>
    _ContractModel(
      id: json['id'] as String,
      flat: parseRelationId(json['flat']),
      resident: parseRelationId(json['resident']),
      start: parsePbDate(json['start']),
      end: parsePbDate(json['end']),
      amount: (json['amount'] as num).toDouble(),
      paymentDueDay: (json['payment_due_day'] as num).toInt(),
      status: $enumDecode(_$ContractStatusEnumMap, json['status']),
      created: parsePbDate(json['created']),
      updated: parsePbDate(json['updated']),
      deleted: parsePbDateNullable(json['deleted']),
    );

Map<String, dynamic> _$ContractModelToJson(_ContractModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'flat': instance.flat,
      'resident': instance.resident,
      'start': formatPbDate(instance.start),
      'end': formatPbDate(instance.end),
      'amount': instance.amount,
      'payment_due_day': instance.paymentDueDay,
      'status': _$ContractStatusEnumMap[instance.status]!,
      'created': formatPbDate(instance.created),
      'updated': formatPbDate(instance.updated),
      'deleted': formatPbDateNullable(instance.deleted),
    };

const _$ContractStatusEnumMap = {
  ContractStatus.expired: 'expired',
  ContractStatus.active: 'active',
  ContractStatus.terminated: 'terminated',
};
