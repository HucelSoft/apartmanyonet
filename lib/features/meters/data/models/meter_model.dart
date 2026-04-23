import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:apartmanyonet/core/constants/app_enums.dart';
import 'package:apartmanyonet/core/utils/pb_json_helpers.dart';

part 'meter_model.freezed.dart';
part 'meter_model.g.dart';

@freezed
abstract class MeterModel with _$MeterModel {
  const MeterModel._();

  static const String collectionName = 'meters';

  const factory MeterModel({
    required String id,

    /// Utility type (water / gas / electric). Empty string treated as [null].
    @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
    MeterType? type,

    /// Date the meter was read. PocketBase field: `read_date`.
    @JsonKey(
      name: 'read_date',
      fromJson: parsePbDateNullable,
      toJson: formatPbDateNullable,
    )
    DateTime? readDate,

    double? previous,
    double? current,

    /// Computed consumption (current − previous).
    double? usage,

    /// ID of the related [flat] record (optional).
    @JsonKey(fromJson: parseRelationIdNullable)
    String? flat,

    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime created,

    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime updated,

    @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)
    DateTime? deleted,
  }) = _MeterModel;

  factory MeterModel.fromJson(Map<String, dynamic> json) =>
      _$MeterModelFromJson(json);
}
