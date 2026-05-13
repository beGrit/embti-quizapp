// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'personality_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Question {

 String get id; String get text; PersonalityAxis get axis; bool get isReversed; double get weight;
/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionCopyWith<Question> get copyWith => _$QuestionCopyWithImpl<Question>(this as Question, _$identity);

  /// Serializes this Question to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Question&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.axis, axis) || other.axis == axis)&&(identical(other.isReversed, isReversed) || other.isReversed == isReversed)&&(identical(other.weight, weight) || other.weight == weight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,axis,isReversed,weight);

@override
String toString() {
  return 'Question(id: $id, text: $text, axis: $axis, isReversed: $isReversed, weight: $weight)';
}


}

/// @nodoc
abstract mixin class $QuestionCopyWith<$Res>  {
  factory $QuestionCopyWith(Question value, $Res Function(Question) _then) = _$QuestionCopyWithImpl;
@useResult
$Res call({
 String id, String text, PersonalityAxis axis, bool isReversed, double weight
});




}
/// @nodoc
class _$QuestionCopyWithImpl<$Res>
    implements $QuestionCopyWith<$Res> {
  _$QuestionCopyWithImpl(this._self, this._then);

  final Question _self;
  final $Res Function(Question) _then;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? axis = null,Object? isReversed = null,Object? weight = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,axis: null == axis ? _self.axis : axis // ignore: cast_nullable_to_non_nullable
as PersonalityAxis,isReversed: null == isReversed ? _self.isReversed : isReversed // ignore: cast_nullable_to_non_nullable
as bool,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [Question].
extension QuestionPatterns on Question {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Question value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Question() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Question value)  $default,){
final _that = this;
switch (_that) {
case _Question():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Question value)?  $default,){
final _that = this;
switch (_that) {
case _Question() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String text,  PersonalityAxis axis,  bool isReversed,  double weight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Question() when $default != null:
return $default(_that.id,_that.text,_that.axis,_that.isReversed,_that.weight);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String text,  PersonalityAxis axis,  bool isReversed,  double weight)  $default,) {final _that = this;
switch (_that) {
case _Question():
return $default(_that.id,_that.text,_that.axis,_that.isReversed,_that.weight);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String text,  PersonalityAxis axis,  bool isReversed,  double weight)?  $default,) {final _that = this;
switch (_that) {
case _Question() when $default != null:
return $default(_that.id,_that.text,_that.axis,_that.isReversed,_that.weight);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Question implements Question {
  const _Question({required this.id, required this.text, required this.axis, this.isReversed = false, this.weight = 1.0});
  factory _Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

@override final  String id;
@override final  String text;
@override final  PersonalityAxis axis;
@override@JsonKey() final  bool isReversed;
@override@JsonKey() final  double weight;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuestionCopyWith<_Question> get copyWith => __$QuestionCopyWithImpl<_Question>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuestionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Question&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.axis, axis) || other.axis == axis)&&(identical(other.isReversed, isReversed) || other.isReversed == isReversed)&&(identical(other.weight, weight) || other.weight == weight));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,axis,isReversed,weight);

@override
String toString() {
  return 'Question(id: $id, text: $text, axis: $axis, isReversed: $isReversed, weight: $weight)';
}


}

/// @nodoc
abstract mixin class _$QuestionCopyWith<$Res> implements $QuestionCopyWith<$Res> {
  factory _$QuestionCopyWith(_Question value, $Res Function(_Question) _then) = __$QuestionCopyWithImpl;
@override @useResult
$Res call({
 String id, String text, PersonalityAxis axis, bool isReversed, double weight
});




}
/// @nodoc
class __$QuestionCopyWithImpl<$Res>
    implements _$QuestionCopyWith<$Res> {
  __$QuestionCopyWithImpl(this._self, this._then);

  final _Question _self;
  final $Res Function(_Question) _then;

/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? axis = null,Object? isReversed = null,Object? weight = null,}) {
  return _then(_Question(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,axis: null == axis ? _self.axis : axis // ignore: cast_nullable_to_non_nullable
as PersonalityAxis,isReversed: null == isReversed ? _self.isReversed : isReversed // ignore: cast_nullable_to_non_nullable
as bool,weight: null == weight ? _self.weight : weight // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$Survey {

 String get id; String get title; List<Question> get questions;
/// Create a copy of Survey
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurveyCopyWith<Survey> get copyWith => _$SurveyCopyWithImpl<Survey>(this as Survey, _$identity);

  /// Serializes this Survey to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Survey&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.questions, questions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(questions));

@override
String toString() {
  return 'Survey(id: $id, title: $title, questions: $questions)';
}


}

/// @nodoc
abstract mixin class $SurveyCopyWith<$Res>  {
  factory $SurveyCopyWith(Survey value, $Res Function(Survey) _then) = _$SurveyCopyWithImpl;
@useResult
$Res call({
 String id, String title, List<Question> questions
});




}
/// @nodoc
class _$SurveyCopyWithImpl<$Res>
    implements $SurveyCopyWith<$Res> {
  _$SurveyCopyWithImpl(this._self, this._then);

  final Survey _self;
  final $Res Function(Survey) _then;

/// Create a copy of Survey
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? questions = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,
  ));
}

}


