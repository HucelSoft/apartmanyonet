// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contract_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ContractModel {

 String get id;/// ID of the related [flat] record.
@JsonKey(fromJson: parseRelationId) String get flat;/// ID of the related [apartment] record.
@JsonKey(fromJson: parseRelationId) String get apartment;/// ID of the related [site] record.
@JsonKey(fromJson: parseRelationId) String get site;/// ID of the related [organization] record.
@JsonKey(fromJson: parseRelationId) String get organization;/// ID of the resident [users] record.
@JsonKey(fromJson: parseRelationId) String get resident;/// ID of the related [owner] record.
@JsonKey(fromJson: parseRelationId) String get owner;/// Lease start date.
@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime get start;/// Lease end date.
@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime get end;/// Monthly rent amount.
 double get amount;/// Day of the month on which payment is due (0–28).
/// PocketBase field: `payment_due_day`.
@JsonKey(name: 'payment_due_day') int get paymentDueDay; ContractStatus get status;@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime get created;@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime get updated;@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? get deleted; Map<String, dynamic> get expand;
/// Create a copy of ContractModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContractModelCopyWith<ContractModel> get copyWith => _$ContractModelCopyWithImpl<ContractModel>(this as ContractModel, _$identity);

  /// Serializes this ContractModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ContractModel&&(identical(other.id, id) || other.id == id)&&(identical(other.flat, flat) || other.flat == flat)&&(identical(other.apartment, apartment) || other.apartment == apartment)&&(identical(other.site, site) || other.site == site)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.resident, resident) || other.resident == resident)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paymentDueDay, paymentDueDay) || other.paymentDueDay == paymentDueDay)&&(identical(other.status, status) || other.status == status)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&const DeepCollectionEquality().equals(other.expand, expand));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,flat,apartment,site,organization,resident,owner,start,end,amount,paymentDueDay,status,created,updated,deleted,const DeepCollectionEquality().hash(expand));

@override
String toString() {
  return 'ContractModel(id: $id, flat: $flat, apartment: $apartment, site: $site, organization: $organization, resident: $resident, owner: $owner, start: $start, end: $end, amount: $amount, paymentDueDay: $paymentDueDay, status: $status, created: $created, updated: $updated, deleted: $deleted, expand: $expand)';
}


}

