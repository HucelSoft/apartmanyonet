// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AnnouncementModel _$AnnouncementModelFromJson(Map<String, dynamic> json) =>
    _AnnouncementModel(
      id: json['id'] as String,
      organization: parseRelationId(json['organization']),
      site: parseRelationId(json['site']),
      title: json['title'] as String,
      content: json['content'] as String,
      created: parsePbDate(json['created']),
      updated: parsePbDate(json['updated']),
      deleted: parsePbDateNullable(json['deleted']),
    );

Map<String, dynamic> _$AnnouncementModelToJson(_AnnouncementModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'organization': instance.organization,
      'site': instance.site,
      'title': instance.title,
      'content': instance.content,
      'created': formatPbDate(instance.created),
      'updated': formatPbDate(instance.updated),
      'deleted': formatPbDateNullable(instance.deleted),
    };
