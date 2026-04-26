// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resident_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResidentModel {

 String get id; String? get name; String? get surname;@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) PersonType? get type; String? get email; String? get phone;/// ID of the parent [organization] record.
@JsonKey(fromJson: parseRelationIdNullable) String? get organization;@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime get created;@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime get updated;@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? get deleted;
/// Create a copy of ResidentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResidentModelCopyWith<ResidentModel> get copyWith => _$ResidentModelCopyWithImpl<ResidentModel>(this as ResidentModel, _$identity);

  /// Serializes this ResidentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResidentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.surname, surname) || other.surname == surname)&&(identical(other.type, type) || other.type == type)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,surname,type,email,phone,organization,created,updated,deleted);

@override
String toString() {
  return 'ResidentModel(id: $id, name: $name, surname: $surname, type: $type, email: $email, phone: $phone, organization: $organization, created: $created, updated: $updated, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class $ResidentModelCopyWith<$Res>  {
  factory $ResidentModelCopyWith(ResidentModel value, $Res Function(ResidentModel) _then) = _$ResidentModelCopyWithImpl;
@useResult
$Res call({
 String id, String? name, String? surname,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) PersonType? type, String? email, String? phone,@JsonKey(fromJson: parseRelationIdNullable) String? organization,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime created,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime updated,@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? deleted
});




}
/// @nodoc
class _$ResidentModelCopyWithImpl<$Res>
    implements $ResidentModelCopyWith<$Res> {
  _$ResidentModelCopyWithImpl(this._self, this._then);

  final ResidentModel _self;
  final $Res Function(ResidentModel) _then;

/// Create a copy of ResidentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? surname = freezed,Object? type = freezed,Object? email = freezed,Object? phone = freezed,Object? organization = freezed,Object? created = null,Object? updated = null,Object? deleted = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,surname: freezed == surname ? _self.surname : surname // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PersonType?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,organization: freezed == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,deleted: freezed == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ResidentModel].
extension ResidentModelPatterns on ResidentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResidentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResidentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResidentModel value)  $default,){
final _that = this;
switch (_that) {
case _ResidentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResidentModel value)?  $default,){
final _that = this;
switch (_that) {
case _ResidentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? name,  String? surname, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  PersonType? type,  String? email,  String? phone, @JsonKey(fromJson: parseRelationIdNullable)  String? organization, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? deleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResidentModel() when $default != null:
return $default(_that.id,_that.name,_that.surname,_that.type,_that.email,_that.phone,_that.organization,_that.created,_that.updated,_that.deleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? name,  String? surname, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  PersonType? type,  String? email,  String? phone, @JsonKey(fromJson: parseRelationIdNullable)  String? organization, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? deleted)  $default,) {final _that = this;
switch (_that) {
case _ResidentModel():
return $default(_that.id,_that.name,_that.surname,_that.type,_that.email,_that.phone,_that.organization,_that.created,_that.updated,_that.deleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? name,  String? surname, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)  PersonType? type,  String? email,  String? phone, @JsonKey(fromJson: parseRelationIdNullable)  String? organization, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? deleted)?  $default,) {final _that = this;
switch (_that) {
case _ResidentModel() when $default != null:
return $default(_that.id,_that.name,_that.surname,_that.type,_that.email,_that.phone,_that.organization,_that.created,_that.updated,_that.deleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResidentModel extends ResidentModel {
  const _ResidentModel({required this.id, this.name, this.surname, @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) this.type, this.email, this.phone, @JsonKey(fromJson: parseRelationIdNullable) this.organization, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate) required this.created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate) required this.updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) this.deleted}): super._();
  factory _ResidentModel.fromJson(Map<String, dynamic> json) => _$ResidentModelFromJson(json);

@override final  String id;
@override final  String? name;
@override final  String? surname;
@override@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) final  PersonType? type;
@override final  String? email;
@override final  String? phone;
/// ID of the parent [organization] record.
@override@JsonKey(fromJson: parseRelationIdNullable) final  String? organization;
@override@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) final  DateTime created;
@override@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) final  DateTime updated;
@override@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) final  DateTime? deleted;

/// Create a copy of ResidentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResidentModelCopyWith<_ResidentModel> get copyWith => __$ResidentModelCopyWithImpl<_ResidentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResidentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResidentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.surname, surname) || other.surname == surname)&&(identical(other.type, type) || other.type == type)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,surname,type,email,phone,organization,created,updated,deleted);

@override
String toString() {
  return 'ResidentModel(id: $id, name: $name, surname: $surname, type: $type, email: $email, phone: $phone, organization: $organization, created: $created, updated: $updated, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class _$ResidentModelCopyWith<$Res> implements $ResidentModelCopyWith<$Res> {
  factory _$ResidentModelCopyWith(_ResidentModel value, $Res Function(_ResidentModel) _then) = __$ResidentModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String? name, String? surname,@JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue) PersonType? type, String? email, String? phone,@JsonKey(fromJson: parseRelationIdNullable) String? organization,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime created,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime updated,@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? deleted
});




}
/// @nodoc
class __$ResidentModelCopyWithImpl<$Res>
    implements _$ResidentModelCopyWith<$Res> {
  __$ResidentModelCopyWithImpl(this._self, this._then);

  final _ResidentModel _self;
  final $Res Function(_ResidentModel) _then;

/// Create a copy of ResidentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? surname = freezed,Object? type = freezed,Object? email = freezed,Object? phone = freezed,Object? organization = freezed,Object? created = null,Object? updated = null,Object? deleted = freezed,}) {
  return _then(_ResidentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,surname: freezed == surname ? _self.surname : surname // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PersonType?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,organization: freezed == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,deleted: freezed == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
