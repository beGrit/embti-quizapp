// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SocialMeta {

 String get id; String get relatedId; int get likesCount; bool get isLiked; int get favoritesCount; bool get isFavorited; int get sharesCount; List<Comment> get comments; int get commentsCount;
/// Create a copy of SocialMeta
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialMetaCopyWith<SocialMeta> get copyWith => _$SocialMetaCopyWithImpl<SocialMeta>(this as SocialMeta, _$identity);

  /// Serializes this SocialMeta to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialMeta&&(identical(other.id, id) || other.id == id)&&(identical(other.relatedId, relatedId) || other.relatedId == relatedId)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.isLiked, isLiked) || other.isLiked == isLiked)&&(identical(other.favoritesCount, favoritesCount) || other.favoritesCount == favoritesCount)&&(identical(other.isFavorited, isFavorited) || other.isFavorited == isFavorited)&&(identical(other.sharesCount, sharesCount) || other.sharesCount == sharesCount)&&const DeepCollectionEquality().equals(other.comments, comments)&&(identical(other.commentsCount, commentsCount) || other.commentsCount == commentsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,relatedId,likesCount,isLiked,favoritesCount,isFavorited,sharesCount,const DeepCollectionEquality().hash(comments),commentsCount);

@override
String toString() {
  return 'SocialMeta(id: $id, relatedId: $relatedId, likesCount: $likesCount, isLiked: $isLiked, favoritesCount: $favoritesCount, isFavorited: $isFavorited, sharesCount: $sharesCount, comments: $comments, commentsCount: $commentsCount)';
}


}

