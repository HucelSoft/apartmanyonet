import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:apartmanyonet/core/constants/app_enums.dart';
import 'package:apartmanyonet/core/utils/pb_json_helpers.dart';

part 'owner_model.freezed.dart';
part 'owner_model.g.dart';

@freezed
abstract class OwnerModel with _$OwnerModel {
  const OwnerModel._();

  static const String collectionName = 'owner';

  const factory OwnerModel({
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
  }) = _OwnerModel;

  factory OwnerModel.fromJson(Map<String, dynamic> json) =>
      _$OwnerModelFromJson(json);
}
