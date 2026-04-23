// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TransactionModel {

 String get id; double? get amount;/// ID of the related [transaction_type] record (or expanded map).
@JsonKey(fromJson: parseRelationId) String get type; String? get description;/// Date on which the transaction was recorded.
@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime get date;/// Optional payment deadline. PocketBase field: `due_date`.
@JsonKey(name: 'due_date', fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? get dueDate;/// Date on which payment was received. PocketBase field: `payment_date`.
@JsonKey(name: 'payment_date', fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? get paymentDate; RecordStatus get status;/// ID of the parent [organization] record.
@JsonKey(fromJson: parseRelationId) String get organization;/// ID of the parent [site] record.
@JsonKey(fromJson: parseRelationId) String get site;/// ID of the related [apartment] record.
@JsonKey(fromJson: parseRelationId) String get apartment;/// ID of the related [flat] record.
@JsonKey(fromJson: parseRelationId) String get flat;@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime get created;@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime get updated;@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? get deleted;
/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionModelCopyWith<TransactionModel> get copyWith => _$TransactionModelCopyWithImpl<TransactionModel>(this as TransactionModel, _$identity);

  /// Serializes this TransactionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&(identical(other.date, date) || other.date == date)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.site, site) || other.site == site)&&(identical(other.apartment, apartment) || other.apartment == apartment)&&(identical(other.flat, flat) || other.flat == flat)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,amount,type,description,date,dueDate,paymentDate,status,organization,site,apartment,flat,created,updated,deleted);

@override
String toString() {
  return 'TransactionModel(id: $id, amount: $amount, type: $type, description: $description, date: $date, dueDate: $dueDate, paymentDate: $paymentDate, status: $status, organization: $organization, site: $site, apartment: $apartment, flat: $flat, created: $created, updated: $updated, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class $TransactionModelCopyWith<$Res>  {
  factory $TransactionModelCopyWith(TransactionModel value, $Res Function(TransactionModel) _then) = _$TransactionModelCopyWithImpl;
@useResult
$Res call({
 String id, double? amount,@JsonKey(fromJson: parseRelationId) String type, String? description,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime date,@JsonKey(name: 'due_date', fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? dueDate,@JsonKey(name: 'payment_date', fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? paymentDate, RecordStatus status,@JsonKey(fromJson: parseRelationId) String organization,@JsonKey(fromJson: parseRelationId) String site,@JsonKey(fromJson: parseRelationId) String apartment,@JsonKey(fromJson: parseRelationId) String flat,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime created,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime updated,@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? deleted
});




}
/// @nodoc
class _$TransactionModelCopyWithImpl<$Res>
    implements $TransactionModelCopyWith<$Res> {
  _$TransactionModelCopyWithImpl(this._self, this._then);

  final TransactionModel _self;
  final $Res Function(TransactionModel) _then;

/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? amount = freezed,Object? type = null,Object? description = freezed,Object? date = null,Object? dueDate = freezed,Object? paymentDate = freezed,Object? status = null,Object? organization = null,Object? site = null,Object? apartment = null,Object? flat = null,Object? created = null,Object? updated = null,Object? deleted = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,paymentDate: freezed == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RecordStatus,organization: null == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as String,site: null == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as String,apartment: null == apartment ? _self.apartment : apartment // ignore: cast_nullable_to_non_nullable
as String,flat: null == flat ? _self.flat : flat // ignore: cast_nullable_to_non_nullable
as String,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,deleted: freezed == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionModel].
extension TransactionModelPatterns on TransactionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionModel value)  $default,){
final _that = this;
switch (_that) {
case _TransactionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionModel value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  double? amount, @JsonKey(fromJson: parseRelationId)  String type,  String? description, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime date, @JsonKey(name: 'due_date', fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? dueDate, @JsonKey(name: 'payment_date', fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? paymentDate,  RecordStatus status, @JsonKey(fromJson: parseRelationId)  String organization, @JsonKey(fromJson: parseRelationId)  String site, @JsonKey(fromJson: parseRelationId)  String apartment, @JsonKey(fromJson: parseRelationId)  String flat, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? deleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionModel() when $default != null:
return $default(_that.id,_that.amount,_that.type,_that.description,_that.date,_that.dueDate,_that.paymentDate,_that.status,_that.organization,_that.site,_that.apartment,_that.flat,_that.created,_that.updated,_that.deleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  double? amount, @JsonKey(fromJson: parseRelationId)  String type,  String? description, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime date, @JsonKey(name: 'due_date', fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? dueDate, @JsonKey(name: 'payment_date', fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? paymentDate,  RecordStatus status, @JsonKey(fromJson: parseRelationId)  String organization, @JsonKey(fromJson: parseRelationId)  String site, @JsonKey(fromJson: parseRelationId)  String apartment, @JsonKey(fromJson: parseRelationId)  String flat, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? deleted)  $default,) {final _that = this;
switch (_that) {
case _TransactionModel():
return $default(_that.id,_that.amount,_that.type,_that.description,_that.date,_that.dueDate,_that.paymentDate,_that.status,_that.organization,_that.site,_that.apartment,_that.flat,_that.created,_that.updated,_that.deleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  double? amount, @JsonKey(fromJson: parseRelationId)  String type,  String? description, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime date, @JsonKey(name: 'due_date', fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? dueDate, @JsonKey(name: 'payment_date', fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? paymentDate,  RecordStatus status, @JsonKey(fromJson: parseRelationId)  String organization, @JsonKey(fromJson: parseRelationId)  String site, @JsonKey(fromJson: parseRelationId)  String apartment, @JsonKey(fromJson: parseRelationId)  String flat, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? deleted)?  $default,) {final _that = this;
switch (_that) {
case _TransactionModel() when $default != null:
return $default(_that.id,_that.amount,_that.type,_that.description,_that.date,_that.dueDate,_that.paymentDate,_that.status,_that.organization,_that.site,_that.apartment,_that.flat,_that.created,_that.updated,_that.deleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransactionModel extends TransactionModel {
  const _TransactionModel({required this.id, this.amount, @JsonKey(fromJson: parseRelationId) required this.type, this.description, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate) required this.date, @JsonKey(name: 'due_date', fromJson: parsePbDateNullable, toJson: formatPbDateNullable) this.dueDate, @JsonKey(name: 'payment_date', fromJson: parsePbDateNullable, toJson: formatPbDateNullable) this.paymentDate, required this.status, @JsonKey(fromJson: parseRelationId) required this.organization, @JsonKey(fromJson: parseRelationId) required this.site, @JsonKey(fromJson: parseRelationId) required this.apartment, @JsonKey(fromJson: parseRelationId) required this.flat, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate) required this.created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate) required this.updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) this.deleted}): super._();
  factory _TransactionModel.fromJson(Map<String, dynamic> json) => _$TransactionModelFromJson(json);

@override final  String id;
@override final  double? amount;
/// ID of the related [transaction_type] record (or expanded map).
@override@JsonKey(fromJson: parseRelationId) final  String type;
@override final  String? description;
/// Date on which the transaction was recorded.
@override@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) final  DateTime date;
/// Optional payment deadline. PocketBase field: `due_date`.
@override@JsonKey(name: 'due_date', fromJson: parsePbDateNullable, toJson: formatPbDateNullable) final  DateTime? dueDate;
/// Date on which payment was received. PocketBase field: `payment_date`.
@override@JsonKey(name: 'payment_date', fromJson: parsePbDateNullable, toJson: formatPbDateNullable) final  DateTime? paymentDate;
@override final  RecordStatus status;
/// ID of the parent [organization] record.
@override@JsonKey(fromJson: parseRelationId) final  String organization;
/// ID of the parent [site] record.
@override@JsonKey(fromJson: parseRelationId) final  String site;
/// ID of the related [apartment] record.
@override@JsonKey(fromJson: parseRelationId) final  String apartment;
/// ID of the related [flat] record.
@override@JsonKey(fromJson: parseRelationId) final  String flat;
@override@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) final  DateTime created;
@override@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) final  DateTime updated;
@override@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) final  DateTime? deleted;

/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionModelCopyWith<_TransactionModel> get copyWith => __$TransactionModelCopyWithImpl<_TransactionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type)&&(identical(other.description, description) || other.description == description)&&(identical(other.date, date) || other.date == date)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.status, status) || other.status == status)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.site, site) || other.site == site)&&(identical(other.apartment, apartment) || other.apartment == apartment)&&(identical(other.flat, flat) || other.flat == flat)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,amount,type,description,date,dueDate,paymentDate,status,organization,site,apartment,flat,created,updated,deleted);