/// @nodoc
abstract mixin class $SocialMetaCopyWith<$Res>  {
  factory $SocialMetaCopyWith(SocialMeta value, $Res Function(SocialMeta) _then) = _$SocialMetaCopyWithImpl;
@useResult
$Res call({
 String id, String relatedId, int likesCount, bool isLiked, int favoritesCount, bool isFavorited, int sharesCount, List<Comment> comments, int commentsCount
});




}
/// @nodoc
class _$SocialMetaCopyWithImpl<$Res>
    implements $SocialMetaCopyWith<$Res> {
  _$SocialMetaCopyWithImpl(this._self, this._then);

  final SocialMeta _self;
  final $Res Function(SocialMeta) _then;

/// Create a copy of SocialMeta
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? relatedId = null,Object? likesCount = null,Object? isLiked = null,Object? favoritesCount = null,Object? isFavorited = null,Object? sharesCount = null,Object? comments = null,Object? commentsCount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,relatedId: null == relatedId ? _self.relatedId : relatedId // ignore: cast_nullable_to_non_nullable
as String,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,isLiked: null == isLiked ? _self.isLiked : isLiked // ignore: cast_nullable_to_non_nullable
as bool,favoritesCount: null == favoritesCount ? _self.favoritesCount : favoritesCount // ignore: cast_nullable_to_non_nullable
as int,isFavorited: null == isFavorited ? _self.isFavorited : isFavorited // ignore: cast_nullable_to_non_nullable
as bool,sharesCount: null == sharesCount ? _self.sharesCount : sharesCount // ignore: cast_nullable_to_non_nullable
as int,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as List<Comment>,commentsCount: null == commentsCount ? _self.commentsCount : commentsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialMeta].
extension SocialMetaPatterns on SocialMeta {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialMeta value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialMeta() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialMeta value)  $default,){
final _that = this;
switch (_that) {
case _SocialMeta():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialMeta value)?  $default,){
final _that = this;
switch (_that) {
case _SocialMeta() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String relatedId,  int likesCount,  bool isLiked,  int favoritesCount,  bool isFavorited,  int sharesCount,  List<Comment> comments,  int commentsCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialMeta() when $default != null:
return $default(_that.id,_that.relatedId,_that.likesCount,_that.isLiked,_that.favoritesCount,_that.isFavorited,_that.sharesCount,_that.comments,_that.commentsCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String relatedId,  int likesCount,  bool isLiked,  int favoritesCount,  bool isFavorited,  int sharesCount,  List<Comment> comments,  int commentsCount)  $default,) {final _that = this;
switch (_that) {
case _SocialMeta():
return $default(_that.id,_that.relatedId,_that.likesCount,_that.isLiked,_that.favoritesCount,_that.isFavorited,_that.sharesCount,_that.comments,_that.commentsCount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String relatedId,  int likesCount,  bool isLiked,  int favoritesCount,  bool isFavorited,  int sharesCount,  List<Comment> comments,  int commentsCount)?  $default,) {final _that = this;
switch (_that) {
case _SocialMeta() when $default != null:
return $default(_that.id,_that.relatedId,_that.likesCount,_that.isLiked,_that.favoritesCount,_that.isFavorited,_that.sharesCount,_that.comments,_that.commentsCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialMeta extends SocialMeta {
  const _SocialMeta({required this.id, required this.relatedId, this.likesCount = 0, this.isLiked = false, this.favoritesCount = 0, this.isFavorited = false, this.sharesCount = 0, final  List<Comment> comments = const [], this.commentsCount = 0}): _comments = comments,super._();
  factory _SocialMeta.fromJson(Map<String, dynamic> json) => _$SocialMetaFromJson(json);

@override final  String id;
@override final  String relatedId;
@override@JsonKey() final  int likesCount;
@override@JsonKey() final  bool isLiked;
@override@JsonKey() final  int favoritesCount;
@override@JsonKey() final  bool isFavorited;
@override@JsonKey() final  int sharesCount;
 final  List<Comment> _comments;
@override@JsonKey() List<Comment> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}

@override@JsonKey() final  int commentsCount;

/// Create a copy of SocialMeta
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialMetaCopyWith<_SocialMeta> get copyWith => __$SocialMetaCopyWithImpl<_SocialMeta>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialMetaToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialMeta&&(identical(other.id, id) || other.id == id)&&(identical(other.relatedId, relatedId) || other.relatedId == relatedId)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.isLiked, isLiked) || other.isLiked == isLiked)&&(identical(other.favoritesCount, favoritesCount) || other.favoritesCount == favoritesCount)&&(identical(other.isFavorited, isFavorited) || other.isFavorited == isFavorited)&&(identical(other.sharesCount, sharesCount) || other.sharesCount == sharesCount)&&const DeepCollectionEquality().equals(other._comments, _comments)&&(identical(other.commentsCount, commentsCount) || other.commentsCount == commentsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,relatedId,likesCount,isLiked,favoritesCount,isFavorited,sharesCount,const DeepCollectionEquality().hash(_comments),commentsCount);

@override
String toString() {
  return 'SocialMeta(id: $id, relatedId: $relatedId, likesCount: $likesCount, isLiked: $isLiked, favoritesCount: $favoritesCount, isFavorited: $isFavorited, sharesCount: $sharesCount, comments: $comments, commentsCount: $commentsCount)';
}


}

/// @nodoc
abstract mixin class _$SocialMetaCopyWith<$Res> implements $SocialMetaCopyWith<$Res> {
  factory _$SocialMetaCopyWith(_SocialMeta value, $Res Function(_SocialMeta) _then) = __$SocialMetaCopyWithImpl;
@override @useResult
$Res call({
 String id, String relatedId, int likesCount, bool isLiked, int favoritesCount, bool isFavorited, int sharesCount, List<Comment> comments, int commentsCount
});




}
/// @nodoc
class __$SocialMetaCopyWithImpl<$Res>
    implements _$SocialMetaCopyWith<$Res> {
  __$SocialMetaCopyWithImpl(this._self, this._then);

  final _SocialMeta _self;
  final $Res Function(_SocialMeta) _then;

/// Create a copy of SocialMeta
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? relatedId = null,Object? likesCount = null,Object? isLiked = null,Object? favoritesCount = null,Object? isFavorited = null,Object? sharesCount = null,Object? comments = null,Object? commentsCount = null,}) {
  return _then(_SocialMeta(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,relatedId: null == relatedId ? _self.relatedId : relatedId // ignore: cast_nullable_to_non_nullable
as String,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,isLiked: null == isLiked ? _self.isLiked : isLiked // ignore: cast_nullable_to_non_nullable
as bool,favoritesCount: null == favoritesCount ? _self.favoritesCount : favoritesCount // ignore: cast_nullable_to_non_nullable
as int,isFavorited: null == isFavorited ? _self.isFavorited : isFavorited // ignore: cast_nullable_to_non_nullable
as bool,sharesCount: null == sharesCount ? _self.sharesCount : sharesCount // ignore: cast_nullable_to_non_nullable
as int,comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<Comment>,commentsCount: null == commentsCount ? _self.commentsCount : commentsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$Comment {

 String get id; String get userId; String get authorName; String get authorMbti; String? get authorAvatarUrl; String get content; DateTime get createdAt; int get likesCount; bool get isLiked;
/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CommentCopyWith<Comment> get copyWith => _$CommentCopyWithImpl<Comment>(this as Comment, _$identity);

  /// Serializes this Comment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Comment&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorMbti, authorMbti) || other.authorMbti == authorMbti)&&(identical(other.authorAvatarUrl, authorAvatarUrl) || other.authorAvatarUrl == authorAvatarUrl)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.isLiked, isLiked) || other.isLiked == isLiked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,authorName,authorMbti,authorAvatarUrl,content,createdAt,likesCount,isLiked);

@override
String toString() {
  return 'Comment(id: $id, userId: $userId, authorName: $authorName, authorMbti: $authorMbti, authorAvatarUrl: $authorAvatarUrl, content: $content, createdAt: $createdAt, likesCount: $likesCount, isLiked: $isLiked)';
}


}

/// @nodoc
abstract mixin class $CommentCopyWith<$Res>  {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) _then) = _$CommentCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String authorName, String authorMbti, String? authorAvatarUrl, String content, DateTime createdAt, int likesCount, bool isLiked
});




}
/// @nodoc
class _$CommentCopyWithImpl<$Res>
    implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._self, this._then);

  final Comment _self;
  final $Res Function(Comment) _then;

