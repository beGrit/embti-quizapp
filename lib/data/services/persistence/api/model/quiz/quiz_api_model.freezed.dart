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

 String? get id; String? get surveyId; String? get status;@FirestoreTimestampConverter() DateTime? get startTime;@FirestoreTimestampConverter() DateTime? get endTime; List<String> get questionOrder; Map<String, int> get currentAnswers; bool? get deleted;
/// Create a copy of SurveyFlowApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurveyFlowApiModelCopyWith<SurveyFlowApiModel> get copyWith => _$SurveyFlowApiModelCopyWithImpl<SurveyFlowApiModel>(this as SurveyFlowApiModel, _$identity);

  /// Serializes this SurveyFlowApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurveyFlowApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.surveyId, surveyId) || other.surveyId == surveyId)&&(identical(other.status, status) || other.status == status)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&const DeepCollectionEquality().equals(other.questionOrder, questionOrder)&&const DeepCollectionEquality().equals(other.currentAnswers, currentAnswers)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,surveyId,status,startTime,endTime,const DeepCollectionEquality().hash(questionOrder),const DeepCollectionEquality().hash(currentAnswers),deleted);

@override
String toString() {
  return 'SurveyFlowApiModel(id: $id, surveyId: $surveyId, status: $status, startTime: $startTime, endTime: $endTime, questionOrder: $questionOrder, currentAnswers: $currentAnswers, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class $SurveyFlowApiModelCopyWith<$Res>  {
  factory $SurveyFlowApiModelCopyWith(SurveyFlowApiModel value, $Res Function(SurveyFlowApiModel) _then) = _$SurveyFlowApiModelCopyWithImpl;
@useResult
$Res call({
 String? id, String? surveyId, String? status,@FirestoreTimestampConverter() DateTime? startTime,@FirestoreTimestampConverter() DateTime? endTime, List<String> questionOrder, Map<String, int> currentAnswers, bool? deleted
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? surveyId = freezed,Object? status = freezed,Object? startTime = freezed,Object? endTime = freezed,Object? questionOrder = null,Object? currentAnswers = null,Object? deleted = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,surveyId: freezed == surveyId ? _self.surveyId : surveyId // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,questionOrder: null == questionOrder ? _self.questionOrder : questionOrder // ignore: cast_nullable_to_non_nullable
as List<String>,currentAnswers: null == currentAnswers ? _self.currentAnswers : currentAnswers // ignore: cast_nullable_to_non_nullable
as Map<String, int>,deleted: freezed == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? surveyId,  String? status, @FirestoreTimestampConverter()  DateTime? startTime, @FirestoreTimestampConverter()  DateTime? endTime,  List<String> questionOrder,  Map<String, int> currentAnswers,  bool? deleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SurveyFlowApiModel() when $default != null:
return $default(_that.id,_that.surveyId,_that.status,_that.startTime,_that.endTime,_that.questionOrder,_that.currentAnswers,_that.deleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? surveyId,  String? status, @FirestoreTimestampConverter()  DateTime? startTime, @FirestoreTimestampConverter()  DateTime? endTime,  List<String> questionOrder,  Map<String, int> currentAnswers,  bool? deleted)  $default,) {final _that = this;
switch (_that) {
case _SurveyFlowApiModel():
return $default(_that.id,_that.surveyId,_that.status,_that.startTime,_that.endTime,_that.questionOrder,_that.currentAnswers,_that.deleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? surveyId,  String? status, @FirestoreTimestampConverter()  DateTime? startTime, @FirestoreTimestampConverter()  DateTime? endTime,  List<String> questionOrder,  Map<String, int> currentAnswers,  bool? deleted)?  $default,) {final _that = this;
switch (_that) {
case _SurveyFlowApiModel() when $default != null:
return $default(_that.id,_that.surveyId,_that.status,_that.startTime,_that.endTime,_that.questionOrder,_that.currentAnswers,_that.deleted);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SurveyFlowApiModel extends SurveyFlowApiModel {
  const _SurveyFlowApiModel({this.id, this.surveyId, this.status, @FirestoreTimestampConverter() this.startTime, @FirestoreTimestampConverter() this.endTime, final  List<String> questionOrder = const [], final  Map<String, int> currentAnswers = const {}, this.deleted = false}): _questionOrder = questionOrder,_currentAnswers = currentAnswers,super._();
  factory _SurveyFlowApiModel.fromJson(Map<String, dynamic> json) => _$SurveyFlowApiModelFromJson(json);

@override final  String? id;
@override final  String? surveyId;
@override final  String? status;
@override@FirestoreTimestampConverter() final  DateTime? startTime;
@override@FirestoreTimestampConverter() final  DateTime? endTime;
 final  List<String> _questionOrder;
@override@JsonKey() List<String> get questionOrder {
  if (_questionOrder is EqualUnmodifiableListView) return _questionOrder;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questionOrder);
}

 final  Map<String, int> _currentAnswers;
@override@JsonKey() Map<String, int> get currentAnswers {
  if (_currentAnswers is EqualUnmodifiableMapView) return _currentAnswers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_currentAnswers);
}

@override@JsonKey() final  bool? deleted;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurveyFlowApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.surveyId, surveyId) || other.surveyId == surveyId)&&(identical(other.status, status) || other.status == status)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&const DeepCollectionEquality().equals(other._questionOrder, _questionOrder)&&const DeepCollectionEquality().equals(other._currentAnswers, _currentAnswers)&&(identical(other.deleted, deleted) || other.deleted == deleted));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,surveyId,status,startTime,endTime,const DeepCollectionEquality().hash(_questionOrder),const DeepCollectionEquality().hash(_currentAnswers),deleted);

