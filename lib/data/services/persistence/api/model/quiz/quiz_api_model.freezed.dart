// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SurveyFlowApiModel {

 String? get id; String? get surveyId; String? get userId; String? get status; DateTime? get startTime; DateTime? get endTime; bool? get deleted;
/// Create a copy of SurveyFlowApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurveyFlowApiModelCopyWith<SurveyFlowApiModel> get copyWith => _$SurveyFlowApiModelCopyWithImpl<SurveyFlowApiModel>(this as SurveyFlowApiModel, _$identity);

  /// Serializes this SurveyFlowApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurveyFlowApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.surveyId, surveyId) || other.surveyId == surveyId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.status, status) || other.status == status)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,surveyId,userId,status,startTime,endTime,deleted);

@override
String toString() {
  return 'SurveyFlowApiModel(id: $id, surveyId: $surveyId, userId: $userId, status: $status, startTime: $startTime, endTime: $endTime, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class $SurveyFlowApiModelCopyWith<$Res>  {
  factory $SurveyFlowApiModelCopyWith(SurveyFlowApiModel value, $Res Function(SurveyFlowApiModel) _then) = _$SurveyFlowApiModelCopyWithImpl;
@useResult
$Res call({
 String? id, String? surveyId, String? userId, String? status, DateTime? startTime, DateTime? endTime, bool? deleted
});




}
/// @nodoc
class _$SurveyFlowApiModelCopyWithImpl<$Res>
    implements $SurveyFlowApiModelCopyWith<$Res> {
  _$SurveyFlowApiModelCopyWithImpl(this._self, this._then);

  final SurveyFlowApiModel _self;
  final $Res Function(SurveyFlowApiModel) _then;

/// Create a copy of SurveyFlowApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? surveyId = freezed,Object? userId = freezed,Object? status = freezed,Object? startTime = freezed,Object? endTime = freezed,Object? deleted = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,surveyId: freezed == surveyId ? _self.surveyId : surveyId // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,deleted: freezed == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [SurveyFlowApiModel].
extension SurveyFlowApiModelPatterns on SurveyFlowApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SurveyFlowApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SurveyFlowApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SurveyFlowApiModel value)  $default,){
final _that = this;
switch (_that) {
case _SurveyFlowApiModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SurveyFlowApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _SurveyFlowApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? surveyId,  String? userId,  String? status,  DateTime? startTime,  DateTime? endTime,  bool? deleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SurveyFlowApiModel() when $default != null:
return $default(_that.id,_that.surveyId,_that.userId,_that.status,_that.startTime,_that.endTime,_that.deleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? surveyId,  String? userId,  String? status,  DateTime? startTime,  DateTime? endTime,  bool? deleted)  $default,) {final _that = this;
switch (_that) {
case _SurveyFlowApiModel():
return $default(_that.id,_that.surveyId,_that.userId,_that.status,_that.startTime,_that.endTime,_that.deleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? surveyId,  String? userId,  String? status,  DateTime? startTime,  DateTime? endTime,  bool? deleted)?  $default,) {final _that = this;
switch (_that) {
case _SurveyFlowApiModel() when $default != null:
return $default(_that.id,_that.surveyId,_that.userId,_that.status,_that.startTime,_that.endTime,_that.deleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SurveyFlowApiModel implements SurveyFlowApiModel {
  const _SurveyFlowApiModel({this.id, this.surveyId, this.userId, this.status, this.startTime, this.endTime, this.deleted});
  factory _SurveyFlowApiModel.fromJson(Map<String, dynamic> json) => _$SurveyFlowApiModelFromJson(json);

@override final  String? id;
@override final  String? surveyId;
@override final  String? userId;
@override final  String? status;
@override final  DateTime? startTime;
@override final  DateTime? endTime;
@override final  bool? deleted;

/// Create a copy of SurveyFlowApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurveyFlowApiModelCopyWith<_SurveyFlowApiModel> get copyWith => __$SurveyFlowApiModelCopyWithImpl<_SurveyFlowApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SurveyFlowApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurveyFlowApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.surveyId, surveyId) || other.surveyId == surveyId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.status, status) || other.status == status)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,surveyId,userId,status,startTime,endTime,deleted);

@override
String toString() {
  return 'SurveyFlowApiModel(id: $id, surveyId: $surveyId, userId: $userId, status: $status, startTime: $startTime, endTime: $endTime, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class _$SurveyFlowApiModelCopyWith<$Res> implements $SurveyFlowApiModelCopyWith<$Res> {
  factory _$SurveyFlowApiModelCopyWith(_SurveyFlowApiModel value, $Res Function(_SurveyFlowApiModel) _then) = __$SurveyFlowApiModelCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? surveyId, String? userId, String? status, DateTime? startTime, DateTime? endTime, bool? deleted
});




}
/// @nodoc
class __$SurveyFlowApiModelCopyWithImpl<$Res>
    implements _$SurveyFlowApiModelCopyWith<$Res> {
  __$SurveyFlowApiModelCopyWithImpl(this._self, this._then);

  final _SurveyFlowApiModel _self;
  final $Res Function(_SurveyFlowApiModel) _then;

/// Create a copy of SurveyFlowApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? surveyId = freezed,Object? userId = freezed,Object? status = freezed,Object? startTime = freezed,Object? endTime = freezed,Object? deleted = freezed,}) {
  return _then(_SurveyFlowApiModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,surveyId: freezed == surveyId ? _self.surveyId : surveyId // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,deleted: freezed == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$AssessmentResultApiModel {

 String? get type; List<String> get scores; DateTime? get timestamp;
/// Create a copy of AssessmentResultApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssessmentResultApiModelCopyWith<AssessmentResultApiModel> get copyWith => _$AssessmentResultApiModelCopyWithImpl<AssessmentResultApiModel>(this as AssessmentResultApiModel, _$identity);

  /// Serializes this AssessmentResultApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssessmentResultApiModel&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.scores, scores)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,const DeepCollectionEquality().hash(scores),timestamp);

@override
String toString() {
  return 'AssessmentResultApiModel(type: $type, scores: $scores, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $AssessmentResultApiModelCopyWith<$Res>  {
  factory $AssessmentResultApiModelCopyWith(AssessmentResultApiModel value, $Res Function(AssessmentResultApiModel) _then) = _$AssessmentResultApiModelCopyWithImpl;
@useResult
$Res call({
 String? type, List<String> scores, DateTime? timestamp
});




}
/// @nodoc
class _$AssessmentResultApiModelCopyWithImpl<$Res>
    implements $AssessmentResultApiModelCopyWith<$Res> {
  _$AssessmentResultApiModelCopyWithImpl(this._self, this._then);

  final AssessmentResultApiModel _self;
  final $Res Function(AssessmentResultApiModel) _then;

/// Create a copy of AssessmentResultApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = freezed,Object? scores = null,Object? timestamp = freezed,}) {
  return _then(_self.copyWith(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,scores: null == scores ? _self.scores : scores // ignore: cast_nullable_to_non_nullable
as List<String>,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AssessmentResultApiModel].
extension AssessmentResultApiModelPatterns on AssessmentResultApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssessmentResultApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssessmentResultApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssessmentResultApiModel value)  $default,){
final _that = this;
switch (_that) {
case _AssessmentResultApiModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssessmentResultApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _AssessmentResultApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? type,  List<String> scores,  DateTime? timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssessmentResultApiModel() when $default != null:
return $default(_that.type,_that.scores,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? type,  List<String> scores,  DateTime? timestamp)  $default,) {final _that = this;
switch (_that) {
case _AssessmentResultApiModel():
return $default(_that.type,_that.scores,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? type,  List<String> scores,  DateTime? timestamp)?  $default,) {final _that = this;
switch (_that) {
case _AssessmentResultApiModel() when $default != null:
return $default(_that.type,_that.scores,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssessmentResultApiModel implements AssessmentResultApiModel {
  const _AssessmentResultApiModel({this.type, final  List<String> scores = const [], this.timestamp}): _scores = scores;
  factory _AssessmentResultApiModel.fromJson(Map<String, dynamic> json) => _$AssessmentResultApiModelFromJson(json);

@override final  String? type;
 final  List<String> _scores;
@override@JsonKey() List<String> get scores {
  if (_scores is EqualUnmodifiableListView) return _scores;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scores);
}

@override final  DateTime? timestamp;

/// Create a copy of AssessmentResultApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssessmentResultApiModelCopyWith<_AssessmentResultApiModel> get copyWith => __$AssessmentResultApiModelCopyWithImpl<_AssessmentResultApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssessmentResultApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssessmentResultApiModel&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._scores, _scores)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,const DeepCollectionEquality().hash(_scores),timestamp);

@override
String toString() {
  return 'AssessmentResultApiModel(type: $type, scores: $scores, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$AssessmentResultApiModelCopyWith<$Res> implements $AssessmentResultApiModelCopyWith<$Res> {
  factory _$AssessmentResultApiModelCopyWith(_AssessmentResultApiModel value, $Res Function(_AssessmentResultApiModel) _then) = __$AssessmentResultApiModelCopyWithImpl;
@override @useResult
$Res call({
 String? type, List<String> scores, DateTime? timestamp
});




}
/// @nodoc
class __$AssessmentResultApiModelCopyWithImpl<$Res>
    implements _$AssessmentResultApiModelCopyWith<$Res> {
  __$AssessmentResultApiModelCopyWithImpl(this._self, this._then);

  final _AssessmentResultApiModel _self;
  final $Res Function(_AssessmentResultApiModel) _then;

/// Create a copy of AssessmentResultApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = freezed,Object? scores = null,Object? timestamp = freezed,}) {
  return _then(_AssessmentResultApiModel(
type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,scores: null == scores ? _self._scores : scores // ignore: cast_nullable_to_non_nullable
as List<String>,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