/// @nodoc
abstract mixin class $ContractModelCopyWith<$Res>  {
  factory $ContractModelCopyWith(ContractModel value, $Res Function(ContractModel) _then) = _$ContractModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(fromJson: parseRelationId) String flat,@JsonKey(fromJson: parseRelationId) String apartment,@JsonKey(fromJson: parseRelationId) String site,@JsonKey(fromJson: parseRelationId) String organization,@JsonKey(fromJson: parseRelationId) String resident,@JsonKey(fromJson: parseRelationId) String owner,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime start,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime end, double amount,@JsonKey(name: 'payment_due_day') int paymentDueDay, ContractStatus status,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime created,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime updated,@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? deleted, Map<String, dynamic> expand
});




}
/// @nodoc
class _$ContractModelCopyWithImpl<$Res>
    implements $ContractModelCopyWith<$Res> {
  _$ContractModelCopyWithImpl(this._self, this._then);

  final ContractModel _self;
  final $Res Function(ContractModel) _then;

/// Create a copy of ContractModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? flat = null,Object? apartment = null,Object? site = null,Object? organization = null,Object? resident = null,Object? owner = null,Object? start = null,Object? end = null,Object? amount = null,Object? paymentDueDay = null,Object? status = null,Object? created = null,Object? updated = null,Object? deleted = freezed,Object? expand = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,flat: null == flat ? _self.flat : flat // ignore: cast_nullable_to_non_nullable
as String,apartment: null == apartment ? _self.apartment : apartment // ignore: cast_nullable_to_non_nullable
as String,site: null == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as String,organization: null == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as String,resident: null == resident ? _self.resident : resident // ignore: cast_nullable_to_non_nullable
as String,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,paymentDueDay: null == paymentDueDay ? _self.paymentDueDay : paymentDueDay // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ContractStatus,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,deleted: freezed == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as DateTime?,expand: null == expand ? _self.expand : expand // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [ContractModel].
extension ContractModelPatterns on ContractModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ContractModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ContractModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ContractModel value)  $default,){
final _that = this;
switch (_that) {
case _ContractModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ContractModel value)?  $default,){
final _that = this;
switch (_that) {
case _ContractModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(fromJson: parseRelationId)  String flat, @JsonKey(fromJson: parseRelationId)  String apartment, @JsonKey(fromJson: parseRelationId)  String site, @JsonKey(fromJson: parseRelationId)  String organization, @JsonKey(fromJson: parseRelationId)  String resident, @JsonKey(fromJson: parseRelationId)  String owner, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime start, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime end,  double amount, @JsonKey(name: 'payment_due_day')  int paymentDueDay,  ContractStatus status, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? deleted,  Map<String, dynamic> expand)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ContractModel() when $default != null:
return $default(_that.id,_that.flat,_that.apartment,_that.site,_that.organization,_that.resident,_that.owner,_that.start,_that.end,_that.amount,_that.paymentDueDay,_that.status,_that.created,_that.updated,_that.deleted,_that.expand);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(fromJson: parseRelationId)  String flat, @JsonKey(fromJson: parseRelationId)  String apartment, @JsonKey(fromJson: parseRelationId)  String site, @JsonKey(fromJson: parseRelationId)  String organization, @JsonKey(fromJson: parseRelationId)  String resident, @JsonKey(fromJson: parseRelationId)  String owner, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime start, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime end,  double amount, @JsonKey(name: 'payment_due_day')  int paymentDueDay,  ContractStatus status, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? deleted,  Map<String, dynamic> expand)  $default,) {final _that = this;
switch (_that) {
case _ContractModel():
return $default(_that.id,_that.flat,_that.apartment,_that.site,_that.organization,_that.resident,_that.owner,_that.start,_that.end,_that.amount,_that.paymentDueDay,_that.status,_that.created,_that.updated,_that.deleted,_that.expand);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(fromJson: parseRelationId)  String flat, @JsonKey(fromJson: parseRelationId)  String apartment, @JsonKey(fromJson: parseRelationId)  String site, @JsonKey(fromJson: parseRelationId)  String organization, @JsonKey(fromJson: parseRelationId)  String resident, @JsonKey(fromJson: parseRelationId)  String owner, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime start, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime end,  double amount, @JsonKey(name: 'payment_due_day')  int paymentDueDay,  ContractStatus status, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate)  DateTime updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable)  DateTime? deleted,  Map<String, dynamic> expand)?  $default,) {final _that = this;
switch (_that) {
case _ContractModel() when $default != null:
return $default(_that.id,_that.flat,_that.apartment,_that.site,_that.organization,_that.resident,_that.owner,_that.start,_that.end,_that.amount,_that.paymentDueDay,_that.status,_that.created,_that.updated,_that.deleted,_that.expand);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ContractModel extends ContractModel {
  const _ContractModel({required this.id, @JsonKey(fromJson: parseRelationId) required this.flat, @JsonKey(fromJson: parseRelationId) required this.apartment, @JsonKey(fromJson: parseRelationId) required this.site, @JsonKey(fromJson: parseRelationId) required this.organization, @JsonKey(fromJson: parseRelationId) required this.resident, @JsonKey(fromJson: parseRelationId) required this.owner, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate) required this.start, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate) required this.end, required this.amount, @JsonKey(name: 'payment_due_day') required this.paymentDueDay, required this.status, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate) required this.created, @JsonKey(fromJson: parsePbDate, toJson: formatPbDate) required this.updated, @JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) this.deleted, final  Map<String, dynamic> expand = const {}}): _expand = expand,super._();
  factory _ContractModel.fromJson(Map<String, dynamic> json) => _$ContractModelFromJson(json);

