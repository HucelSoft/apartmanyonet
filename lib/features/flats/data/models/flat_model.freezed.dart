// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'flat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FlatModel {

 String get id;/// Flat / unit number within the building (integer).
/// Field name in PocketBase is also `flat`.
 int get flat;/// ID of the parent [apartment] record.
@JsonKey(fromJson: parseRelationId) String get apartment;/// ID of the parent [organization] record.
@JsonKey(fromJson: parseRelationId) String get organization;/// ID of the parent [site] record.
@JsonKey(fromJson: parseRelationId) String get site; FlatStatus get status;/// Name of the current resident (optional).
/// Usually derived from the active contract.
 String? get residentName;/// ID of the [users] record Color for the flat owner (optional).
@JsonKey(fromJson: parseRelationIdNullable) String? get owner;/// ID of the currently active [contract] record (optional).
@JsonKey(fromJson: parseRelationIdNullable) String? get contract;@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime get created;@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime get updated;@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? get deleted;
/// Create a copy of FlatModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FlatModelCopyWith<FlatModel> get copyWith => _$FlatModelCopyWithImpl<FlatModel>(this as FlatModel, _$identity);

  /// Serializes this FlatModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FlatModel&&(identical(other.id, id) || other.id == id)&&(identical(other.flat, flat) || other.flat == flat)&&(identical(other.apartment, apartment) || other.apartment == apartment)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.site, site) || other.site == site)&&(identical(other.status, status) || other.status == status)&&(identical(other.residentName, residentName) || other.residentName == residentName)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.contract, contract) || other.contract == contract)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,flat,apartment,organization,site,status,residentName,owner,contract,created,updated,deleted);

@override
String toString() {
  return 'FlatModel(id: $id, flat: $flat, apartment: $apartment, organization: $organization, site: $site, status: $status, residentName: $residentName, owner: $owner, contract: $contract, created: $created, updated: $updated, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class $FlatModelCopyWith<$Res>  {
  factory $FlatModelCopyWith(FlatModel value, $Res Function(FlatModel) _then) = _$FlatModelCopyWithImpl;
@useResult
$Res call({
 String id, int flat,@JsonKey(fromJson: parseRelationId) String apartment,@JsonKey(fromJson: parseRelationId) String organization,@JsonKey(fromJson: parseRelationId) String site, FlatStatus status, String? residentName,@JsonKey(fromJson: parseRelationIdNullable) String? owner,@JsonKey(fromJson: parseRelationIdNullable) String? contract,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime created,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime updated,@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? deleted
});




}
/// @nodoc
class _$FlatModelCopyWithImpl<$Res>
    implements $FlatModelCopyWith<$Res> {
  _$FlatModelCopyWithImpl(this._self, this._then);

  final FlatModel _self;
  final $Res Function(FlatModel) _then;

/// Create a copy of FlatModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? flat = null,Object? apartment = null,Object? organization = null,Object? site = null,Object? status = null,Object? residentName = freezed,Object? owner = freezed,Object? contract = freezed,Object? created = null,Object? updated = null,Object? deleted = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,flat: null == flat ? _self.flat : flat // ignore: cast_nullable_to_non_nullable
as int,apartment: null == apartment ? _self.apartment : apartment // ignore: cast_nullable_to_non_nullable
as String,organization: null == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as String,site: null == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FlatStatus,residentName: freezed == residentName ? _self.residentName : residentName // ignore: cast_nullable_to_non_nullable
as String?,owner: freezed == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String?,contract: freezed == contract ? _self.contract : contract // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,deleted: freezed == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [FlatModel].
extension FlatModelPatterns on FlatModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FlatModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FlatModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FlatModel value)  $default,){
final _that = this;
switch (_that) {
case _FlatModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FlatModel value)?  $default,){
final _that = this;
switch (_that) {
case _FlatModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int flat, @JsonKey(fromJson: parseRelationId)  String apartment, @JsonKey(fromJson: parseRelationId)  String organization, @JsonKey(fromJson: parseRelationId)  String site,  FlatStatus status,  String? residentName, @JsonKey(fromJson: parseRelationIdNullable)  String? owner, @JsonKey(fromJson: parseRelationIdNullable)  String? contract, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? deleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FlatModel() when $default != null:
return $default(_that.id,_that.flat,_that.apartment,_that.organization,_that.site,_that.status,_that.residentName,_that.owner,_that.contract,_that.created,_that.updated,_that.deleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int flat, @JsonKey(fromJson: parseRelationId)  String apartment, @JsonKey(fromJson: parseRelationId)  String organization, @JsonKey(fromJson: parseRelationId)  String site,  FlatStatus status,  String? residentName, @JsonKey(fromJson: parseRelationIdNullable)  String? owner, @JsonKey(fromJson: parseRelationIdNullable)  String? contract, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? deleted)  $default,) {final _that = this;
switch (_that) {
case _FlatModel():
return $default(_that.id,_that.flat,_that.apartment,_that.organization,_that.site,_that.status,_that.residentName,_that.owner,_that.contract,_that.created,_that.updated,_that.deleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int flat, @JsonKey(fromJson: parseRelationId)  String apartment, @JsonKey(fromJson: parseRelationId)  String organization, @JsonKey(fromJson: parseRelationId)  String site,  FlatStatus status,  String? residentName, @JsonKey(fromJson: parseRelationIdNullable)  String? owner, @JsonKey(fromJson: parseRelationIdNullable)  String? contract, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? deleted)?  $default,) {final _that = this;
switch (_that) {
case _FlatModel() when $default != null:
return $default(_that.id,_that.flat,_that.apartment,_that.organization,_that.site,_that.status,_that.residentName,_that.owner,_that.contract,_that.created,_that.updated,_that.deleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FlatModel extends FlatModel {
  const _FlatModel({required this.id, required this.flat, @JsonKey(fromJson: parseRelationId) required this.apartment, @JsonKey(fromJson: parseRelationId) required this.organization, @JsonKey(fromJson: parseRelationId) required this.site, required this.status, this.residentName, @JsonKey(fromJson: parseRelationIdNullable) this.owner, @JsonKey(fromJson: parseRelationIdNullable) this.contract, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate) required this.created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate) required this.updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) this.deleted}): super._();
  factory _FlatModel.fromJson(Map<String, dynamic> json) => _$FlatModelFromJson(json);

@override final  String id;
/// Flat / unit number within the building (integer).
/// Field name in PocketBase is also `flat`.
@override final  int flat;
/// ID of the parent [apartment] record.
@override@JsonKey(fromJson: parseRelationId) final  String apartment;
/// ID of the parent [organization] record.
@override@JsonKey(fromJson: parseRelationId) final  String organization;
/// ID of the parent [site] record.
@override@JsonKey(fromJson: parseRelationId) final  String site;
@override final  FlatStatus status;
/// Name of the current resident (optional).
/// Usually derived from the active contract.
@override final  String? residentName;
/// ID of the [users] record Color for the flat owner (optional).
@override@JsonKey(fromJson: parseRelationIdNullable) final  String? owner;
/// ID of the currently active [contract] record (optional).
@override@JsonKey(fromJson: parseRelationIdNullable) final  String? contract;
@override@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) final  DateTime created;
@override@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) final  DateTime updated;
@override@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) final  DateTime? deleted;

