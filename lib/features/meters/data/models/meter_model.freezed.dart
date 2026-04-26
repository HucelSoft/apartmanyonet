// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MeterModel {

 String get id;/// Utility type relation ID.
@JsonKey(fromJson: parseRelationIdNullable) String? get type;/// Date the meter was read. PocketBase field: `read_date`.
@JsonKey(name: 'read_date', fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? get readDate; double? get previous; double? get current;/// Computed consumption (current − previous).
 double? get usage;/// ID of the related [flat] record (optional).
@JsonKey(fromJson: parseRelationIdNullable) String? get flat;@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime get created;@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime get updated;@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? get deleted;
/// Create a copy of MeterModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeterModelCopyWith<MeterModel> get copyWith => _$MeterModelCopyWithImpl<MeterModel>(this as MeterModel, _$identity);

  /// Serializes this MeterModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeterModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.readDate, readDate) || other.readDate == readDate)&&(identical(other.previous, previous) || other.previous == previous)&&(identical(other.current, current) || other.current == current)&&(identical(other.usage, usage) || other.usage == usage)&&(identical(other.flat, flat) || other.flat == flat)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,readDate,previous,current,usage,flat,created,updated,deleted);

@override
String toString() {
  return 'MeterModel(id: $id, type: $type, readDate: $readDate, previous: $previous, current: $current, usage: $usage, flat: $flat, created: $created, updated: $updated, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class $MeterModelCopyWith<$Res>  {
  factory $MeterModelCopyWith(MeterModel value, $Res Function(MeterModel) _then) = _$MeterModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(fromJson: parseRelationIdNullable) String? type,@JsonKey(name: 'read_date', fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? readDate, double? previous, double? current, double? usage,@JsonKey(fromJson: parseRelationIdNullable) String? flat,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime created,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime updated,@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? deleted
});




}
/// @nodoc
class _$MeterModelCopyWithImpl<$Res>
    implements $MeterModelCopyWith<$Res> {
  _$MeterModelCopyWithImpl(this._self, this._then);

  final MeterModel _self;
  final $Res Function(MeterModel) _then;

/// Create a copy of MeterModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = freezed,Object? readDate = freezed,Object? previous = freezed,Object? current = freezed,Object? usage = freezed,Object? flat = freezed,Object? created = null,Object? updated = null,Object? deleted = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,readDate: freezed == readDate ? _self.readDate : readDate // ignore: cast_nullable_to_non_nullable
as DateTime?,previous: freezed == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as double?,current: freezed == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as double?,usage: freezed == usage ? _self.usage : usage // ignore: cast_nullable_to_non_nullable
as double?,flat: freezed == flat ? _self.flat : flat // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,deleted: freezed == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [MeterModel].
extension MeterModelPatterns on MeterModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeterModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeterModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeterModel value)  $default,){
final _that = this;
switch (_that) {
case _MeterModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeterModel value)?  $default,){
final _that = this;
switch (_that) {
case _MeterModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(fromJson: parseRelationIdNullable)  String? type, @JsonKey(name: 'read_date', fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? readDate,  double? previous,  double? current,  double? usage, @JsonKey(fromJson: parseRelationIdNullable)  String? flat, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? deleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeterModel() when $default != null:
return $default(_that.id,_that.type,_that.readDate,_that.previous,_that.current,_that.usage,_that.flat,_that.created,_that.updated,_that.deleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(fromJson: parseRelationIdNullable)  String? type, @JsonKey(name: 'read_date', fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? readDate,  double? previous,  double? current,  double? usage, @JsonKey(fromJson: parseRelationIdNullable)  String? flat, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? deleted)  $default,) {final _that = this;
switch (_that) {
case _MeterModel():
return $default(_that.id,_that.type,_that.readDate,_that.previous,_that.current,_that.usage,_that.flat,_that.created,_that.updated,_that.deleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(fromJson: parseRelationIdNullable)  String? type, @JsonKey(name: 'read_date', fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? readDate,  double? previous,  double? current,  double? usage, @JsonKey(fromJson: parseRelationIdNullable)  String? flat, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? deleted)?  $default,) {final _that = this;
switch (_that) {
case _MeterModel() when $default != null:
return $default(_that.id,_that.type,_that.readDate,_that.previous,_that.current,_that.usage,_that.flat,_that.created,_that.updated,_that.deleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MeterModel extends MeterModel {
  const _MeterModel({required this.id, @JsonKey(fromJson: parseRelationIdNullable) this.type, @JsonKey(name: 'read_date', fromJson: parsePbDateNullable, toJson: formatPbDateNullable) this.readDate, this.previous, this.current, this.usage, @JsonKey(fromJson: parseRelationIdNullable) this.flat, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate) required this.created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate) required this.updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) this.deleted}): super._();
  factory _MeterModel.fromJson(Map<String, dynamic> json) => _$MeterModelFromJson(json);

@override final  String id;
/// Utility type relation ID.
@override@JsonKey(fromJson: parseRelationIdNullable) final  String? type;
/// Date the meter was read. PocketBase field: `read_date`.
@override@JsonKey(name: 'read_date', fromJson: parsePbDateNullable, toJson: formatPbDateNullable) final  DateTime? readDate;
@override final  double? previous;
@override final  double? current;
/// Computed consumption (current − previous).
@override final  double? usage;
/// ID of the related [flat] record (optional).
@override@JsonKey(fromJson: parseRelationIdNullable) final  String? flat;
@override@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) final  DateTime created;
@override@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) final  DateTime updated;
@override@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) final  DateTime? deleted;

/// Create a copy of MeterModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeterModelCopyWith<_MeterModel> get copyWith => __$MeterModelCopyWithImpl<_MeterModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeterModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeterModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.readDate, readDate) || other.readDate == readDate)&&(identical(other.previous, previous) || other.previous == previous)&&(identical(other.current, current) || other.current == current)&&(identical(other.usage, usage) || other.usage == usage)&&(identical(other.flat, flat) || other.flat == flat)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,readDate,previous,current,usage,flat,created,updated,deleted);

@override
String toString() {
  return 'MeterModel(id: $id, type: $type, readDate: $readDate, previous: $previous, current: $current, usage: $usage, flat: $flat, created: $created, updated: $updated, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class _$MeterModelCopyWith<$Res> implements $MeterModelCopyWith<$Res> {
  factory _$MeterModelCopyWith(_MeterModel value, $Res Function(_MeterModel) _then) = __$MeterModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(fromJson: parseRelationIdNullable) String? type,@JsonKey(name: 'read_date', fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? readDate, double? previous, double? current, double? usage,@JsonKey(fromJson: parseRelationIdNullable) String? flat,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime created,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime updated,@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? deleted
});




}
/// @nodoc
class __$MeterModelCopyWithImpl<$Res>
    implements _$MeterModelCopyWith<$Res> {
  __$MeterModelCopyWithImpl(this._self, this._then);

  final _MeterModel _self;
  final $Res Function(_MeterModel) _then;

/// Create a copy of MeterModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = freezed,Object? readDate = freezed,Object? previous = freezed,Object? current = freezed,Object? usage = freezed,Object? flat = freezed,Object? created = null,Object? updated = null,Object? deleted = freezed,}) {
  return _then(_MeterModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,readDate: freezed == readDate ? _self.readDate : readDate // ignore: cast_nullable_to_non_nullable
as DateTime?,previous: freezed == previous ? _self.previous : previous // ignore: cast_nullable_to_non_nullable
as double?,current: freezed == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as double?,usage: freezed == usage ? _self.usage : usage // ignore: cast_nullable_to_non_nullable
as double?,flat: freezed == flat ? _self.flat : flat // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,deleted: freezed == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