/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? authorName = null,Object? authorMbti = null,Object? authorAvatarUrl = freezed,Object? content = null,Object? createdAt = null,Object? likesCount = null,Object? isLiked = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,authorMbti: null == authorMbti ? _self.authorMbti : authorMbti // ignore: cast_nullable_to_non_nullable
as String,authorAvatarUrl: freezed == authorAvatarUrl ? _self.authorAvatarUrl : authorAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,isLiked: null == isLiked ? _self.isLiked : isLiked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Comment].
extension CommentPatterns on Comment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Comment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Comment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Comment value)  $default,){
final _that = this;
switch (_that) {
case _Comment():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Comment value)?  $default,){
final _that = this;
switch (_that) {
case _Comment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String authorName,  String authorMbti,  String? authorAvatarUrl,  String content,  DateTime createdAt,  int likesCount,  bool isLiked)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Comment() when $default != null:
return $default(_that.id,_that.userId,_that.authorName,_that.authorMbti,_that.authorAvatarUrl,_that.content,_that.createdAt,_that.likesCount,_that.isLiked);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String authorName,  String authorMbti,  String? authorAvatarUrl,  String content,  DateTime createdAt,  int likesCount,  bool isLiked)  $default,) {final _that = this;
switch (_that) {
case _Comment():
return $default(_that.id,_that.userId,_that.authorName,_that.authorMbti,_that.authorAvatarUrl,_that.content,_that.createdAt,_that.likesCount,_that.isLiked);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String authorName,  String authorMbti,  String? authorAvatarUrl,  String content,  DateTime createdAt,  int likesCount,  bool isLiked)?  $default,) {final _that = this;
switch (_that) {
case _Comment() when $default != null:
return $default(_that.id,_that.userId,_that.authorName,_that.authorMbti,_that.authorAvatarUrl,_that.content,_that.createdAt,_that.likesCount,_that.isLiked);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Comment extends Comment {
  const _Comment({required this.id, required this.userId, this.authorName = 'Anonymous', this.authorMbti = 'XXXX', this.authorAvatarUrl, required this.content, required this.createdAt, this.likesCount = 0, this.isLiked = false}): super._();
  factory _Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

@override final  String id;
@override final  String userId;
@override@JsonKey() final  String authorName;
@override@JsonKey() final  String authorMbti;
@override final  String? authorAvatarUrl;
@override final  String content;
@override final  DateTime createdAt;
@override@JsonKey() final  int likesCount;
@override@JsonKey() final  bool isLiked;

/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommentCopyWith<_Comment> get copyWith => __$CommentCopyWithImpl<_Comment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CommentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Comment&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorMbti, authorMbti) || other.authorMbti == authorMbti)&&(identical(other.authorAvatarUrl, authorAvatarUrl) || other.authorAvatarUrl == authorAvatarUrl)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.isLiked, isLiked) || other.isLiked == isLiked));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,authorName,authorMbti,authorAvatarUrl,content,createdAt,likesCount,isLiked);

@override
String toString() {
  return 'Comment(id: $id, userId: $userId, authorName: $authorName, authorMbti: $authorMbti, authorAvatarUrl: $authorAvatarUrl, content: $content, createdAt: $createdAt, likesCount: $likesCount, isLiked: $isLiked)';
}


}

/// @nodoc
abstract mixin class _$CommentCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$CommentCopyWith(_Comment value, $Res Function(_Comment) _then) = __$CommentCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String authorName, String authorMbti, String? authorAvatarUrl, String content, DateTime createdAt, int likesCount, bool isLiked
});




}
/// @nodoc
class __$CommentCopyWithImpl<$Res>
    implements _$CommentCopyWith<$Res> {
  __$CommentCopyWithImpl(this._self, this._then);

  final _Comment _self;
  final $Res Function(_Comment) _then;

/// Create a copy of Comment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? authorName = null,Object? authorMbti = null,Object? authorAvatarUrl = freezed,Object? content = null,Object? createdAt = null,Object? likesCount = null,Object? isLiked = null,}) {
  return _then(_Comment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,authorMbti: null == authorMbti ? _self.authorMbti : authorMbti // ignore: cast_nullable_to_non_nullable
as String,authorAvatarUrl: freezed == authorAvatarUrl ? _self.authorAvatarUrl : authorAvatarUrl // ignore: cast_nullable_to_non_nullable
as String?,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,isLiked: null == isLiked ? _self.isLiked : isLiked // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
