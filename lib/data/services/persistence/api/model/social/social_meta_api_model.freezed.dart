// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_meta_api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SocialMetaApiModel {

@JsonKey(includeFromJson: false, includeToJson: false) String? get id; String get relatedId; SocialMetricsApiModel get metrics;@FirestoreTimestampConverter() DateTime get created;@FirestoreTimestampConverter() DateTime get updated;
/// Create a copy of SocialMetaApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialMetaApiModelCopyWith<SocialMetaApiModel> get copyWith => _$SocialMetaApiModelCopyWithImpl<SocialMetaApiModel>(this as SocialMetaApiModel, _$identity);

  /// Serializes this SocialMetaApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialMetaApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.relatedId, relatedId) || other.relatedId == relatedId)&&(identical(other.metrics, metrics) || other.metrics == metrics)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,relatedId,metrics,created,updated);

@override
String toString() {
  return 'SocialMetaApiModel(id: $id, relatedId: $relatedId, metrics: $metrics, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class $SocialMetaApiModelCopyWith<$Res>  {
  factory $SocialMetaApiModelCopyWith(SocialMetaApiModel value, $Res Function(SocialMetaApiModel) _then) = _$SocialMetaApiModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeFromJson: false, includeToJson: false) String? id, String relatedId, SocialMetricsApiModel metrics,@FirestoreTimestampConverter() DateTime created,@FirestoreTimestampConverter() DateTime updated
});


$SocialMetricsApiModelCopyWith<$Res> get metrics;

}
/// @nodoc
class _$SocialMetaApiModelCopyWithImpl<$Res>
    implements $SocialMetaApiModelCopyWith<$Res> {
  _$SocialMetaApiModelCopyWithImpl(this._self, this._then);

  final SocialMetaApiModel _self;
  final $Res Function(SocialMetaApiModel) _then;

/// Create a copy of SocialMetaApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? relatedId = null,Object? metrics = null,Object? created = null,Object? updated = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,relatedId: null == relatedId ? _self.relatedId : relatedId // ignore: cast_nullable_to_non_nullable
as String,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as SocialMetricsApiModel,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of SocialMetaApiModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialMetricsApiModelCopyWith<$Res> get metrics {
  
  return $SocialMetricsApiModelCopyWith<$Res>(_self.metrics, (value) {
    return _then(_self.copyWith(metrics: value));
  });
}
}


