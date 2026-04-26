// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TicketModel {

 String get id; String? get title; String? get description;/// Optional priority; empty string from PocketBase is treated as [null].
@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) TicketPriority? get priority;/// Optional status; empty string from PocketBase is treated as [null].
@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) RecordStatus? get status;/// ID of the related [apartment] record (optional).
@JsonKey(fromJson: parseRelationIdNullable) String? get apartment;/// ID of the related [site] record (optional).
@JsonKey(fromJson: parseRelationIdNullable) String? get site;/// ID of the related [flat] record (optional).
@JsonKey(fromJson: parseRelationIdNullable) String? get flat;/// ID of the parent [organization] record (optional).
@JsonKey(fromJson: parseRelationIdNullable) String? get organization;/// Attached photo filename (single file field; empty string == no photo).
 String? get photos;@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime get created;@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime get updated;@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? get deleted;
/// Create a copy of TicketModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketModelCopyWith<TicketModel> get copyWith => _$TicketModelCopyWithImpl<TicketModel>(this as TicketModel, _$identity);

  /// Serializes this TicketModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.apartment, apartment) || other.apartment == apartment)&&(identical(other.site, site) || other.site == site)&&(identical(other.flat, flat) || other.flat == flat)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.photos, photos) || other.photos == photos)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,priority,status,apartment,site,flat,organization,photos,created,updated,deleted);

@override
String toString() {
  return 'TicketModel(id: $id, title: $title, description: $description, priority: $priority, status: $status, apartment: $apartment, site: $site, flat: $flat, organization: $organization, photos: $photos, created: $created, updated: $updated, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class $TicketModelCopyWith<$Res>  {
  factory $TicketModelCopyWith(TicketModel value, $Res Function(TicketModel) _then) = _$TicketModelCopyWithImpl;
@useResult
$Res call({
 String id, String? title, String? description,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) TicketPriority? priority,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) RecordStatus? status,@JsonKey(fromJson: parseRelationIdNullable) String? apartment,@JsonKey(fromJson: parseRelationIdNullable) String? site,@JsonKey(fromJson: parseRelationIdNullable) String? flat,@JsonKey(fromJson: parseRelationIdNullable) String? organization, String? photos,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime created,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime updated,@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? deleted
});




}
/// @nodoc
class _$TicketModelCopyWithImpl<$Res>
    implements $TicketModelCopyWith<$Res> {
  _$TicketModelCopyWithImpl(this._self, this._then);

  final TicketModel _self;
  final $Res Function(TicketModel) _then;

/// Create a copy of TicketModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = freezed,Object? description = freezed,Object? priority = freezed,Object? status = freezed,Object? apartment = freezed,Object? site = freezed,Object? flat = freezed,Object? organization = freezed,Object? photos = freezed,Object? created = null,Object? updated = null,Object? deleted = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TicketPriority?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RecordStatus?,apartment: freezed == apartment ? _self.apartment : apartment // ignore: cast_nullable_to_non_nullable
as String?,site: freezed == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as String?,flat: freezed == flat ? _self.flat : flat // ignore: cast_nullable_to_non_nullable
as String?,organization: freezed == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as String?,photos: freezed == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,deleted: freezed == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketModel].
extension TicketModelPatterns on TicketModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketModel value)  $default,){
final _that = this;
switch (_that) {
case _TicketModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketModel value)?  $default,){
final _that = this;
switch (_that) {
case _TicketModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? title,  String? description, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  TicketPriority? priority, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  RecordStatus? status, @JsonKey(fromJson: parseRelationIdNullable)  String? apartment, @JsonKey(fromJson: parseRelationIdNullable)  String? site, @JsonKey(fromJson: parseRelationIdNullable)  String? flat, @JsonKey(fromJson: parseRelationIdNullable)  String? organization,  String? photos, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? deleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.priority,_that.status,_that.apartment,_that.site,_that.flat,_that.organization,_that.photos,_that.created,_that.updated,_that.deleted);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? title,  String? description, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  TicketPriority? priority, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  RecordStatus? status, @JsonKey(fromJson: parseRelationIdNullable)  String? apartment, @JsonKey(fromJson: parseRelationIdNullable)  String? site, @JsonKey(fromJson: parseRelationIdNullable)  String? flat, @JsonKey(fromJson: parseRelationIdNullable)  String? organization,  String? photos, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? deleted)  $default,) {final _that = this;
switch (_that) {
case _TicketModel():
return $default(_that.id,_that.title,_that.description,_that.priority,_that.status,_that.apartment,_that.site,_that.flat,_that.organization,_that.photos,_that.created,_that.updated,_that.deleted);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? title,  String? description, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  TicketPriority? priority, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  RecordStatus? status, @JsonKey(fromJson: parseRelationIdNullable)  String? apartment, @JsonKey(fromJson: parseRelationIdNullable)  String? site, @JsonKey(fromJson: parseRelationIdNullable)  String? flat, @JsonKey(fromJson: parseRelationIdNullable)  String? organization,  String? photos, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? deleted)?  $default,) {final _that = this;
switch (_that) {
case _TicketModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.priority,_that.status,_that.apartment,_that.site,_that.flat,_that.organization,_that.photos,_that.created,_that.updated,_that.deleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketModel extends TicketModel {
  const _TicketModel({required this.id, this.title, this.description, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) this.priority, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) this.status, @JsonKey(fromJson: parseRelationIdNullable) this.apartment, @JsonKey(fromJson: parseRelationIdNullable) this.site, @JsonKey(fromJson: parseRelationIdNullable) this.flat, @JsonKey(fromJson: parseRelationIdNullable) this.organization, this.photos, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate) required this.created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate) required this.updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) this.deleted}): super._();
  factory _TicketModel.fromJson(Map<String, dynamic> json) => _$TicketModelFromJson(json);

