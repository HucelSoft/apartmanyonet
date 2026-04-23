// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_type_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransactionTypeModel {

 String get id;/// Human-readable label for this type (e.g. "Monthly Rent", "Building Fee").
/// PocketBase field: `type` (text).
 String get type; String? get description;/// Whether this type represents incoming (credit) or outgoing (debit) money.
 TransactionGenre get genre;/// ID of the parent [organization] record.
@JsonKey(fromJson: parseRelationId) String get organization;@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime get created;@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime get updated;@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? get deleted;
/// Create a copy of TransactionTypeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionTypeModelCopyWith<TransactionTypeModel> get copyWith => _$TransactionTypeModelCopyWithImpl<TransactionTypeModel>(this as TransactionTypeModel, _$identity);

  /// Serializes this TransactionTypeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionTypeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&(identical(other.genre, genre) || other.genre == genre)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,description,genre,organization,created,updated,deleted);

@override
String toString() {
  return 'TransactionTypeModel(id: $id, type: $type, description: $description, genre: $genre, organization: $organization, created: $created, updated: $updated, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class $TransactionTypeModelCopyWith<$Res>  {
  factory $TransactionTypeModelCopyWith(TransactionTypeModel value, $Res Function(TransactionTypeModel) _then) = _$TransactionTypeModelCopyWithImpl;
@useResult
$Res call({
 String id, String type, String? description, TransactionGenre genre,@JsonKey(fromJson: parseRelationId) String organization,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime created,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime updated,@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? deleted
});




}
/// @nodoc
class _$TransactionTypeModelCopyWithImpl<$Res>
    implements $TransactionTypeModelCopyWith<$Res> {
  _$TransactionTypeModelCopyWithImpl(this._self, this._then);

  final TransactionTypeModel _self;
  final $Res Function(TransactionTypeModel) _then;

/// Create a copy of TransactionTypeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? description = freezed,Object? genre = null,Object? organization = null,Object? created = null,Object? updated = null,Object? deleted = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,genre: null == genre ? _self.genre : genre // ignore: cast_nullable_to_non_nullable
as TransactionGenre,organization: null == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as String,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,deleted: freezed == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionTypeModel].
extension TransactionTypeModelPatterns on TransactionTypeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionTypeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionTypeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionTypeModel value)  $default,){
final _that = this;
switch (_that) {
case _TransactionTypeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionTypeModel value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionTypeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  String? description,  TransactionGenre genre, @JsonKey(fromJson: parseRelationId)  String organization, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? deleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionTypeModel() when $default != null:
return $default(_that.id,_that.type,_that.description,_that.genre,_that.organization,_that.created,_that.updated,_that.deleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  String? description,  TransactionGenre genre, @JsonKey(fromJson: parseRelationId)  String organization, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? deleted)  $default,) {final _that = this;
switch (_that) {
case _TransactionTypeModel():
return $default(_that.id,_that.type,_that.description,_that.genre,_that.organization,_that.created,_that.updated,_that.deleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  String? description,  TransactionGenre genre, @JsonKey(fromJson: parseRelationId)  String organization, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? deleted)?  $default,) {final _that = this;
switch (_that) {
case _TransactionTypeModel() when $default != null:
return $default(_that.id,_that.type,_that.description,_that.genre,_that.organization,_that.created,_that.updated,_that.deleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransactionTypeModel extends TransactionTypeModel {
  const _TransactionTypeModel({required this.id, required this.type, this.description, required this.genre, @JsonKey(fromJson: parseRelationId) required this.organization, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate) required this.created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate) required this.updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) this.deleted}): super._();
  factory _TransactionTypeModel.fromJson(Map<String, dynamic> json) => _$TransactionTypeModelFromJson(json);

@override final  String id;
/// Human-readable label for this type (e.g. "Monthly Rent", "Building Fee").
/// PocketBase field: `type` (text).
@override final  String type;
@override final  String? description;
/// Whether this type represents incoming (credit) or outgoing (debit) money.
@override final  TransactionGenre genre;
/// ID of the parent [organization] record.
@override@JsonKey(fromJson: parseRelationId) final  String organization;
@override@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) final  DateTime created;
@override@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) final  DateTime updated;
@override@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) final  DateTime? deleted;

/// Create a copy of TransactionTypeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionTypeModelCopyWith<_TransactionTypeModel> get copyWith => __$TransactionTypeModelCopyWithImpl<_TransactionTypeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionTypeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionTypeModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&(identical(other.genre, genre) || other.genre == genre)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,description,genre,organization,created,updated,deleted);

@override
String toString() {
  return 'TransactionTypeModel(id: $id, type: $type, description: $description, genre: $genre, organization: $organization, created: $created, updated: $updated, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class _$TransactionTypeModelCopyWith<$Res> implements $TransactionTypeModelCopyWith<$Res> {
  factory _$TransactionTypeModelCopyWith(_TransactionTypeModel value, $Res Function(_TransactionTypeModel) _then) = __$TransactionTypeModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, String? description, TransactionGenre genre,@JsonKey(fromJson: parseRelationId) String organization,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime created,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime updated,@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? deleted
});




}
/// @nodoc
class __$TransactionTypeModelCopyWithImpl<$Res>
    implements _$TransactionTypeModelCopyWith<$Res> {
  __$TransactionTypeModelCopyWithImpl(this._self, this._then);

  final _TransactionTypeModel _self;
  final $Res Function(_TransactionTypeModel) _then;

/// Create a copy of TransactionTypeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? description = freezed,Object? genre = null,Object? organization = null,Object? created = null,Object? updated = null,Object? deleted = freezed,}) {
  return _then(_TransactionTypeModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,genre: null == genre ? _self.genre : genre // ignore: cast_nullable_to_non_nullable
as TransactionGenre,organization: null == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as String,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,deleted: freezed == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
