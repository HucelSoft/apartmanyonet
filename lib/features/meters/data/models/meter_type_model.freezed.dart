// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meter_type_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MeterTypeModel {

 String get id; String get name; String? get description;/// ID of the parent [organization] record.
@JsonKey(fromJson: parseRelationId) String get organization;@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime get created;@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime get updated;@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? get deleted;
/// Create a copy of MeterTypeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeterTypeModelCopyWith<MeterTypeModel> get copyWith => _$MeterTypeModelCopyWithImpl<MeterTypeModel>(this as MeterTypeModel, _$identity);

  /// Serializes this MeterTypeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeterTypeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,organization,created,updated,deleted);

@override
String toString() {
  return 'MeterTypeModel(id: $id, name: $name, description: $description, organization: $organization, created: $created, updated: $updated, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class $MeterTypeModelCopyWith<$Res>  {
  factory $MeterTypeModelCopyWith(MeterTypeModel value, $Res Function(MeterTypeModel) _then) = _$MeterTypeModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description,@JsonKey(fromJson: parseRelationId) String organization,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime created,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime updated,@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? deleted
});




}
/// @nodoc
class _$MeterTypeModelCopyWithImpl<$Res>
    implements $MeterTypeModelCopyWith<$Res> {
  _$MeterTypeModelCopyWithImpl(this._self, this._then);

  final MeterTypeModel _self;
  final $Res Function(MeterTypeModel) _then;

/// Create a copy of MeterTypeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? organization = null,Object? created = null,Object? updated = null,Object? deleted = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,organization: null == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as String,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,deleted: freezed == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MeterTypeModel].
extension MeterTypeModelPatterns on MeterTypeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeterTypeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeterTypeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeterTypeModel value)  $default,){
final _that = this;
switch (_that) {
case _MeterTypeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeterTypeModel value)?  $default,){
final _that = this;
switch (_that) {
case _MeterTypeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description, @JsonKey(fromJson: parseRelationId)  String organization, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? deleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeterTypeModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.organization,_that.created,_that.updated,_that.deleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description, @JsonKey(fromJson: parseRelationId)  String organization, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? deleted)  $default,) {final _that = this;
switch (_that) {
case _MeterTypeModel():
return $default(_that.id,_that.name,_that.description,_that.organization,_that.created,_that.updated,_that.deleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description, @JsonKey(fromJson: parseRelationId)  String organization, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? deleted)?  $default,) {final _that = this;
switch (_that) {
case _MeterTypeModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.organization,_that.created,_that.updated,_that.deleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MeterTypeModel extends MeterTypeModel {
  const _MeterTypeModel({required this.id, required this.name, this.description, @JsonKey(fromJson: parseRelationId) required this.organization, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate) required this.created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate) required this.updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) this.deleted}): super._();
  factory _MeterTypeModel.fromJson(Map<String, dynamic> json) => _$MeterTypeModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? description;
/// ID of the parent [organization] record.
@override@JsonKey(fromJson: parseRelationId) final  String organization;
@override@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) final  DateTime created;
@override@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) final  DateTime updated;
@override@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) final  DateTime? deleted;

/// Create a copy of MeterTypeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeterTypeModelCopyWith<_MeterTypeModel> get copyWith => __$MeterTypeModelCopyWithImpl<_MeterTypeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeterTypeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeterTypeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,organization,created,updated,deleted);

@override
String toString() {
  return 'MeterTypeModel(id: $id, name: $name, description: $description, organization: $organization, created: $created, updated: $updated, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class _$MeterTypeModelCopyWith<$Res> implements $MeterTypeModelCopyWith<$Res> {
  factory _$MeterTypeModelCopyWith(_MeterTypeModel value, $Res Function(_MeterTypeModel) _then) = __$MeterTypeModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description,@JsonKey(fromJson: parseRelationId) String organization,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime created,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime updated,@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? deleted
});




}
/// @nodoc
class __$MeterTypeModelCopyWithImpl<$Res>
    implements _$MeterTypeModelCopyWith<$Res> {
  __$MeterTypeModelCopyWithImpl(this._self, this._then);

  final _MeterTypeModel _self;
  final $Res Function(_MeterTypeModel) _then;

/// Create a copy of MeterTypeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? organization = null,Object? created = null,Object? updated = null,Object? deleted = freezed,}) {
  return _then(_MeterTypeModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,organization: null == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as String,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,deleted: freezed == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