@override final  String id;
/// ID of the related [flat] record.
@override@JsonKey(fromJson: parseRelationId) final  String flat;
/// ID of the related [apartment] record.
@override@JsonKey(fromJson: parseRelationId) final  String apartment;
/// ID of the related [site] record.
@override@JsonKey(fromJson: parseRelationId) final  String site;
/// ID of the related [organization] record.
@override@JsonKey(fromJson: parseRelationId) final  String organization;
/// ID of the resident [users] record.
@override@JsonKey(fromJson: parseRelationId) final  String resident;
/// ID of the related [owner] record.
@override@JsonKey(fromJson: parseRelationId) final  String owner;
/// Lease start date.
@override@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) final  DateTime start;
/// Lease end date.
@override@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) final  DateTime end;
/// Monthly rent amount.
@override final  double amount;
/// Day of the month on which payment is due (0–28).
/// PocketBase field: `payment_due_day`.
@override@JsonKey(name: 'payment_due_day') final  int paymentDueDay;
@override final  ContractStatus status;
@override@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) final  DateTime created;
@override@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) final  DateTime updated;
@override@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) final  DateTime? deleted;
 final  Map<String, dynamic> _expand;
@override@JsonKey() Map<String, dynamic> get expand {
  if (_expand is EqualUnmodifiableMapView) return _expand;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_expand);
}


/// Create a copy of ContractModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ContractModelCopyWith<_ContractModel> get copyWith => __$ContractModelCopyWithImpl<_ContractModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ContractModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ContractModel&&(identical(other.id, id) || other.id == id)&&(identical(other.flat, flat) || other.flat == flat)&&(identical(other.apartment, apartment) || other.apartment == apartment)&&(identical(other.site, site) || other.site == site)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.resident, resident) || other.resident == resident)&&(identical(other.owner, owner) || other.owner == owner)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paymentDueDay, paymentDueDay) || other.paymentDueDay == paymentDueDay)&&(identical(other.status, status) || other.status == status)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&const DeepCollectionEquality().equals(other._expand, _expand));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,flat,apartment,site,organization,resident,owner,start,end,amount,paymentDueDay,status,created,updated,deleted,const DeepCollectionEquality().hash(_expand));

@override
String toString() {
  return 'ContractModel(id: $id, flat: $flat, apartment: $apartment, site: $site, organization: $organization, resident: $resident, owner: $owner, start: $start, end: $end, amount: $amount, paymentDueDay: $paymentDueDay, status: $status, created: $created, updated: $updated, deleted: $deleted, expand: $expand)';
}


}

/// @nodoc
abstract mixin class _$ContractModelCopyWith<$Res> implements $ContractModelCopyWith<$Res> {
  factory _$ContractModelCopyWith(_ContractModel value, $Res Function(_ContractModel) _then) = __$ContractModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(fromJson: parseRelationId) String flat,@JsonKey(fromJson: parseRelationId) String apartment,@JsonKey(fromJson: parseRelationId) String site,@JsonKey(fromJson: parseRelationId) String organization,@JsonKey(fromJson: parseRelationId) String resident,@JsonKey(fromJson: parseRelationId) String owner,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime start,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime end, double amount,@JsonKey(name: 'payment_due_day') int paymentDueDay, ContractStatus status,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime created,@JsonKey(fromJson: parsePbDate, toJson: formatPbDate) DateTime updated,@JsonKey(fromJson: parsePbDateNullable, toJson: formatPbDateNullable) DateTime? deleted, Map<String, dynamic> expand
});




}
/// @nodoc
class __$ContractModelCopyWithImpl<$Res>
    implements _$ContractModelCopyWith<$Res> {
  __$ContractModelCopyWithImpl(this._self, this._then);

  final _ContractModel _self;
  final $Res Function(_ContractModel) _then;

/// Create a copy of ContractModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? flat = null,Object? apartment = null,Object? site = null,Object? organization = null,Object? resident = null,Object? owner = null,Object? start = null,Object? end = null,Object? amount = null,Object? paymentDueDay = null,Object? status = null,Object? created = null,Object? updated = null,Object? deleted = freezed,Object? expand = null,}) {
  return _then(_ContractModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,flat: null == flat ? _self.flat : flat // ignore: cast_nullable_to_non_nullable
as String,apartment: null == apartment ? _self.apartment : apartment // ignore: cast_nullable_to_non_nullable
as String,site: null == site ? _self.site : site // ignore: cast_nullable_to_non_nullable
as String,organization: null == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as String,resident: null == resident ? _self.resident : resident // ignore: cast_nullable_to_non_nullable
as String,owner: null == owner ? _self.owner : owner // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as DateTime,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,paymentDueDay: null == paymentDueDay ? _self.paymentDueDay : paymentDueDay // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ContractStatus,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,deleted: freezed == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as DateTime?,expand: null == expand ? _self._expand : expand // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