@override final  String id;
@override final  String? title;
@override final  String? description;
/// Optional priority; empty string from PocketBase is treated as [null].
@override@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) final  TicketPriority? priority;
/// Optional status; empty string from PocketBase is treated as [null].
@override@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) final  RecordStatus? status;
/// ID of the related [apartment] record (optional).
@override@JsonKey(fromJson: parseRelationIdNullable) final  String? apartment;
/// ID of the related [site] record (optional).
@override@JsonKey(fromJson: parseRelationIdNullable) final  String? site;
/// ID of the related [flat] record (optional).
@override@JsonKey(fromJson: parseRelationIdNullable) final  String? flat;
/// ID of the parent [organization] record (optional).
@override@JsonKey(fromJson: parseRelationIdNullable) final  String? organization;
/// Attached photo filename (single file field; empty string == no photo).
@override final  String? photos;
@override@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) final  DateTime created;
@override@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) final  DateTime updated;
@override@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) final  DateTime? deleted;

/// Create a copy of TicketModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketModelCopyWith<_TicketModel> get copyWith => __$TicketModelCopyWithImpl<_TicketModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.status, status) || other.status == status)&&(identical(other.apartment, apartment) || other.apartment == apartment)&&(identical(other.site, site) || other.site == site)&&(identical(other.flat, flat) || other.flat == flat)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.photos, photos) || other.photos == photos)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,priority,status,apartment,site,flat,organization,photos,created,updated,deleted);

@override
String toString() {
  return 'TicketModel(id: $id, title: $title, description: $description, priority: $priority, status: $status, apartment: $apartment, site: $site, flat: $flat, organization: $organization, photos: $photos, created: $created, updated: $updated, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class _$TicketModelCopyWith<$Res> implements $TicketModelCopyWith<$Res> {
  factory _$TicketModelCopyWith(_TicketModel value, $Res Function(_TicketModel) _then) = __$TicketModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String? title, String? description,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) TicketPriority? priority,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) RecordStatus? status,@JsonKey(fromJson: parseRelationIdNullable) String? apartment,@JsonKey(fromJson: parseRelationIdNullable) String? site,@JsonKey(fromJson: parseRelationIdNullable) String? flat,@JsonKey(fromJson: parseRelationIdNullable) String? organization, String? photos,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime created,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime updated,@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? deleted
});




}
/// @nodoc
class __$TicketModelCopyWithImpl<$Res>
    implements _$TicketModelCopyWith<$Res> {
  __$TicketModelCopyWithImpl(this._self, this._then);

  final _TicketModel _self;
  final $Res Function(_TicketModel) _then;

/// Create a copy of TicketModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = freezed,Object? description = freezed,Object? priority = freezed,Object? status = freezed,Object? apartment = freezed,Object? site = freezed,Object? flat = freezed,Object? organization = freezed,Object? photos = freezed,Object? created = null,Object? updated = null,Object? deleted = freezed,}) {
  return _then(_TicketModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as TicketPriority?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RecordStatus?,apartment: freezed == apartment ? _self.apartment : apartment // ignore: cast_nullable_to_non_nullable
as String?,site: freezed == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as String?,flat: freezed == flat ? _self.flat : flat // ignore: cast_nullable_to_non_nullable
as String?,organization: freezed == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as String?,photos: freezed == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,deleted: freezed == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
