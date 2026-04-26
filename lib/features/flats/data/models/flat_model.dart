import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:apartmanyonet/core/constants/app_enums.dart';
import 'package:apartmanyonet/core/utils/pb_json_helpers.dart';

part 'flat_model.freezed.dart';
part 'flat_model.g.dart';

@freezed
abstract class FlatModel with _$FlatModel {
  const FlatModel._();

  static const String collectionName = 'flat';

  const factory FlatModel({
    required String id,

    /// Flat / unit number within the building (integer).
    /// Field name in PocketBase is also `flat`.
    required int flat,

    /// ID of the parent [apartment] record.
    @JsonKey(fromJson: parseRelationId)
    required String apartment,

    /// ID of the parent [organization] record.
    @JsonKey(fromJson: parseRelationId)
    required String organization,

    /// ID of the parent [site] record.
    @JsonKey(fromJson: parseRelationId)
    required String site,

    required FlatStatus status,


    /// ID of the currently active [contract] record (optional).
    @JsonKey(fromJson: parseRelationIdNullable)
    String? contract,

    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime created,

    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime updated,

    @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)
    DateTime? deleted,
  }) = _FlatModel;

  factory FlatModel.fromJson(Map<String, dynamic> json) =>
      _$FlatModelFromJson(json);
}