@override
String toString() {
  return 'TransactionModel(id: $id, amount: $amount, type: $type, description: $description, date: $date, dueDate: $dueDate, paymentDate: $paymentDate, status: $status, organization: $organization, site: $site, apartment: $apartment, flat: $flat, created: $created, updated: $updated, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class _$TransactionModelCopyWith<$Res> implements $TransactionModelCopyWith<$Res> {
  factory _$TransactionModelCopyWith(_TransactionModel value, $Res Function(_TransactionModel) _then) = __$TransactionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, double? amount,@JsonKey(fromJson: parseRelationId) String type, String? description,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime date,@JsonKey(name: 'due_date', fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? dueDate,@JsonKey(name: 'payment_date', fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? paymentDate, RecordStatus status,@JsonKey(fromJson: parseRelationId) String organization,@JsonKey(fromJson: parseRelationId) String site,@JsonKey(fromJson: parseRelationId) String apartment,@JsonKey(fromJson: parseRelationId) String flat,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime created,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime updated,@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? deleted
});




}
/// @nodoc
class __$TransactionModelCopyWithImpl<$Res>
    implements _$TransactionModelCopyWith<$Res> {
  __$TransactionModelCopyWithImpl(this._self, this._then);

  final _TransactionModel _self;
  final $Res Function(_TransactionModel) _then;

/// Create a copy of TransactionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? amount = freezed,Object? type = null,Object? description = freezed,Object? date = null,Object? dueDate = freezed,Object? paymentDate = freezed,Object? status = null,Object? organization = null,Object? site = null,Object? apartment = null,Object? flat = null,Object? created = null,Object? updated = null,Object? deleted = freezed,}) {
  return _then(_TransactionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,paymentDate: freezed == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as DateTime?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RecordStatus,organization: null == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as String,site: null == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as String,apartment: null == apartment ? _self.apartment : apartment // ignore: cast_nullable_to_non_nullable
as String,flat: null == flat ? _self.flat : flat // ignore: cast_nullable_to_non_nullable
as String,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,deleted: freezed == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
