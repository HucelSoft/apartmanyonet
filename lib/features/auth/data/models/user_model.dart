import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:apartmanyonet/core/constants/app_enums.dart';
import 'package:apartmanyonet/core/utils/pb_json_helpers.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const UserModel._();

  static const String collectionName = 'users';

  const factory UserModel({
    required String id,
    required String email,

    /// PocketBase returns this as camelCase (`emailVisibility`) – no rename needed.
    @Default(false) bool emailVisibility,
    @Default(false) bool verified,

    String? name,
    String? phone,

    /// Filename as stored in PocketBase (empty string == no avatar).
    String? avatar,

    /// ID of the related [organization] record (or expanded map).
    @JsonKey(fromJson: parseRelationId)
    required String organization,

    required UserRole role,

    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime created,

    @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)
    required DateTime updated,

    /// Soft-delete timestamp; `null` means the record is active.
    @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)
    DateTime? deleted,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
