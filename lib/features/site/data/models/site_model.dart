import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:apartmanyonet/core/utils/pb_json_helpers.dart';

part 'site_model.freezed.dart';
part 'site_model.g.dart';

@freezed
abstract class SiteModel with _$SiteModel {
  const SiteModel._();

  static const String collectionName = 'site';

  const factory SiteModel({
    required String id,
    required String name,
    String? address,

    /// ID of the parent [organization] record (or expanded map).
    @JsonKey(fromJson: parseRelationId)
    required String organization,

    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime created,

    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime updated,

    @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)
    DateTime? deleted,
  }) = _SiteModel;

  factory SiteModel.fromJson(Map<String, dynamic> json) =>
      _$SiteModelFromJson(json);
}