/// Adds pattern-matching-related methods to [Survey].
extension SurveyPatterns on Survey {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Survey value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Survey() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Survey value)  $default,){
final _that = this;
switch (_that) {
case _Survey():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Survey value)?  $default,){
final _that = this;
switch (_that) {
case _Survey() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  List<Question> questions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Survey() when $default != null:
return $default(_that.id,_that.title,_that.questions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  List<Question> questions)  $default,) {final _that = this;
switch (_that) {
case _Survey():
return $default(_that.id,_that.title,_that.questions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  List<Question> questions)?  $default,) {final _that = this;
switch (_that) {
case _Survey() when $default != null:
return $default(_that.id,_that.title,_that.questions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Survey implements Survey {
  const _Survey({required this.id, required this.title, required final  List<Question> questions}): _questions = questions;
  factory _Survey.fromJson(Map<String, dynamic> json) => _$SurveyFromJson(json);

@override final  String id;
@override final  String title;
 final  List<Question> _questions;
@override List<Question> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}


/// Create a copy of Survey
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurveyCopyWith<_Survey> get copyWith => __$SurveyCopyWithImpl<_Survey>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SurveyToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Survey&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other._questions, _questions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,const DeepCollectionEquality().hash(_questions));

@override
String toString() {
  return 'Survey(id: $id, title: $title, questions: $questions)';
}


}

/// @nodoc
abstract mixin class _$SurveyCopyWith<$Res> implements $SurveyCopyWith<$Res> {
  factory _$SurveyCopyWith(_Survey value, $Res Function(_Survey) _then) = __$SurveyCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, List<Question> questions
});




}
/// @nodoc
class __$SurveyCopyWithImpl<$Res>
    implements _$SurveyCopyWith<$Res> {
  __$SurveyCopyWithImpl(this._self, this._then);

  final _Survey _self;
  final $Res Function(_Survey) _then;

/// Create a copy of Survey
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? questions = null,}) {
  return _then(_Survey(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,
  ));
}


}


/// @nodoc
mixin _$AxisScore {

 PersonalityAxis get axis; double get value;
/// Create a copy of AxisScore
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AxisScoreCopyWith<AxisScore> get copyWith => _$AxisScoreCopyWithImpl<AxisScore>(this as AxisScore, _$identity);

  /// Serializes this AxisScore to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AxisScore&&(identical(other.axis, axis) || other.axis == axis)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,axis,value);

@override
String toString() {
  return 'AxisScore(axis: $axis, value: $value)';
}


}