/// Create a copy of FlatModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FlatModelCopyWith<_FlatModel> get copyWith => __$FlatModelCopyWithImpl<_FlatModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FlatModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FlatModel&&(identical(other.id, id) || other.id == id)&&(identical(other.flat, flat) || other.flat == flat)&&(identical(other.apartment, apartment) || other.apartment == apartment)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.site, site) || other.site == site)&&(identical(other.status, status) || other.status == status)&&(identical(other.residentName, residentName) || other.residentName == residentName)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.contract, contract) || other.contract == contract)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,flat,apartment,organization,site,status,residentName,owner,contract,created,updated,deleted);

@override
String toString() {
  return 'FlatModel(id: $id, flat: $flat, apartment: $apartment, organization: $organization, site: $site, status: $status, residentName: $residentName, owner: $owner, contract: $contract, created: $created, updated: $updated, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class _$FlatModelCopyWith<$Res> implements $FlatModelCopyWith<$Res> {
  factory _$FlatModelCopyWith(_FlatModel value, $Res Function(_FlatModel) _then) = __$FlatModelCopyWithImpl;
@override @useResult
$Res call({
 String id, int flat,@JsonKey(fromJson: parseRelationId) String apartment,@JsonKey(fromJson: parseRelationId) String organization,@JsonKey(fromJson: parseRelationId) String site, FlatStatus status, String? residentName,@JsonKey(fromJson: parseRelationIdNullable) String? owner,@JsonKey(fromJson: parseRelationIdNullable) String? contract,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime created,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime updated,@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? deleted
});




}
/// @nodoc
class __$FlatModelCopyWithImpl<$Res>
    implements _$FlatModelCopyWith<$Res> {
  __$FlatModelCopyWithImpl(this._self, this._then);

  final _FlatModel _self;
  final $Res Function(_FlatModel) _then;

/// Create a copy of FlatModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? flat = null,Object? apartment = null,Object? organization = null,Object? site = null,Object? status = null,Object? residentName = freezed,Object? owner = freezed,Object? contract = freezed,Object? created = null,Object? updated = null,Object? deleted = freezed,}) {
  return _then(_FlatModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,flat: null == flat ? _self.flat : flat // ignore: cast_nullable_to_non_nullable
as int,apartment: null == apartment ? _self.apartment : apartment // ignore: cast_nullable_to_non_nullable
as String,organization: null == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as String,site: null == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FlatStatus,residentName: freezed == residentName ? _self.residentName : residentName // ignore: cast_nullable_to_non_nullable
as String?,owner: freezed == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String?,contract: freezed == contract ? _self.contract : contract // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,deleted: freezed == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
