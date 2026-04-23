import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:apartmanyonet/core/constants/app_enums.dart';
import 'package:apartmanyonet/core/utils/pb_json_helpers.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
abstract class TransactionModel with _$TransactionModel {
  const TransactionModel._();

  static const String collectionName = 'transaction';

  const factory TransactionModel({
    required String id,

    double? amount,

    /// ID of the related [transaction_type] record (or expanded map).
    @JsonKey(fromJson: parseRelationId)
    required String type,

    String? description,

    /// Date on which the transaction was recorded.
    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime date,

    /// Optional payment deadline. PocketBase field: `due_date`.
    @JsonKey(
      name: 'due_date',
      fromJson: parsePbDateNullable,
      toJson: formatPbDateNullable,
    )
    DateTime? dueDate,

    /// Date on which payment was received. PocketBase field: `payment_date`.
    @JsonKey(
      name: 'payment_date',
      fromJson: parsePbDateNullable,
      toJson: formatPbDateNullable,
    )
    DateTime? paymentDate,

    required RecordStatus status,

    /// ID of the parent [organization] record.
    @JsonKey(fromJson: parseRelationId)
    required String organization,

    /// ID of the parent [site] record.
    @JsonKey(fromJson: parseRelationId)
    required String site,

    /// ID of the related [apartment] record.
    @JsonKey(fromJson: parseRelationId)
    required String apartment,

    /// ID of the related [flat] record.
    @JsonKey(fromJson: parseRelationId)
    required String flat,

    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime created,

    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime updated,

    @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)
    DateTime? deleted,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}
