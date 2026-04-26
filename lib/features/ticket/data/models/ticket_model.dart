import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:apartmanyonet/core/constants/app_enums.dart';
import 'package:apartmanyonet/core/utils/pb_json_helpers.dart';

part 'ticket_model.freezed.dart';
part 'ticket_model.g.dart';

@freezed
abstract class TicketModel with _$TicketModel {
  const TicketModel._();

  static const String collectionName = 'ticket';

  const factory TicketModel({
    required String id,

    String? title,
    String? description,

    /// Optional priority; empty string from PocketBase is treated as [null].
    @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
    TicketPriority? priority,

    /// Optional status; empty string from PocketBase is treated as [null].
    @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
    RecordStatus? status,

    /// ID of the related [apartment] record (optional).
    @JsonKey(fromJson: parseRelationIdNullable)
    String? apartment,

    /// ID of the related [site] record (optional).
    @JsonKey(fromJson: parseRelationIdNullable)
    String? site,

    /// ID of the related [flat] record (optional).
    @JsonKey(fromJson: parseRelationIdNullable)
    String? flat,

    /// ID of the parent [organization] record (optional).
    @JsonKey(fromJson: parseRelationIdNullable)
    String? organization,

    /// Attached photo filename (single file field; empty string == no photo).
    String? photos,

    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime created,

    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime updated,

    @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)
    DateTime? deleted,
  }) = _TicketModel;

  factory TicketModel.fromJson(Map<String, dynamic> json) =>
      _$TicketModelFromJson(json);
}
