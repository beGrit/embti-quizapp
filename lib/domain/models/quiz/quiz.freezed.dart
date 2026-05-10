// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Quiz {

 String get id; String get title; String get description; String? get imageUrl; int get questionCount; List<Question> get questions; Map<String, String> get metadata;
/// Create a copy of Quiz
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizCopyWith<Quiz> get copyWith => _$QuizCopyWithImpl<Quiz>(this as Quiz, _$identity);

  /// Serializes this Quiz to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Quiz&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&const DeepCollectionEquality().equals(other.questions, questions)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,imageUrl,questionCount,const DeepCollectionEquality().hash(questions),const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'Quiz(id: $id, title: $title, description: $description, imageUrl: $imageUrl, questionCount: $questionCount, questions: $questions, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $QuizCopyWith<$Res>  {
  factory $QuizCopyWith(Quiz value, $Res Function(Quiz) _then) = _$QuizCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, String? imageUrl, int questionCount, List<Question> questions, Map<String, String> metadata
});




}
/// @nodoc
class _$QuizCopyWithImpl<$Res>
    implements $QuizCopyWith<$Res> {
  _$QuizCopyWithImpl(this._self, this._then);

  final Quiz _self;
  final $Res Function(Quiz) _then;

/// Create a copy of Quiz
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? imageUrl = freezed,Object? questionCount = null,Object? questions = null,Object? metadata = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,questions: null == questions ? _self.questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Quiz].
extension QuizPatterns on Quiz {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Quiz value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Quiz() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Quiz value)  $default,){
final _that = this;
switch (_that) {
case _Quiz():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Quiz value)?  $default,){
final _that = this;
switch (_that) {
case _Quiz() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String? imageUrl,  int questionCount,  List<Question> questions,  Map<String, String> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Quiz() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.imageUrl,_that.questionCount,_that.questions,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String? imageUrl,  int questionCount,  List<Question> questions,  Map<String, String> metadata)  $default,) {final _that = this;
switch (_that) {
case _Quiz():
return $default(_that.id,_that.title,_that.description,_that.imageUrl,_that.questionCount,_that.questions,_that.metadata);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  String? imageUrl,  int questionCount,  List<Question> questions,  Map<String, String> metadata)?  $default,) {final _that = this;
switch (_that) {
case _Quiz() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.imageUrl,_that.questionCount,_that.questions,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Quiz implements Quiz {
  const _Quiz({required this.id, required this.title, required this.description, this.imageUrl, this.questionCount = 0, final  List<Question> questions = const [], final  Map<String, String> metadata = const {}}): _questions = questions,_metadata = metadata;
  factory _Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);

@override final  String id;
@override final  String title;
@override final  String description;
@override final  String? imageUrl;
@override@JsonKey() final  int questionCount;
 final  List<Question> _questions;
@override@JsonKey() List<Question> get questions {
  if (_questions is EqualUnmodifiableListView) return _questions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_questions);
}

 final  Map<String, String> _metadata;
@override@JsonKey() Map<String, String> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of Quiz
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizCopyWith<_Quiz> get copyWith => __$QuizCopyWithImpl<_Quiz>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuizToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Quiz&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.questionCount, questionCount) || other.questionCount == questionCount)&&const DeepCollectionEquality().equals(other._questions, _questions)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,imageUrl,questionCount,const DeepCollectionEquality().hash(_questions),const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'Quiz(id: $id, title: $title, description: $description, imageUrl: $imageUrl, questionCount: $questionCount, questions: $questions, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$QuizCopyWith<$Res> implements $QuizCopyWith<$Res> {
  factory _$QuizCopyWith(_Quiz value, $Res Function(_Quiz) _then) = __$QuizCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, String? imageUrl, int questionCount, List<Question> questions, Map<String, String> metadata
});




}
/// @nodoc
class __$QuizCopyWithImpl<$Res>
    implements _$QuizCopyWith<$Res> {
  __$QuizCopyWithImpl(this._self, this._then);

  final _Quiz _self;
  final $Res Function(_Quiz) _then;

/// Create a copy of Quiz
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? imageUrl = freezed,Object? questionCount = null,Object? questions = null,Object? metadata = null,}) {
  return _then(_Quiz(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,questionCount: null == questionCount ? _self.questionCount : questionCount // ignore: cast_nullable_to_non_nullable
as int,questions: null == questions ? _self._questions : questions // ignore: cast_nullable_to_non_nullable
as List<Question>,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}


/// @nodoc
mixin _$QuizHistory {

 String get id; String get quizId; String get quizTitle; QuizStatus get status; QuizResult? get result; DateTime? get completedAt;
/// Create a copy of QuizHistory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizHistoryCopyWith<QuizHistory> get copyWith => _$QuizHistoryCopyWithImpl<QuizHistory>(this as QuizHistory, _$identity);

  /// Serializes this QuizHistory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizHistory&&(identical(other.id, id) || other.id == id)&&(identical(other.quizId, quizId) || other.quizId == quizId)&&(identical(other.quizTitle, quizTitle) || other.quizTitle == quizTitle)&&(identical(other.status, status) || other.status == status)&&(identical(other.result, result) || other.result == result)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,quizId,quizTitle,status,result,completedAt);

@override
String toString() {
  return 'QuizHistory(id: $id, quizId: $quizId, quizTitle: $quizTitle, status: $status, result: $result, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class $QuizHistoryCopyWith<$Res>  {
  factory $QuizHistoryCopyWith(QuizHistory value, $Res Function(QuizHistory) _then) = _$QuizHistoryCopyWithImpl;
@useResult
$Res call({
 String id, String quizId, String quizTitle, QuizStatus status, QuizResult? result, DateTime? completedAt
});


$QuizResultCopyWith<$Res>? get result;

}
/// @nodoc
class _$QuizHistoryCopyWithImpl<$Res>
    implements $QuizHistoryCopyWith<$Res> {
  _$QuizHistoryCopyWithImpl(this._self, this._then);

  final QuizHistory _self;
  final $Res Function(QuizHistory) _then;

/// Create a copy of QuizHistory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? quizId = null,Object? quizTitle = null,Object? status = null,Object? result = freezed,Object? completedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,quizId: null == quizId ? _self.quizId : quizId // ignore: cast_nullable_to_non_nullable
as String,quizTitle: null == quizTitle ? _self.quizTitle : quizTitle // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QuizStatus,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as QuizResult?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of QuizHistory
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuizResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $QuizResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// Adds pattern-matching-related methods to [QuizHistory].
extension QuizHistoryPatterns on QuizHistory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizHistory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizHistory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizHistory value)  $default,){
final _that = this;
switch (_that) {
case _QuizHistory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizHistory value)?  $default,){
final _that = this;
switch (_that) {
case _QuizHistory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String quizId,  String quizTitle,  QuizStatus status,  QuizResult? result,  DateTime? completedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizHistory() when $default != null:
return $default(_that.id,_that.quizId,_that.quizTitle,_that.status,_that.result,_that.completedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String quizId,  String quizTitle,  QuizStatus status,  QuizResult? result,  DateTime? completedAt)  $default,) {final _that = this;
switch (_that) {
case _QuizHistory():
return $default(_that.id,_that.quizId,_that.quizTitle,_that.status,_that.result,_that.completedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String quizId,  String quizTitle,  QuizStatus status,  QuizResult? result,  DateTime? completedAt)?  $default,) {final _that = this;
switch (_that) {
case _QuizHistory() when $default != null:
return $default(_that.id,_that.quizId,_that.quizTitle,_that.status,_that.result,_that.completedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuizHistory implements QuizHistory {
  const _QuizHistory({required this.id, required this.quizId, required this.quizTitle, this.status = QuizStatus.inProgress, this.result, this.completedAt});
  factory _QuizHistory.fromJson(Map<String, dynamic> json) => _$QuizHistoryFromJson(json);

@override final  String id;
@override final  String quizId;
@override final  String quizTitle;
@override@JsonKey() final  QuizStatus status;
@override final  QuizResult? result;
@override final  DateTime? completedAt;

/// Create a copy of QuizHistory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizHistoryCopyWith<_QuizHistory> get copyWith => __$QuizHistoryCopyWithImpl<_QuizHistory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuizHistoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizHistory&&(identical(other.id, id) || other.id == id)&&(identical(other.quizId, quizId) || other.quizId == quizId)&&(identical(other.quizTitle, quizTitle) || other.quizTitle == quizTitle)&&(identical(other.status, status) || other.status == status)&&(identical(other.result, result) || other.result == result)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,quizId,quizTitle,status,result,completedAt);

@override
String toString() {
  return 'QuizHistory(id: $id, quizId: $quizId, quizTitle: $quizTitle, status: $status, result: $result, completedAt: $completedAt)';
}


}

/// @nodoc
abstract mixin class _$QuizHistoryCopyWith<$Res> implements $QuizHistoryCopyWith<$Res> {
  factory _$QuizHistoryCopyWith(_QuizHistory value, $Res Function(_QuizHistory) _then) = __$QuizHistoryCopyWithImpl;
@override @useResult
$Res call({
 String id, String quizId, String quizTitle, QuizStatus status, QuizResult? result, DateTime? completedAt
});


@override $QuizResultCopyWith<$Res>? get result;

}
/// @nodoc
class __$QuizHistoryCopyWithImpl<$Res>
    implements _$QuizHistoryCopyWith<$Res> {
  __$QuizHistoryCopyWithImpl(this._self, this._then);

  final _QuizHistory _self;
  final $Res Function(_QuizHistory) _then;

/// Create a copy of QuizHistory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? quizId = null,Object? quizTitle = null,Object? status = null,Object? result = freezed,Object? completedAt = freezed,}) {
  return _then(_QuizHistory(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,quizId: null == quizId ? _self.quizId : quizId // ignore: cast_nullable_to_non_nullable
as String,quizTitle: null == quizTitle ? _self.quizTitle : quizTitle // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as QuizStatus,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as QuizResult?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of QuizHistory
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QuizResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $QuizResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// @nodoc
mixin _$Question {

 String get id; String get text;/// The user's selected response on the 7-degree scale.
/// Null indicates the question hasn't been answered yet.
 LikertScale? get selectedValue; Map<String, String> get metadata; bool get isReversed;
/// Create a copy of Question
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuestionCopyWith<Question> get copyWith => _$QuestionCopyWithImpl<Question>(this as Question, _$identity);

  /// Serializes this Question to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Question&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.selectedValue, selectedValue) || other.selectedValue == selectedValue)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.isReversed, isReversed) || other.isReversed == isReversed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,selectedValue,const DeepCollectionEquality().hash(metadata),isReversed);

@override
String toString() {
  return 'Question(id: $id, text: $text, selectedValue: $selectedValue, metadata: $metadata, isReversed: $isReversed)';
}


}

/// @nodoc
abstract mixin class $QuestionCopyWith<$Res>  {
  factory $QuestionCopyWith(Question value, $Res Function(Question) _then) = _$QuestionCopyWithImpl;
@useResult
$Res call({
 String id, String text, LikertScale? selectedValue, Map<String, String> metadata, bool isReversed
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? text = null,Object? selectedValue = freezed,Object? metadata = null,Object? isReversed = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,selectedValue: freezed == selectedValue ? _self.selectedValue : selectedValue // ignore: cast_nullable_to_non_nullable
as LikertScale?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, String>,isReversed: null == isReversed ? _self.isReversed : isReversed // ignore: cast_nullable_to_non_nullable
as bool,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String text,  LikertScale? selectedValue,  Map<String, String> metadata,  bool isReversed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Question() when $default != null:
return $default(_that.id,_that.text,_that.selectedValue,_that.metadata,_that.isReversed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String text,  LikertScale? selectedValue,  Map<String, String> metadata,  bool isReversed)  $default,) {final _that = this;
switch (_that) {
case _Question():
return $default(_that.id,_that.text,_that.selectedValue,_that.metadata,_that.isReversed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String text,  LikertScale? selectedValue,  Map<String, String> metadata,  bool isReversed)?  $default,) {final _that = this;
switch (_that) {
case _Question() when $default != null:
return $default(_that.id,_that.text,_that.selectedValue,_that.metadata,_that.isReversed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Question implements Question {
  const _Question({required this.id, required this.text, this.selectedValue, final  Map<String, String> metadata = const {}, this.isReversed = false}): _metadata = metadata;
  factory _Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

@override final  String id;
@override final  String text;
/// The user's selected response on the 7-degree scale.
/// Null indicates the question hasn't been answered yet.
@override final  LikertScale? selectedValue;
 final  Map<String, String> _metadata;
@override@JsonKey() Map<String, String> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

@override@JsonKey() final  bool isReversed;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Question&&(identical(other.id, id) || other.id == id)&&(identical(other.text, text) || other.text == text)&&(identical(other.selectedValue, selectedValue) || other.selectedValue == selectedValue)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.isReversed, isReversed) || other.isReversed == isReversed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,text,selectedValue,const DeepCollectionEquality().hash(_metadata),isReversed);

@override
String toString() {
  return 'Question(id: $id, text: $text, selectedValue: $selectedValue, metadata: $metadata, isReversed: $isReversed)';
}


}

/// @nodoc
abstract mixin class _$QuestionCopyWith<$Res> implements $QuestionCopyWith<$Res> {
  factory _$QuestionCopyWith(_Question value, $Res Function(_Question) _then) = __$QuestionCopyWithImpl;
@override @useResult
$Res call({
 String id, String text, LikertScale? selectedValue, Map<String, String> metadata, bool isReversed
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? text = null,Object? selectedValue = freezed,Object? metadata = null,Object? isReversed = null,}) {
  return _then(_Question(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,selectedValue: freezed == selectedValue ? _self.selectedValue : selectedValue // ignore: cast_nullable_to_non_nullable
as LikertScale?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, String>,isReversed: null == isReversed ? _self.isReversed : isReversed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$DimensionScore {

 String get dimension;// e.g., "EI"
 double get score;// Raw calculated score
 double get percentage;// Normalized 0-100 score
 String get dominantTrait;// e.g., "E" or "I"
 String get traitLabel;
/// Create a copy of DimensionScore
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DimensionScoreCopyWith<DimensionScore> get copyWith => _$DimensionScoreCopyWithImpl<DimensionScore>(this as DimensionScore, _$identity);

  /// Serializes this DimensionScore to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DimensionScore&&(identical(other.dimension, dimension) || other.dimension == dimension)&&(identical(other.score, score) || other.score == score)&&(identical(other.percentage, percentage) || other.percentage == percentage)&&(identical(other.dominantTrait, dominantTrait) || other.dominantTrait == dominantTrait)&&(identical(other.traitLabel, traitLabel) || other.traitLabel == traitLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dimension,score,percentage,dominantTrait,traitLabel);

@override
String toString() {
  return 'DimensionScore(dimension: $dimension, score: $score, percentage: $percentage, dominantTrait: $dominantTrait, traitLabel: $traitLabel)';
}


}

/// @nodoc
abstract mixin class $DimensionScoreCopyWith<$Res>  {
  factory $DimensionScoreCopyWith(DimensionScore value, $Res Function(DimensionScore) _then) = _$DimensionScoreCopyWithImpl;
@useResult
$Res call({
 String dimension, double score, double percentage, String dominantTrait, String traitLabel
});




}
/// @nodoc
class _$DimensionScoreCopyWithImpl<$Res>
    implements $DimensionScoreCopyWith<$Res> {
  _$DimensionScoreCopyWithImpl(this._self, this._then);

  final DimensionScore _self;
  final $Res Function(DimensionScore) _then;

/// Create a copy of DimensionScore
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dimension = null,Object? score = null,Object? percentage = null,Object? dominantTrait = null,Object? traitLabel = null,}) {
  return _then(_self.copyWith(
dimension: null == dimension ? _self.dimension : dimension // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as double,dominantTrait: null == dominantTrait ? _self.dominantTrait : dominantTrait // ignore: cast_nullable_to_non_nullable
as String,traitLabel: null == traitLabel ? _self.traitLabel : traitLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DimensionScore].
extension DimensionScorePatterns on DimensionScore {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DimensionScore value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DimensionScore() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DimensionScore value)  $default,){
final _that = this;
switch (_that) {
case _DimensionScore():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DimensionScore value)?  $default,){
final _that = this;
switch (_that) {
case _DimensionScore() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String dimension,  double score,  double percentage,  String dominantTrait,  String traitLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DimensionScore() when $default != null:
return $default(_that.dimension,_that.score,_that.percentage,_that.dominantTrait,_that.traitLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String dimension,  double score,  double percentage,  String dominantTrait,  String traitLabel)  $default,) {final _that = this;
switch (_that) {
case _DimensionScore():
return $default(_that.dimension,_that.score,_that.percentage,_that.dominantTrait,_that.traitLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String dimension,  double score,  double percentage,  String dominantTrait,  String traitLabel)?  $default,) {final _that = this;
switch (_that) {
case _DimensionScore() when $default != null:
return $default(_that.dimension,_that.score,_that.percentage,_that.dominantTrait,_that.traitLabel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DimensionScore implements DimensionScore {
  const _DimensionScore({required this.dimension, required this.score, required this.percentage, required this.dominantTrait, required this.traitLabel});
  factory _DimensionScore.fromJson(Map<String, dynamic> json) => _$DimensionScoreFromJson(json);

@override final  String dimension;
// e.g., "EI"
@override final  double score;
// Raw calculated score
@override final  double percentage;
// Normalized 0-100 score
@override final  String dominantTrait;
// e.g., "E" or "I"
@override final  String traitLabel;

/// Create a copy of DimensionScore
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DimensionScoreCopyWith<_DimensionScore> get copyWith => __$DimensionScoreCopyWithImpl<_DimensionScore>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DimensionScoreToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DimensionScore&&(identical(other.dimension, dimension) || other.dimension == dimension)&&(identical(other.score, score) || other.score == score)&&(identical(other.percentage, percentage) || other.percentage == percentage)&&(identical(other.dominantTrait, dominantTrait) || other.dominantTrait == dominantTrait)&&(identical(other.traitLabel, traitLabel) || other.traitLabel == traitLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dimension,score,percentage,dominantTrait,traitLabel);

@override
String toString() {
  return 'DimensionScore(dimension: $dimension, score: $score, percentage: $percentage, dominantTrait: $dominantTrait, traitLabel: $traitLabel)';
}


}

/// @nodoc
abstract mixin class _$DimensionScoreCopyWith<$Res> implements $DimensionScoreCopyWith<$Res> {
  factory _$DimensionScoreCopyWith(_DimensionScore value, $Res Function(_DimensionScore) _then) = __$DimensionScoreCopyWithImpl;
@override @useResult
$Res call({
 String dimension, double score, double percentage, String dominantTrait, String traitLabel
});




}
/// @nodoc
class __$DimensionScoreCopyWithImpl<$Res>
    implements _$DimensionScoreCopyWith<$Res> {
  __$DimensionScoreCopyWithImpl(this._self, this._then);

  final _DimensionScore _self;
  final $Res Function(_DimensionScore) _then;

/// Create a copy of DimensionScore
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dimension = null,Object? score = null,Object? percentage = null,Object? dominantTrait = null,Object? traitLabel = null,}) {
  return _then(_DimensionScore(
dimension: null == dimension ? _self.dimension : dimension // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as double,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as double,dominantTrait: null == dominantTrait ? _self.dominantTrait : dominantTrait // ignore: cast_nullable_to_non_nullable
as String,traitLabel: null == traitLabel ? _self.traitLabel : traitLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$QuizResult {

 String get id; String get quizId; DateTime get timestamp; List<DimensionScore> get dimensionalAnalysis; String? get mbtiType;// e.g., "INTJ"
 String? get summary; String? get detailedDescription;
/// Create a copy of QuizResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuizResultCopyWith<QuizResult> get copyWith => _$QuizResultCopyWithImpl<QuizResult>(this as QuizResult, _$identity);

  /// Serializes this QuizResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuizResult&&(identical(other.id, id) || other.id == id)&&(identical(other.quizId, quizId) || other.quizId == quizId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other.dimensionalAnalysis, dimensionalAnalysis)&&(identical(other.mbtiType, mbtiType) || other.mbtiType == mbtiType)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.detailedDescription, detailedDescription) || other.detailedDescription == detailedDescription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,quizId,timestamp,const DeepCollectionEquality().hash(dimensionalAnalysis),mbtiType,summary,detailedDescription);

@override
String toString() {
  return 'QuizResult(id: $id, quizId: $quizId, timestamp: $timestamp, dimensionalAnalysis: $dimensionalAnalysis, mbtiType: $mbtiType, summary: $summary, detailedDescription: $detailedDescription)';
}


}

/// @nodoc
abstract mixin class $QuizResultCopyWith<$Res>  {
  factory $QuizResultCopyWith(QuizResult value, $Res Function(QuizResult) _then) = _$QuizResultCopyWithImpl;
@useResult
$Res call({
 String id, String quizId, DateTime timestamp, List<DimensionScore> dimensionalAnalysis, String? mbtiType, String? summary, String? detailedDescription
});




}
/// @nodoc
class _$QuizResultCopyWithImpl<$Res>
    implements $QuizResultCopyWith<$Res> {
  _$QuizResultCopyWithImpl(this._self, this._then);

  final QuizResult _self;
  final $Res Function(QuizResult) _then;

/// Create a copy of QuizResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? quizId = null,Object? timestamp = null,Object? dimensionalAnalysis = null,Object? mbtiType = freezed,Object? summary = freezed,Object? detailedDescription = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,quizId: null == quizId ? _self.quizId : quizId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,dimensionalAnalysis: null == dimensionalAnalysis ? _self.dimensionalAnalysis : dimensionalAnalysis // ignore: cast_nullable_to_non_nullable
as List<DimensionScore>,mbtiType: freezed == mbtiType ? _self.mbtiType : mbtiType // ignore: cast_nullable_to_non_nullable
as String?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,detailedDescription: freezed == detailedDescription ? _self.detailedDescription : detailedDescription // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuizResult].
extension QuizResultPatterns on QuizResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuizResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuizResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuizResult value)  $default,){
final _that = this;
switch (_that) {
case _QuizResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuizResult value)?  $default,){
final _that = this;
switch (_that) {
case _QuizResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String quizId,  DateTime timestamp,  List<DimensionScore> dimensionalAnalysis,  String? mbtiType,  String? summary,  String? detailedDescription)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuizResult() when $default != null:
return $default(_that.id,_that.quizId,_that.timestamp,_that.dimensionalAnalysis,_that.mbtiType,_that.summary,_that.detailedDescription);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String quizId,  DateTime timestamp,  List<DimensionScore> dimensionalAnalysis,  String? mbtiType,  String? summary,  String? detailedDescription)  $default,) {final _that = this;
switch (_that) {
case _QuizResult():
return $default(_that.id,_that.quizId,_that.timestamp,_that.dimensionalAnalysis,_that.mbtiType,_that.summary,_that.detailedDescription);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String quizId,  DateTime timestamp,  List<DimensionScore> dimensionalAnalysis,  String? mbtiType,  String? summary,  String? detailedDescription)?  $default,) {final _that = this;
switch (_that) {
case _QuizResult() when $default != null:
return $default(_that.id,_that.quizId,_that.timestamp,_that.dimensionalAnalysis,_that.mbtiType,_that.summary,_that.detailedDescription);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuizResult implements QuizResult {
  const _QuizResult({required this.id, required this.quizId, required this.timestamp, required final  List<DimensionScore> dimensionalAnalysis, this.mbtiType, this.summary, this.detailedDescription}): _dimensionalAnalysis = dimensionalAnalysis;
  factory _QuizResult.fromJson(Map<String, dynamic> json) => _$QuizResultFromJson(json);

@override final  String id;
@override final  String quizId;
@override final  DateTime timestamp;
 final  List<DimensionScore> _dimensionalAnalysis;
@override List<DimensionScore> get dimensionalAnalysis {
  if (_dimensionalAnalysis is EqualUnmodifiableListView) return _dimensionalAnalysis;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dimensionalAnalysis);
}

@override final  String? mbtiType;
// e.g., "INTJ"
@override final  String? summary;
@override final  String? detailedDescription;

/// Create a copy of QuizResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuizResultCopyWith<_QuizResult> get copyWith => __$QuizResultCopyWithImpl<_QuizResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuizResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuizResult&&(identical(other.id, id) || other.id == id)&&(identical(other.quizId, quizId) || other.quizId == quizId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&const DeepCollectionEquality().equals(other._dimensionalAnalysis, _dimensionalAnalysis)&&(identical(other.mbtiType, mbtiType) || other.mbtiType == mbtiType)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.detailedDescription, detailedDescription) || other.detailedDescription == detailedDescription));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,quizId,timestamp,const DeepCollectionEquality().hash(_dimensionalAnalysis),mbtiType,summary,detailedDescription);

@override
String toString() {
  return 'QuizResult(id: $id, quizId: $quizId, timestamp: $timestamp, dimensionalAnalysis: $dimensionalAnalysis, mbtiType: $mbtiType, summary: $summary, detailedDescription: $detailedDescription)';
}


}

/// @nodoc
abstract mixin class _$QuizResultCopyWith<$Res> implements $QuizResultCopyWith<$Res> {
  factory _$QuizResultCopyWith(_QuizResult value, $Res Function(_QuizResult) _then) = __$QuizResultCopyWithImpl;
@override @useResult
$Res call({
 String id, String quizId, DateTime timestamp, List<DimensionScore> dimensionalAnalysis, String? mbtiType, String? summary, String? detailedDescription
});




}
/// @nodoc
class __$QuizResultCopyWithImpl<$Res>
    implements _$QuizResultCopyWith<$Res> {
  __$QuizResultCopyWithImpl(this._self, this._then);

  final _QuizResult _self;
  final $Res Function(_QuizResult) _then;

/// Create a copy of QuizResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? quizId = null,Object? timestamp = null,Object? dimensionalAnalysis = null,Object? mbtiType = freezed,Object? summary = freezed,Object? detailedDescription = freezed,}) {
  return _then(_QuizResult(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,quizId: null == quizId ? _self.quizId : quizId // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,dimensionalAnalysis: null == dimensionalAnalysis ? _self._dimensionalAnalysis : dimensionalAnalysis // ignore: cast_nullable_to_non_nullable
as List<DimensionScore>,mbtiType: freezed == mbtiType ? _self.mbtiType : mbtiType // ignore: cast_nullable_to_non_nullable
as String?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,detailedDescription: freezed == detailedDescription ? _self.detailedDescription : detailedDescription // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