/// Adds pattern-matching-related methods to [SocialMetaApiModel].
extension SocialMetaApiModelPatterns on SocialMetaApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialMetaApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialMetaApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialMetaApiModel value)  $default,){
final _that = this;
switch (_that) {
case _SocialMetaApiModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialMetaApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _SocialMetaApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeFromJson: false, includeToJson: false)  String? id,  String relatedId,  SocialMetricsApiModel metrics, @FirestoreTimestampConverter()  DateTime created, @FirestoreTimestampConverter()  DateTime updated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialMetaApiModel() when $default != null:
return $default(_that.id,_that.relatedId,_that.metrics,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeFromJson: false, includeToJson: false)  String? id,  String relatedId,  SocialMetricsApiModel metrics, @FirestoreTimestampConverter()  DateTime created, @FirestoreTimestampConverter()  DateTime updated)  $default,) {final _that = this;
switch (_that) {
case _SocialMetaApiModel():
return $default(_that.id,_that.relatedId,_that.metrics,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeFromJson: false, includeToJson: false)  String? id,  String relatedId,  SocialMetricsApiModel metrics, @FirestoreTimestampConverter()  DateTime created, @FirestoreTimestampConverter()  DateTime updated)?  $default,) {final _that = this;
switch (_that) {
case _SocialMetaApiModel() when $default != null:
return $default(_that.id,_that.relatedId,_that.metrics,_that.created,_that.updated);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _SocialMetaApiModel implements SocialMetaApiModel {
  const _SocialMetaApiModel({@JsonKey(includeFromJson: false, includeToJson: false) this.id, required this.relatedId, required this.metrics, @FirestoreTimestampConverter() required this.created, @FirestoreTimestampConverter() required this.updated});
  factory _SocialMetaApiModel.fromJson(Map<String, dynamic> json) => _$SocialMetaApiModelFromJson(json);

@override@JsonKey(includeFromJson: false, includeToJson: false) final  String? id;
@override final  String relatedId;
@override final  SocialMetricsApiModel metrics;
@override@FirestoreTimestampConverter() final  DateTime created;
@override@FirestoreTimestampConverter() final  DateTime updated;

/// Create a copy of SocialMetaApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialMetaApiModelCopyWith<_SocialMetaApiModel> get copyWith => __$SocialMetaApiModelCopyWithImpl<_SocialMetaApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialMetaApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialMetaApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.relatedId, relatedId) || other.relatedId == relatedId)&&(identical(other.metrics, metrics) || other.metrics == metrics)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,relatedId,metrics,created,updated);

@override
String toString() {
  return 'SocialMetaApiModel(id: $id, relatedId: $relatedId, metrics: $metrics, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class _$SocialMetaApiModelCopyWith<$Res> implements $SocialMetaApiModelCopyWith<$Res> {
  factory _$SocialMetaApiModelCopyWith(_SocialMetaApiModel value, $Res Function(_SocialMetaApiModel) _then) = __$SocialMetaApiModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeFromJson: false, includeToJson: false) String? id, String relatedId, SocialMetricsApiModel metrics,@FirestoreTimestampConverter() DateTime created,@FirestoreTimestampConverter() DateTime updated
});


@override $SocialMetricsApiModelCopyWith<$Res> get metrics;

}
/// @nodoc
class __$SocialMetaApiModelCopyWithImpl<$Res>
    implements _$SocialMetaApiModelCopyWith<$Res> {
  __$SocialMetaApiModelCopyWithImpl(this._self, this._then);

  final _SocialMetaApiModel _self;
  final $Res Function(_SocialMetaApiModel) _then;

/// Create a copy of SocialMetaApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? relatedId = null,Object? metrics = null,Object? created = null,Object? updated = null,}) {
  return _then(_SocialMetaApiModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,relatedId: null == relatedId ? _self.relatedId : relatedId // ignore: cast_nullable_to_non_nullable
as String,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as SocialMetricsApiModel,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of SocialMetaApiModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SocialMetricsApiModelCopyWith<$Res> get metrics {
  
  return $SocialMetricsApiModelCopyWith<$Res>(_self.metrics, (value) {
    return _then(_self.copyWith(metrics: value));
  });
}
}


/// @nodoc
mixin _$SocialMetricsApiModel {

 int get favorites; int get likes; int get shares; int get comments;
/// Create a copy of SocialMetricsApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialMetricsApiModelCopyWith<SocialMetricsApiModel> get copyWith => _$SocialMetricsApiModelCopyWithImpl<SocialMetricsApiModel>(this as SocialMetricsApiModel, _$identity);

  /// Serializes this SocialMetricsApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialMetricsApiModel&&(identical(other.favorites, favorites) || other.favorites == favorites)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.shares, shares) || other.shares == shares)&&(identical(other.comments, comments) || other.comments == comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,favorites,likes,shares,comments);

@override
String toString() {
  return 'SocialMetricsApiModel(favorites: $favorites, likes: $likes, shares: $shares, comments: $comments)';
}


}

/// @nodoc
abstract mixin class $SocialMetricsApiModelCopyWith<$Res>  {
  factory $SocialMetricsApiModelCopyWith(SocialMetricsApiModel value, $Res Function(SocialMetricsApiModel) _then) = _$SocialMetricsApiModelCopyWithImpl;
@useResult
$Res call({
 int favorites, int likes, int shares, int comments
});




}
/// @nodoc
class _$SocialMetricsApiModelCopyWithImpl<$Res>
    implements $SocialMetricsApiModelCopyWith<$Res> {
  _$SocialMetricsApiModelCopyWithImpl(this._self, this._then);

  final SocialMetricsApiModel _self;
  final $Res Function(SocialMetricsApiModel) _then;

/// Create a copy of SocialMetricsApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? favorites = null,Object? likes = null,Object? shares = null,Object? comments = null,}) {
  return _then(_self.copyWith(
favorites: null == favorites ? _self.favorites : favorites // ignore: cast_nullable_to_non_nullable
as int,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,shares: null == shares ? _self.shares : shares // ignore: cast_nullable_to_non_nullable
as int,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialMetricsApiModel].
extension SocialMetricsApiModelPatterns on SocialMetricsApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialMetricsApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialMetricsApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialMetricsApiModel value)  $default,){
final _that = this;
switch (_that) {
case _SocialMetricsApiModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialMetricsApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _SocialMetricsApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int favorites,  int likes,  int shares,  int comments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialMetricsApiModel() when $default != null:
return $default(_that.favorites,_that.likes,_that.shares,_that.comments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int favorites,  int likes,  int shares,  int comments)  $default,) {final _that = this;
switch (_that) {
case _SocialMetricsApiModel():
return $default(_that.favorites,_that.likes,_that.shares,_that.comments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int favorites,  int likes,  int shares,  int comments)?  $default,) {final _that = this;
switch (_that) {
case _SocialMetricsApiModel() when $default != null:
return $default(_that.favorites,_that.likes,_that.shares,_that.comments);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialMetricsApiModel implements SocialMetricsApiModel {
  const _SocialMetricsApiModel({this.favorites = 0, this.likes = 0, this.shares = 0, this.comments = 0});
  factory _SocialMetricsApiModel.fromJson(Map<String, dynamic> json) => _$SocialMetricsApiModelFromJson(json);

@override@JsonKey() final  int favorites;
@override@JsonKey() final  int likes;
@override@JsonKey() final  int shares;
@override@JsonKey() final  int comments;

/// Create a copy of SocialMetricsApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialMetricsApiModelCopyWith<_SocialMetricsApiModel> get copyWith => __$SocialMetricsApiModelCopyWithImpl<_SocialMetricsApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialMetricsApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialMetricsApiModel&&(identical(other.favorites, favorites) || other.favorites == favorites)&&(identical(other.likes, likes) || other.likes == likes)&&(identical(other.shares, shares) || other.shares == shares)&&(identical(other.comments, comments) || other.comments == comments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,favorites,likes,shares,comments);

@override
String toString() {
  return 'SocialMetricsApiModel(favorites: $favorites, likes: $likes, shares: $shares, comments: $comments)';
}


}

/// @nodoc
abstract mixin class _$SocialMetricsApiModelCopyWith<$Res> implements $SocialMetricsApiModelCopyWith<$Res> {
  factory _$SocialMetricsApiModelCopyWith(_SocialMetricsApiModel value, $Res Function(_SocialMetricsApiModel) _then) = __$SocialMetricsApiModelCopyWithImpl;
@override @useResult
$Res call({
 int favorites, int likes, int shares, int comments
});




}
/// @nodoc
class __$SocialMetricsApiModelCopyWithImpl<$Res>
    implements _$SocialMetricsApiModelCopyWith<$Res> {
  __$SocialMetricsApiModelCopyWithImpl(this._self, this._then);

  final _SocialMetricsApiModel _self;
  final $Res Function(_SocialMetricsApiModel) _then;

/// Create a copy of SocialMetricsApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? favorites = null,Object? likes = null,Object? shares = null,Object? comments = null,}) {
  return _then(_SocialMetricsApiModel(
favorites: null == favorites ? _self.favorites : favorites // ignore: cast_nullable_to_non_nullable
as int,likes: null == likes ? _self.likes : likes // ignore: cast_nullable_to_non_nullable
as int,shares: null == shares ? _self.shares : shares // ignore: cast_nullable_to_non_nullable
as int,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CommentApiModel {

@JsonKey(includeFromJson: false, includeToJson: false) String? get id; String get userId; String get authorName; String get authorMbti; String? get authorAvatarUrl; String get content;@FirestoreTimestampConverter() DateTime get createdAt; int get likesCount;
/// Create a copy of CommentApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentApiModelCopyWith<CommentApiModel> get copyWith => _$CommentApiModelCopyWithImpl<CommentApiModel>(this as CommentApiModel, _$identity);

  /// Serializes this CommentApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CommentApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorMbti, authorMbti) || other.authorMbti == authorMbti)&&(identical(other.authorAvatarUrl, authorAvatarUrl) || other.authorAvatarUrl == authorAvatarUrl)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,authorName,authorMbti,authorAvatarUrl,content,createdAt,likesCount);

@override
String toString() {
  return 'CommentApiModel(id: $id, userId: $userId, authorName: $authorName, authorMbti: $authorMbti, authorAvatarUrl: $authorAvatarUrl, content: $content, createdAt: $createdAt, likesCount: $likesCount)';
}


}

/// @nodoc
abstract mixin class $CommentApiModelCopyWith<$Res>  {
  factory $CommentApiModelCopyWith(CommentApiModel value, $Res Function(CommentApiModel) _then) = _$CommentApiModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeFromJson: false, includeToJson: false) String? id, String userId, String authorName, String authorMbti, String? authorAvatarUrl, String content,@FirestoreTimestampConverter() DateTime createdAt, int likesCount
});




}
/// @nodoc
class _$CommentApiModelCopyWithImpl<$Res>
    implements $CommentApiModelCopyWith<$Res> {
  _$CommentApiModelCopyWithImpl(this._self, this._then);

  final CommentApiModel _self;
  final $Res Function(CommentApiModel) _then;

/// Create a copy of CommentApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? userId = null,Object? authorName = null,Object? authorMbti = null,Object? authorAvatarUrl = freezed,Object? content = null,Object? createdAt = null,Object? likesCount = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,authorMbti: null == authorMbti ? _self.authorMbti : authorMbti // ignore: cast_nullable_to_non_nullable
as String,authorAvatarUrl: freezed == authorAvatarUrl ? _self.authorAvatarUrl : authorAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CommentApiModel].
extension CommentApiModelPatterns on CommentApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CommentApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CommentApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CommentApiModel value)  $default,){
final _that = this;
switch (_that) {
case _CommentApiModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CommentApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _CommentApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeFromJson: false, includeToJson: false)  String? id,  String userId,  String authorName,  String authorMbti,  String? authorAvatarUrl,  String content, @FirestoreTimestampConverter()  DateTime createdAt,  int likesCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CommentApiModel() when $default != null:
return $default(_that.id,_that.userId,_that.authorName,_that.authorMbti,_that.authorAvatarUrl,_that.content,_that.createdAt,_that.likesCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeFromJson: false, includeToJson: false)  String? id,  String userId,  String authorName,  String authorMbti,  String? authorAvatarUrl,  String content, @FirestoreTimestampConverter()  DateTime createdAt,  int likesCount)  $default,) {final _that = this;
switch (_that) {
case _CommentApiModel():
return $default(_that.id,_that.userId,_that.authorName,_that.authorMbti,_that.authorAvatarUrl,_that.content,_that.createdAt,_that.likesCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeFromJson: false, includeToJson: false)  String? id,  String userId,  String authorName,  String authorMbti,  String? authorAvatarUrl,  String content, @FirestoreTimestampConverter()  DateTime createdAt,  int likesCount)?  $default,) {final _that = this;
switch (_that) {
case _CommentApiModel() when $default != null:
return $default(_that.id,_that.userId,_that.authorName,_that.authorMbti,_that.authorAvatarUrl,_that.content,_that.createdAt,_that.likesCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CommentApiModel implements CommentApiModel {
  const _CommentApiModel({@JsonKey(includeFromJson: false, includeToJson: false) this.id, required this.userId, this.authorName = 'Anonymous', this.authorMbti = 'XXXX', this.authorAvatarUrl, required this.content, @FirestoreTimestampConverter() required this.createdAt, this.likesCount = 0});
  factory _CommentApiModel.fromJson(Map<String, dynamic> json) => _$CommentApiModelFromJson(json);

@override@JsonKey(includeFromJson: false, includeToJson: false) final  String? id;
@override final  String userId;
@override@JsonKey() final  String authorName;
@override@JsonKey() final  String authorMbti;
@override final  String? authorAvatarUrl;
@override final  String content;
@override@FirestoreTimestampConverter() final  DateTime createdAt;
@override@JsonKey() final  int likesCount;

/// Create a copy of CommentApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentApiModelCopyWith<_CommentApiModel> get copyWith => __$CommentApiModelCopyWithImpl<_CommentApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommentApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorMbti, authorMbti) || other.authorMbti == authorMbti)&&(identical(other.authorAvatarUrl, authorAvatarUrl) || other.authorAvatarUrl == authorAvatarUrl)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,authorName,authorMbti,authorAvatarUrl,content,createdAt,likesCount);

@override
String toString() {
  return 'CommentApiModel(id: $id, userId: $userId, authorName: $authorName, authorMbti: $authorMbti, authorAvatarUrl: $authorAvatarUrl, content: $content, createdAt: $createdAt, likesCount: $likesCount)';
}


}

/// @nodoc
abstract mixin class _$CommentApiModelCopyWith<$Res> implements $CommentApiModelCopyWith<$Res> {
  factory _$CommentApiModelCopyWith(_CommentApiModel value, $Res Function(_CommentApiModel) _then) = __$CommentApiModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeFromJson: false, includeToJson: false) String? id, String userId, String authorName, String authorMbti, String? authorAvatarUrl, String content,@FirestoreTimestampConverter() DateTime createdAt, int likesCount
});




}
/// @nodoc
class __$CommentApiModelCopyWithImpl<$Res>
    implements _$CommentApiModelCopyWith<$Res> {
  __$CommentApiModelCopyWithImpl(this._self, this._then);

  final _CommentApiModel _self;
  final $Res Function(_CommentApiModel) _then;

/// Create a copy of CommentApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? userId = null,Object? authorName = null,Object? authorMbti = null,Object? authorAvatarUrl = freezed,Object? content = null,Object? createdAt = null,Object? likesCount = null,}) {
  return _then(_CommentApiModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,authorMbti: null == authorMbti ? _self.authorMbti : authorMbti // ignore: cast_nullable_to_non_nullable
as String,authorAvatarUrl: freezed == authorAvatarUrl ? _self.authorAvatarUrl : authorAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
