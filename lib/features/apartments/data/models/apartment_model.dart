import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:apartmanyonet/core/utils/pb_json_helpers.dart';

part 'apartment_model.freezed.dart';
part 'apartment_model.g.dart';

@freezed
abstract class ApartmentModel with _$ApartmentModel {
  const ApartmentModel._();

  static const String collectionName = 'apartment';

  const factory ApartmentModel({
    required String id,
    required String name,
    String? address,

    /// Total number of flat units in this building.
    required int flats,
    required int floors,

    /// Optional block label (e.g. "A Block"). PocketBase field: `block_name`.
    @JsonKey(name: 'block_name')
    String? blockName,

    /// ID of the parent [organization] record.
    @JsonKey(fromJson: parseRelationId)
    required String organization,

    /// ID of the parent [site] record.
    @JsonKey(fromJson: parseRelationId)
    required String site,

    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime created,

    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime updated,

    @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)
    DateTime? deleted,
  }) = _ApartmentModel;

  factory ApartmentModel.fromJson(Map<String, dynamic> json) =>
      _$ApartmentModelFromJson(json);
}
