import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:apartmanyonet/core/utils/pb_json_helpers.dart';

part 'meter_type_model.freezed.dart';
part 'meter_type_model.g.dart';

@freezed
abstract class MeterTypeModel with _$MeterTypeModel {
  const MeterTypeModel._();

  static const String collectionName = 'meter_type';

  const factory MeterTypeModel({
    required String id,

    required String name,
    String? description,

    /// ID of the parent [organization] record.
    @JsonKey(fromJson: parseRelationId)
    required String organization,

    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime created,

    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime updated,

    @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)
    DateTime? deleted,
  }) = _MeterTypeModel;

  factory MeterTypeModel.fromJson(Map<String, dynamic> json) =>
      _$MeterTypeModelFromJson(json);
}
