import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:apartmanyonet/core/constants/app_enums.dart';
import 'package:apartmanyonet/core/utils/pb_json_helpers.dart';

part 'resident_model.freezed.dart';
part 'resident_model.g.dart';

@freezed
abstract class ResidentModel with _$ResidentModel {
  const ResidentModel._();

  static const String collectionName = 'resident';

  const factory ResidentModel({
    required String id,

    String? name,
    String? surname,

    @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
    PersonType? type,

    String? email,
    String? phone,

    /// ID of the parent [organization] record.
    @JsonKey(fromJson: parseRelationIdNullable)
    String? organization,

    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime created,

    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime updated,

    @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)
    DateTime? deleted,
  }) = _ResidentModel;

  factory ResidentModel.fromJson(Map<String, dynamic> json) =>
      _$ResidentModelFromJson(json);
}
