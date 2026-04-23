// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apartment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ApartmentModel {

 String get id; String get name; String? get address;/// Total number of flat units in this building.
 int get flats; int get floors;/// Optional block label (e.g. "A Block"). PocketBase field: `block_name`.
@JsonKey(name: 'block_name') String? get blockName;/// ID of the parent [organization] record.
@JsonKey(fromJson: parseRelationId) String get organization;/// ID of the parent [site] record.
@JsonKey(fromJson: parseRelationId) String get site;@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime get created;@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime get updated;@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? get deleted;
/// Create a copy of ApartmentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApartmentModelCopyWith<ApartmentModel> get copyWith => _$ApartmentModelCopyWithImpl<ApartmentModel>(this as ApartmentModel, _$identity);

  /// Serializes this ApartmentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApartmentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.flats, flats) || other.flats == flats)&&(identical(other.floors, floors) || other.floors == floors)&&(identical(other.blockName, blockName) || other.blockName == blockName)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.site, site) || other.site == site)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,address,flats,floors,blockName,organization,site,created,updated,deleted);

@override
String toString() {
  return 'ApartmentModel(id: $id, name: $name, address: $address, flats: $flats, floors: $floors, blockName: $blockName, organization: $organization, site: $site, created: $created, updated: $updated, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class $ApartmentModelCopyWith<$Res>  {
  factory $ApartmentModelCopyWith(ApartmentModel value, $Res Function(ApartmentModel) _then) = _$ApartmentModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? address, int flats, int floors,@JsonKey(name: 'block_name') String? blockName,@JsonKey(fromJson: parseRelationId) String organization,@JsonKey(fromJson: parseRelationId) String site,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime created,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime updated,@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? deleted
});




}
/// @nodoc
class _$ApartmentModelCopyWithImpl<$Res>
    implements $ApartmentModelCopyWith<$Res> {
  _$ApartmentModelCopyWithImpl(this._self, this._then);

  final ApartmentModel _self;
  final $Res Function(ApartmentModel) _then;

/// Create a copy of ApartmentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? address = freezed,Object? flats = null,Object? floors = null,Object? blockName = freezed,Object? organization = null,Object? site = null,Object? created = null,Object? updated = null,Object? deleted = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,flats: null == flats ? _self.flats : flats // ignore: cast_nullable_to_non_nullable
as int,floors: null == floors ? _self.floors : floors // ignore: cast_nullable_to_non_nullable
as int,blockName: freezed == blockName ? _self.blockName : blockName // ignore: cast_nullable_to_non_nullable
as String?,organization: null == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as String,site: null == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as String,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,deleted: freezed == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ApartmentModel].
extension ApartmentModelPatterns on ApartmentModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApartmentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApartmentModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApartmentModel value)  $default,){
final _that = this;
switch (_that) {
case _ApartmentModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApartmentModel value)?  $default,){
final _that = this;
switch (_that) {
case _ApartmentModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? address,  int flats,  int floors, @JsonKey(name: 'block_name')  String? blockName, @JsonKey(fromJson: parseRelationId)  String organization, @JsonKey(fromJson: parseRelationId)  String site, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? deleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApartmentModel() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.flats,_that.floors,_that.blockName,_that.organization,_that.site,_that.created,_that.updated,_that.deleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? address,  int flats,  int floors, @JsonKey(name: 'block_name')  String? blockName, @JsonKey(fromJson: parseRelationId)  String organization, @JsonKey(fromJson: parseRelationId)  String site, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? deleted)  $default,) {final _that = this;
switch (_that) {
case _ApartmentModel():
return $default(_that.id,_that.name,_that.address,_that.flats,_that.floors,_that.blockName,_that.organization,_that.site,_that.created,_that.updated,_that.deleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? address,  int flats,  int floors, @JsonKey(name: 'block_name')  String? blockName, @JsonKey(fromJson: parseRelationId)  String organization, @JsonKey(fromJson: parseRelationId)  String site, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? deleted)?  $default,) {final _that = this;
switch (_that) {
case _ApartmentModel() when $default != null:
return $default(_that.id,_that.name,_that.address,_that.flats,_that.floors,_that.blockName,_that.organization,_that.site,_that.created,_that.updated,_that.deleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApartmentModel extends ApartmentModel {
  const _ApartmentModel({required this.id, required this.name, this.address, required this.flats, required this.floors, @JsonKey(name: 'block_name') this.blockName, @JsonKey(fromJson: parseRelationId) required this.organization, @JsonKey(fromJson: parseRelationId) required this.site, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate) required this.created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate) required this.updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) this.deleted}): super._();
  factory _ApartmentModel.fromJson(Map<String, dynamic> json) => _$ApartmentModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? address;
/// Total number of flat units in this building.
@override final  int flats;
@override final  int floors;
/// Optional block label (e.g. "A Block"). PocketBase field: `block_name`.
@override@JsonKey(name: 'block_name') final  String? blockName;
/// ID of the parent [organization] record.
@override@JsonKey(fromJson: parseRelationId) final  String organization;
/// ID of the parent [site] record.
@override@JsonKey(fromJson: parseRelationId) final  String site;
@override@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) final  DateTime created;
@override@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) final  DateTime updated;
@override@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) final  DateTime? deleted;

/// Create a copy of ApartmentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApartmentModelCopyWith<_ApartmentModel> get copyWith => __$ApartmentModelCopyWithImpl<_ApartmentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApartmentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApartmentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.flats, flats) || other.flats == flats)&&(identical(other.floors, floors) || other.floors == floors)&&(identical(other.blockName, blockName) || other.blockName == blockName)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.site, site) || other.site == site)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,address,flats,floors,blockName,organization,site,created,updated,deleted);

@override
String toString() {
  return 'ApartmentModel(id: $id, name: $name, address: $address, flats: $flats, floors: $floors, blockName: $blockName, organization: $organization, site: $site, created: $created, updated: $updated, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class _$ApartmentModelCopyWith<$Res> implements $ApartmentModelCopyWith<$Res> {
  factory _$ApartmentModelCopyWith(_ApartmentModel value, $Res Function(_ApartmentModel) _then) = __$ApartmentModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? address, int flats, int floors,@JsonKey(name: 'block_name') String? blockName,@JsonKey(fromJson: parseRelationId) String organization,@JsonKey(fromJson: parseRelationId) String site,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime created,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime updated,@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? deleted
});




}
/// @nodoc
class __$ApartmentModelCopyWithImpl<$Res>
    implements _$ApartmentModelCopyWith<$Res> {
  __$ApartmentModelCopyWithImpl(this._self, this._then);

  final _ApartmentModel _self;
  final $Res Function(_ApartmentModel) _then;

/// Create a copy of ApartmentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? address = freezed,Object? flats = null,Object? floors = null,Object? blockName = freezed,Object? organization = null,Object? site = null,Object? created = null,Object? updated = null,Object? deleted = freezed,}) {
  return _then(_ApartmentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,flats: null == flats ? _self.flats : flats // ignore: cast_nullable_to_non_nullable
as int,floors: null == floors ? _self.floors : floors // ignore: cast_nullable_to_non_nullable
as int,blockName: freezed == blockName ? _self.blockName : blockName // ignore: cast_nullable_to_non_nullable
as String?,organization: null == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as String,site: null == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as String,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,deleted: freezed == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
