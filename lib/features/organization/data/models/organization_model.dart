import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:apartmanyonet/core/utils/pb_json_helpers.dart';

part 'organization_model.freezed.dart';
part 'organization_model.g.dart';

@freezed
abstract class OrganizationModel with _$OrganizationModel {
  const OrganizationModel._();

  static const String collectionName = 'organization';

  const factory OrganizationModel({
    required String id,
    required String name,

    /// Unique numeric code residents use to identify their organization.
    /// Stored as a number in PocketBase; represented as [double] to match the
    /// schema type (no `onlyInt` flag set).
    double? code,

    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime created,

    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime updated,

    @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)
    DateTime? deleted,
  }) = _OrganizationModel;

  factory OrganizationModel.fromJson(Map<String, dynamic> json) =>
      _$OrganizationModelFromJson(json);
}
