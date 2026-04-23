// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  email: json['email'] as String,
  emailVisibility: json['emailVisibility'] as bool? ?? false,
  verified: json['verified'] as bool? ?? false,
  name: json['name'] as String?,
  phone: json['phone'] as String?,
  avatar: json['avatar'] as String?,
  organization: parseRelationId(json['organization']),
  role: $enumDecode(_$UserRoleEnumMap, json['role']),
  created: parsePbDate(json['created']),
  updated: parsePbDate(json['updated']),
  deleted: parsePbDateNullable(json['deleted']),
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'emailVisibility': instance.emailVisibility,
      'verified': instance.verified,
      'name': instance.name,
      'phone': instance.phone,
      'avatar': instance.avatar,
      'organization': instance.organization,
      'role': _$UserRoleEnumMap[instance.role]!,
      'created': formatPbDate(instance.created),
      'updated': formatPbDate(instance.updated),
      'deleted': formatPbDateNullable(instance.deleted),
    };

const _$UserRoleEnumMap = {
  UserRole.superAdmin: 'super_admin',
  UserRole.siteAdmin: 'site_admin',
  UserRole.resident: 'resident',
  UserRole.owner: 'owner',
};
