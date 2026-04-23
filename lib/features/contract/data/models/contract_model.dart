import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:apartmanyonet/core/constants/app_enums.dart';
import 'package:apartmanyonet/core/utils/pb_json_helpers.dart';

part 'contract_model.freezed.dart';
part 'contract_model.g.dart';

@freezed
abstract class ContractModel with _$ContractModel {
  const ContractModel._();

  static const String collectionName = 'contract';

  const factory ContractModel({
    required String id,

    /// ID of the related [flat] record.
    @JsonKey(fromJson: parseRelationId)
    required String flat,

    /// ID of the resident [users] record.
    @JsonKey(fromJson: parseRelationId)
    required String resident,

    /// Lease start date.
    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime start,

    /// Lease end date.
    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime end,

    /// Monthly rent amount.
    required double amount,

    /// Day of the month on which payment is due (0–28).
    /// PocketBase field: `payment_due_day`.
    @JsonKey(name: 'payment_due_day')
    required int paymentDueDay,

    required ContractStatus status,

    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime created,

    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime updated,

    @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)
    DateTime? deleted,
  }) = _ContractModel;

  factory ContractModel.fromJson(Map<String, dynamic> json) =>
      _$ContractModelFromJson(json);
}
