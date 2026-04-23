import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:apartmanyonet/core/constants/app_enums.dart';
import 'package:apartmanyonet/core/utils/pb_json_helpers.dart';

part 'transaction_type_model.freezed.dart';
part 'transaction_type_model.g.dart';

@freezed
abstract class TransactionTypeModel with _$TransactionTypeModel {
  const TransactionTypeModel._();

  static const String collectionName = 'transaction_type';

  const factory TransactionTypeModel({
    required String id,

    /// Human-readable label for this type (e.g. "Monthly Rent", "Building Fee").
    /// PocketBase field: `type` (text).
    required String type,

    String? description,

    /// Whether this type represents incoming (credit) or outgoing (debit) money.
    required TransactionGenre genre,

    /// ID of the parent [organization] record.
    @JsonKey(fromJson: parseRelationId)
    required String organization,

    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime created,

    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime updated,

    @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)
    DateTime? deleted,
  }) = _TransactionTypeModel;

  factory TransactionTypeModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionTypeModelFromJson(json);
}
