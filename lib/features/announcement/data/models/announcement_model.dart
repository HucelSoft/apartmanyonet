import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:apartmanyonet/core/utils/pb_json_helpers.dart';

part 'announcement_model.freezed.dart';
part 'announcement_model.g.dart';

@freezed
abstract class AnnouncementModel with _$AnnouncementModel {
  const AnnouncementModel._();

  static const String collectionName = 'announcement';

  const factory AnnouncementModel({
    required String id,

    /// ID of the parent [organization] record.
    @JsonKey(fromJson: parseRelationId)
    required String organization,

    /// ID of the parent [site] record.
    @JsonKey(fromJson: parseRelationId)
    required String site,

    required String title,
    required String content,

    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime created,

    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime updated,

    @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)
    DateTime? deleted,
  }) = _AnnouncementModel;

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementModelFromJson(json);
}