/// @nodoc
abstract mixin class $AxisScoreCopyWith<$Res>  {
  factory $AxisScoreCopyWith(AxisScore value, $Res Function(AxisScore) _then) = _$AxisScoreCopyWithImpl;
@useResult
$Res call({
 PersonalityAxis axis, double value
});




}
/// @nodoc
class _$AxisScoreCopyWithImpl<$Res>
    implements $AxisScoreCopyWith<$Res> {
  _$AxisScoreCopyWithImpl(this._self, this._then);

  final AxisScore _self;
  final $Res Function(AxisScore) _then;

/// Create a copy of AxisScore
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? axis = null,Object? value = null,}) {
  return _then(_self.copyWith(
axis: null == axis ? _self.axis : axis // ignore: cast_nullable_to_non_nullable
as PersonalityAxis,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [AxisScore].
extension AxisScorePatterns on AxisScore {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AxisScore value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AxisScore() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AxisScore value)  $default,){
final _that = this;
switch (_that) {
case _AxisScore():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AxisScore value)?  $default,){
final _that = this;
switch (_that) {
case _AxisScore() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PersonalityAxis axis,  double value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AxisScore() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PersonalityAxis axis,  double value)  $default,) {final _that = this;
switch (_that) {
case _AxisScore():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PersonalityAxis axis,  double value)?  $default,) {final _that = this;
switch (_that) {
case _AxisScore() when $default != null:
return $default(_that.axis,_that.value);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AxisScore extends AxisScore {
  const _AxisScore({required this.axis, required this.value}): super._();
  factory _AxisScore.fromJson(Map<String, dynamic> json) => _$AxisScoreFromJson(json);

@override final  PersonalityAxis axis;
@override final  double value;

/// Create a copy of AxisScore
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AxisScoreCopyWith<_AxisScore> get copyWith => __$AxisScoreCopyWithImpl<_AxisScore>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AxisScoreToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AxisScore&&(identical(other.axis, axis) || other.axis == axis)&&(identical(other.value, value) || other.value == value));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,axis,value);

@override
String toString() {
  return 'AxisScore(axis: $axis, value: $value)';
}


}

/// @nodoc
abstract mixin class _$AxisScoreCopyWith<$Res> implements $AxisScoreCopyWith<$Res> {
  factory _$AxisScoreCopyWith(_AxisScore value, $Res Function(_AxisScore) _then) = __$AxisScoreCopyWithImpl;
@override @useResult
$Res call({
 PersonalityAxis axis, double value
});




}
/// @nodoc
class __$AxisScoreCopyWithImpl<$Res>
    implements _$AxisScoreCopyWith<$Res> {
  __$AxisScoreCopyWithImpl(this._self, this._then);

  final _AxisScore _self;
  final $Res Function(_AxisScore) _then;

/// Create a copy of AxisScore
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? axis = null,Object? value = null,}) {
  return _then(_AxisScore(
axis: null == axis ? _self.axis : axis // ignore: cast_nullable_to_non_nullable
as PersonalityAxis,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$AssessmentResult {

 List<AxisScore> get scores; DateTime get timestamp;
/// Create a copy of AssessmentResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssessmentResultCopyWith<AssessmentResult> get copyWith => _$AssessmentResultCopyWithImpl<AssessmentResult>(this as AssessmentResult, _$identity);

  /// Serializes this AssessmentResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssessmentResult&&const DeepCollectionEquality().equals(other.scores, scores)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(scores),timestamp);

@override
String toString() {
  return 'AssessmentResult(scores: $scores, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $AssessmentResultCopyWith<$Res>  {
  factory $AssessmentResultCopyWith(AssessmentResult value, $Res Function(AssessmentResult) _then) = _$AssessmentResultCopyWithImpl;
@useResult
$Res call({
 List<AxisScore> scores, DateTime timestamp
});




}
/// @nodoc
class _$AssessmentResultCopyWithImpl<$Res>
    implements $AssessmentResultCopyWith<$Res> {
  _$AssessmentResultCopyWithImpl(this._self, this._then);

  final AssessmentResult _self;
  final $Res Function(AssessmentResult) _then;

/// Create a copy of AssessmentResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? scores = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
scores: null == scores ? _self.scores : scores // ignore: cast_nullable_to_non_nullable
as List<AxisScore>,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AssessmentResult].
extension AssessmentResultPatterns on AssessmentResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssessmentResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssessmentResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssessmentResult value)  $default,){
final _that = this;
switch (_that) {
case _AssessmentResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssessmentResult value)?  $default,){
final _that = this;
switch (_that) {
case _AssessmentResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AxisScore> scores,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssessmentResult() when $default != null:
return $default(_that.scores,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AxisScore> scores,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _AssessmentResult():
return $default(_that.scores,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AxisScore> scores,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _AssessmentResult() when $default != null:
return $default(_that.scores,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssessmentResult extends AssessmentResult {
  const _AssessmentResult({required final  List<AxisScore> scores, required this.timestamp}): _scores = scores,super._();
  factory _AssessmentResult.fromJson(Map<String, dynamic> json) => _$AssessmentResultFromJson(json);

 final  List<AxisScore> _scores;
@override List<AxisScore> get scores {
  if (_scores is EqualUnmodifiableListView) return _scores;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scores);
}

@override final  DateTime timestamp;

/// Create a copy of AssessmentResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssessmentResultCopyWith<_AssessmentResult> get copyWith => __$AssessmentResultCopyWithImpl<_AssessmentResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssessmentResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssessmentResult&&const DeepCollectionEquality().equals(other._scores, _scores)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_scores),timestamp);

@override
String toString() {
  return 'AssessmentResult(scores: $scores, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$AssessmentResultCopyWith<$Res> implements $AssessmentResultCopyWith<$Res> {
  factory _$AssessmentResultCopyWith(_AssessmentResult value, $Res Function(_AssessmentResult) _then) = __$AssessmentResultCopyWithImpl;
@override @useResult
$Res call({
 List<AxisScore> scores, DateTime timestamp
});




}
/// @nodoc
class __$AssessmentResultCopyWithImpl<$Res>
    implements _$AssessmentResultCopyWith<$Res> {
  __$AssessmentResultCopyWithImpl(this._self, this._then);

  final _AssessmentResult _self;
  final $Res Function(_AssessmentResult) _then;

/// Create a copy of AssessmentResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? scores = null,Object? timestamp = null,}) {
  return _then(_AssessmentResult(
scores: null == scores ? _self._scores : scores // ignore: cast_nullable_to_non_nullable
as List<AxisScore>,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$SurveyResponse {

 String get surveyId; Map<String, int> get answers;
/// Create a copy of SurveyResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SurveyResponseCopyWith<SurveyResponse> get copyWith => _$SurveyResponseCopyWithImpl<SurveyResponse>(this as SurveyResponse, _$identity);

  /// Serializes this SurveyResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SurveyResponse&&(identical(other.surveyId, surveyId) || other.surveyId == surveyId)&&const DeepCollectionEquality().equals(other.answers, answers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,surveyId,const DeepCollectionEquality().hash(answers));

@override
String toString() {
  return 'SurveyResponse(surveyId: $surveyId, answers: $answers)';
}


}

/// @nodoc
abstract mixin class $SurveyResponseCopyWith<$Res>  {
  factory $SurveyResponseCopyWith(SurveyResponse value, $Res Function(SurveyResponse) _then) = _$SurveyResponseCopyWithImpl;
@useResult
$Res call({
 String surveyId, Map<String, int> answers
});




}
/// @nodoc
class _$SurveyResponseCopyWithImpl<$Res>
    implements $SurveyResponseCopyWith<$Res> {
  _$SurveyResponseCopyWithImpl(this._self, this._then);

  final SurveyResponse _self;
  final $Res Function(SurveyResponse) _then;

/// Create a copy of SurveyResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? surveyId = null,Object? answers = null,}) {
  return _then(_self.copyWith(
surveyId: null == surveyId ? _self.surveyId : surveyId // ignore: cast_nullable_to_non_nullable
as String,answers: null == answers ? _self.answers : answers // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}

}


/// Adds pattern-matching-related methods to [SurveyResponse].
extension SurveyResponsePatterns on SurveyResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SurveyResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SurveyResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SurveyResponse value)  $default,){
final _that = this;
switch (_that) {
case _SurveyResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SurveyResponse value)?  $default,){
final _that = this;
switch (_that) {
case _SurveyResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String surveyId,  Map<String, int> answers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SurveyResponse() when $default != null:
return $default(_that.surveyId,_that.answers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String surveyId,  Map<String, int> answers)  $default,) {final _that = this;
switch (_that) {
case _SurveyResponse():
return $default(_that.surveyId,_that.answers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String surveyId,  Map<String, int> answers)?  $default,) {final _that = this;
switch (_that) {
case _SurveyResponse() when $default != null:
return $default(_that.surveyId,_that.answers);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SurveyResponse implements SurveyResponse {
  const _SurveyResponse({required this.surveyId, required final  Map<String, int> answers}): _answers = answers;
  factory _SurveyResponse.fromJson(Map<String, dynamic> json) => _$SurveyResponseFromJson(json);

@override final  String surveyId;
 final  Map<String, int> _answers;
@override Map<String, int> get answers {
  if (_answers is EqualUnmodifiableMapView) return _answers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_answers);
}


/// Create a copy of SurveyResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SurveyResponseCopyWith<_SurveyResponse> get copyWith => __$SurveyResponseCopyWithImpl<_SurveyResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SurveyResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SurveyResponse&&(identical(other.surveyId, surveyId) || other.surveyId == surveyId)&&const DeepCollectionEquality().equals(other._answers, _answers));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,surveyId,const DeepCollectionEquality().hash(_answers));

@override
String toString() {
  return 'SurveyResponse(surveyId: $surveyId, answers: $answers)';
}


}

/// @nodoc
abstract mixin class _$SurveyResponseCopyWith<$Res> implements $SurveyResponseCopyWith<$Res> {
  factory _$SurveyResponseCopyWith(_SurveyResponse value, $Res Function(_SurveyResponse) _then) = __$SurveyResponseCopyWithImpl;
@override @useResult
$Res call({
 String surveyId, Map<String, int> answers
});




}
/// @nodoc
class __$SurveyResponseCopyWithImpl<$Res>
    implements _$SurveyResponseCopyWith<$Res> {
  __$SurveyResponseCopyWithImpl(this._self, this._then);

  final _SurveyResponse _self;
  final $Res Function(_SurveyResponse) _then;

/// Create a copy of SurveyResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? surveyId = null,Object? answers = null,}) {
  return _then(_SurveyResponse(
surveyId: null == surveyId ? _self.surveyId : surveyId // ignore: cast_nullable_to_non_nullable
as String,answers: null == answers ? _self._answers : answers // ignore: cast_nullable_to_non_nullable
as Map<String, int>,
  ));
}


}

// dart format on