@override
String toString() {
  return 'SurveyFlowApiModel(id: $id, surveyId: $surveyId, status: $status, startTime: $startTime, endTime: $endTime, questionOrder: $questionOrder, currentAnswers: $currentAnswers, deleted: $deleted)';
}


}

/// @nodoc
abstract mixin class _$SurveyFlowApiModelCopyWith<$Res> implements $SurveyFlowApiModelCopyWith<$Res> {
  factory _$SurveyFlowApiModelCopyWith(_SurveyFlowApiModel value, $Res Function(_SurveyFlowApiModel) _then) = __$SurveyFlowApiModelCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? surveyId, String? status,@FirestoreTimestampConverter() DateTime? startTime,@FirestoreTimestampConverter() DateTime? endTime, List<String> questionOrder, Map<String, int> currentAnswers, bool? deleted
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? surveyId = freezed,Object? status = freezed,Object? startTime = freezed,Object? endTime = freezed,Object? questionOrder = null,Object? currentAnswers = null,Object? deleted = freezed,}) {
  return _then(_SurveyFlowApiModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,surveyId: freezed == surveyId ? _self.surveyId : surveyId // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,startTime: freezed == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime?,endTime: freezed == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime?,questionOrder: null == questionOrder ? _self._questionOrder : questionOrder // ignore: cast_nullable_to_non_nullable
as List<String>,currentAnswers: null == currentAnswers ? _self._currentAnswers : currentAnswers // ignore: cast_nullable_to_non_nullable
as Map<String, int>,deleted: freezed == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$AxisScoreApiModel {

 int get axis; double get value;
/// Create a copy of AxisScoreApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AxisScoreApiModelCopyWith<AxisScoreApiModel> get copyWith => _$AxisScoreApiModelCopyWithImpl<AxisScoreApiModel>(this as AxisScoreApiModel, _$identity);

  /// Serializes this AxisScoreApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AxisScoreApiModel&&(identical(other.axis, axis) || other.axis == axis)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,axis,value);

@override
String toString() {
  return 'AxisScoreApiModel(axis: $axis, value: $value)';
}


}

/// @nodoc
abstract mixin class $AxisScoreApiModelCopyWith<$Res>  {
  factory $AxisScoreApiModelCopyWith(AxisScoreApiModel value, $Res Function(AxisScoreApiModel) _then) = _$AxisScoreApiModelCopyWithImpl;
@useResult
$Res call({
 int axis, double value
});




}
/// @nodoc
class _$AxisScoreApiModelCopyWithImpl<$Res>
    implements $AxisScoreApiModelCopyWith<$Res> {
  _$AxisScoreApiModelCopyWithImpl(this._self, this._then);

  final AxisScoreApiModel _self;
  final $Res Function(AxisScoreApiModel) _then;

/// Create a copy of AxisScoreApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? axis = null,Object? value = null,}) {
  return _then(_self.copyWith(
axis: null == axis ? _self.axis : axis // ignore: cast_nullable_to_non_nullable
as int,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [AxisScoreApiModel].
extension AxisScoreApiModelPatterns on AxisScoreApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AxisScoreApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AxisScoreApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AxisScoreApiModel value)  $default,){
final _that = this;
switch (_that) {
case _AxisScoreApiModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AxisScoreApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _AxisScoreApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int axis,  double value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AxisScoreApiModel() when $default != null:
return $default(_that.axis,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int axis,  double value)  $default,) {final _that = this;
switch (_that) {
case _AxisScoreApiModel():
return $default(_that.axis,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int axis,  double value)?  $default,) {final _that = this;
switch (_that) {
case _AxisScoreApiModel() when $default != null:
return $default(_that.axis,_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AxisScoreApiModel implements AxisScoreApiModel {
  const _AxisScoreApiModel({required this.axis, required this.value});
  factory _AxisScoreApiModel.fromJson(Map<String, dynamic> json) => _$AxisScoreApiModelFromJson(json);

@override final  int axis;
@override final  double value;

/// Create a copy of AxisScoreApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AxisScoreApiModelCopyWith<_AxisScoreApiModel> get copyWith => __$AxisScoreApiModelCopyWithImpl<_AxisScoreApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AxisScoreApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AxisScoreApiModel&&(identical(other.axis, axis) || other.axis == axis)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,axis,value);

@override
String toString() {
  return 'AxisScoreApiModel(axis: $axis, value: $value)';
}


}

/// @nodoc
abstract mixin class _$AxisScoreApiModelCopyWith<$Res> implements $AxisScoreApiModelCopyWith<$Res> {
  factory _$AxisScoreApiModelCopyWith(_AxisScoreApiModel value, $Res Function(_AxisScoreApiModel) _then) = __$AxisScoreApiModelCopyWithImpl;
@override @useResult
$Res call({
 int axis, double value
});




}
/// @nodoc
class __$AxisScoreApiModelCopyWithImpl<$Res>
    implements _$AxisScoreApiModelCopyWith<$Res> {
  __$AxisScoreApiModelCopyWithImpl(this._self, this._then);

  final _AxisScoreApiModel _self;
  final $Res Function(_AxisScoreApiModel) _then;

/// Create a copy of AxisScoreApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? axis = null,Object? value = null,}) {
  return _then(_AxisScoreApiModel(
axis: null == axis ? _self.axis : axis // ignore: cast_nullable_to_non_nullable
as int,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$AssessmentResultApiModel {

 String? get surveyFlowId; String? get type; List<AxisScoreApiModel> get scores;@FirestoreTimestampConverter() DateTime? get timestamp;
/// Create a copy of AssessmentResultApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssessmentResultApiModelCopyWith<AssessmentResultApiModel> get copyWith => _$AssessmentResultApiModelCopyWithImpl<AssessmentResultApiModel>(this as AssessmentResultApiModel, _$identity);

  /// Serializes this AssessmentResultApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssessmentResultApiModel&&(identical(other.surveyFlowId, surveyFlowId) || other.surveyFlowId == surveyFlowId)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.scores, scores)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,surveyFlowId,type,const DeepCollectionEquality().hash(scores),timestamp);

@override
String toString() {
  return 'AssessmentResultApiModel(surveyFlowId: $surveyFlowId, type: $type, scores: $scores, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $AssessmentResultApiModelCopyWith<$Res>  {
  factory $AssessmentResultApiModelCopyWith(AssessmentResultApiModel value, $Res Function(AssessmentResultApiModel) _then) = _$AssessmentResultApiModelCopyWithImpl;
@useResult
$Res call({
 String? surveyFlowId, String? type, List<AxisScoreApiModel> scores,@FirestoreTimestampConverter() DateTime? timestamp
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
@pragma('vm:prefer-inline') @override $Res call({Object? surveyFlowId = freezed,Object? type = freezed,Object? scores = null,Object? timestamp = freezed,}) {
  return _then(_self.copyWith(
surveyFlowId: freezed == surveyFlowId ? _self.surveyFlowId : surveyFlowId // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,scores: null == scores ? _self.scores : scores // ignore: cast_nullable_to_non_nullable
as List<AxisScoreApiModel>,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? surveyFlowId,  String? type,  List<AxisScoreApiModel> scores, @FirestoreTimestampConverter()  DateTime? timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssessmentResultApiModel() when $default != null:
return $default(_that.surveyFlowId,_that.type,_that.scores,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? surveyFlowId,  String? type,  List<AxisScoreApiModel> scores, @FirestoreTimestampConverter()  DateTime? timestamp)  $default,) {final _that = this;
switch (_that) {
case _AssessmentResultApiModel():
return $default(_that.surveyFlowId,_that.type,_that.scores,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? surveyFlowId,  String? type,  List<AxisScoreApiModel> scores, @FirestoreTimestampConverter()  DateTime? timestamp)?  $default,) {final _that = this;
switch (_that) {
case _AssessmentResultApiModel() when $default != null:
return $default(_that.surveyFlowId,_that.type,_that.scores,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssessmentResultApiModel extends AssessmentResultApiModel {
  const _AssessmentResultApiModel({this.surveyFlowId, this.type, final  List<AxisScoreApiModel> scores = const [], @FirestoreTimestampConverter() this.timestamp}): _scores = scores,super._();
  factory _AssessmentResultApiModel.fromJson(Map<String, dynamic> json) => _$AssessmentResultApiModelFromJson(json);

@override final  String? surveyFlowId;
@override final  String? type;
 final  List<AxisScoreApiModel> _scores;
@override@JsonKey() List<AxisScoreApiModel> get scores {
  if (_scores is EqualUnmodifiableListView) return _scores;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scores);
}

@override@FirestoreTimestampConverter() final  DateTime? timestamp;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssessmentResultApiModel&&(identical(other.surveyFlowId, surveyFlowId) || other.surveyFlowId == surveyFlowId)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._scores, _scores)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,surveyFlowId,type,const DeepCollectionEquality().hash(_scores),timestamp);

@override
String toString() {
  return 'AssessmentResultApiModel(surveyFlowId: $surveyFlowId, type: $type, scores: $scores, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$AssessmentResultApiModelCopyWith<$Res> implements $AssessmentResultApiModelCopyWith<$Res> {
  factory _$AssessmentResultApiModelCopyWith(_AssessmentResultApiModel value, $Res Function(_AssessmentResultApiModel) _then) = __$AssessmentResultApiModelCopyWithImpl;
@override @useResult
$Res call({
 String? surveyFlowId, String? type, List<AxisScoreApiModel> scores,@FirestoreTimestampConverter() DateTime? timestamp
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
@override @pragma('vm:prefer-inline') $Res call({Object? surveyFlowId = freezed,Object? type = freezed,Object? scores = null,Object? timestamp = freezed,}) {
  return _then(_AssessmentResultApiModel(
surveyFlowId: freezed == surveyFlowId ? _self.surveyFlowId : surveyFlowId // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,scores: null == scores ? _self._scores : scores // ignore: cast_nullable_to_non_nullable
as List<AxisScoreApiModel>,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
