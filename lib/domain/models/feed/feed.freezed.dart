// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Post {

 String? get id; FeedType get feedType; String? get title; String? get body; List<AppFile> get photos; User get author; DateTime get created; DateTime get updated;
/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostCopyWith<Post> get copyWith => _$PostCopyWithImpl<Post>(this as Post, _$identity);

  /// Serializes this Post to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Post&&(identical(other.id, id) || other.id == id)&&(identical(other.feedType, feedType) || other.feedType == feedType)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&const DeepCollectionEquality().equals(other.photos, photos)&&(identical(other.author, author) || other.author == author)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,feedType,title,body,const DeepCollectionEquality().hash(photos),author,created,updated);

@override
String toString() {
  return 'Post(id: $id, feedType: $feedType, title: $title, body: $body, photos: $photos, author: $author, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class $PostCopyWith<$Res>  {
  factory $PostCopyWith(Post value, $Res Function(Post) _then) = _$PostCopyWithImpl;
@useResult
$Res call({
 String? id, FeedType feedType, String? title, String? body, List<AppFile> photos, User author, DateTime created, DateTime updated
});


$UserCopyWith<$Res> get author;

}
/// @nodoc
class _$PostCopyWithImpl<$Res>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._self, this._then);

  final Post _self;
  final $Res Function(Post) _then;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? feedType = null,Object? title = freezed,Object? body = freezed,Object? photos = null,Object? author = null,Object? created = null,Object? updated = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,feedType: null == feedType ? _self.feedType : feedType // ignore: cast_nullable_to_non_nullable
as FeedType,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<AppFile>,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as User,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get author {
  
  return $UserCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// Adds pattern-matching-related methods to [Post].
extension PostPatterns on Post {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Post value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Post() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Post value)  $default,){
final _that = this;
switch (_that) {
case _Post():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Post value)?  $default,){
final _that = this;
switch (_that) {
case _Post() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  FeedType feedType,  String? title,  String? body,  List<AppFile> photos,  User author,  DateTime created,  DateTime updated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Post() when $default != null:
return $default(_that.id,_that.feedType,_that.title,_that.body,_that.photos,_that.author,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  FeedType feedType,  String? title,  String? body,  List<AppFile> photos,  User author,  DateTime created,  DateTime updated)  $default,) {final _that = this;
switch (_that) {
case _Post():
return $default(_that.id,_that.feedType,_that.title,_that.body,_that.photos,_that.author,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  FeedType feedType,  String? title,  String? body,  List<AppFile> photos,  User author,  DateTime created,  DateTime updated)?  $default,) {final _that = this;
switch (_that) {
case _Post() when $default != null:
return $default(_that.id,_that.feedType,_that.title,_that.body,_that.photos,_that.author,_that.created,_that.updated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Post implements Post {
  const _Post({this.id, required this.feedType, this.title, this.body, final  List<AppFile> photos = const [], required this.author, required this.created, required this.updated}): _photos = photos;
  factory _Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

@override final  String? id;
@override final  FeedType feedType;
@override final  String? title;
@override final  String? body;
 final  List<AppFile> _photos;
@override@JsonKey() List<AppFile> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}

@override final  User author;
@override final  DateTime created;
@override final  DateTime updated;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostCopyWith<_Post> get copyWith => __$PostCopyWithImpl<_Post>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Post&&(identical(other.id, id) || other.id == id)&&(identical(other.feedType, feedType) || other.feedType == feedType)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&const DeepCollectionEquality().equals(other._photos, _photos)&&(identical(other.author, author) || other.author == author)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,feedType,title,body,const DeepCollectionEquality().hash(_photos),author,created,updated);

@override
String toString() {
  return 'Post(id: $id, feedType: $feedType, title: $title, body: $body, photos: $photos, author: $author, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class _$PostCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$PostCopyWith(_Post value, $Res Function(_Post) _then) = __$PostCopyWithImpl;
@override @useResult
$Res call({
 String? id, FeedType feedType, String? title, String? body, List<AppFile> photos, User author, DateTime created, DateTime updated
});


@override $UserCopyWith<$Res> get author;

}
/// @nodoc
class __$PostCopyWithImpl<$Res>
    implements _$PostCopyWith<$Res> {
  __$PostCopyWithImpl(this._self, this._then);

  final _Post _self;
  final $Res Function(_Post) _then;

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? feedType = null,Object? title = freezed,Object? body = freezed,Object? photos = null,Object? author = null,Object? created = null,Object? updated = null,}) {
  return _then(_Post(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,feedType: null == feedType ? _self.feedType : feedType // ignore: cast_nullable_to_non_nullable
as FeedType,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<AppFile>,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as User,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of Post
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get author {
  
  return $UserCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// @nodoc
mixin _$Reel {

 String? get id; FeedType get feedType; String? get title; String? get subTitle; AppFile get videoUrl; User get author; DateTime get created; DateTime get updated;
/// Create a copy of Reel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReelCopyWith<Reel> get copyWith => _$ReelCopyWithImpl<Reel>(this as Reel, _$identity);

  /// Serializes this Reel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Reel&&(identical(other.id, id) || other.id == id)&&(identical(other.feedType, feedType) || other.feedType == feedType)&&(identical(other.title, title) || other.title == title)&&(identical(other.subTitle, subTitle) || other.subTitle == subTitle)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.author, author) || other.author == author)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,feedType,title,subTitle,videoUrl,author,created,updated);

@override
String toString() {
  return 'Reel(id: $id, feedType: $feedType, title: $title, subTitle: $subTitle, videoUrl: $videoUrl, author: $author, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class $ReelCopyWith<$Res>  {
  factory $ReelCopyWith(Reel value, $Res Function(Reel) _then) = _$ReelCopyWithImpl;
@useResult
$Res call({
 String? id, FeedType feedType, String? title, String? subTitle, AppFile videoUrl, User author, DateTime created, DateTime updated
});


$AppFileCopyWith<$Res> get videoUrl;$UserCopyWith<$Res> get author;

}
/// @nodoc
class _$ReelCopyWithImpl<$Res>
    implements $ReelCopyWith<$Res> {
  _$ReelCopyWithImpl(this._self, this._then);

  final Reel _self;
  final $Res Function(Reel) _then;

/// Create a copy of Reel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? feedType = null,Object? title = freezed,Object? subTitle = freezed,Object? videoUrl = null,Object? author = null,Object? created = null,Object? updated = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,feedType: null == feedType ? _self.feedType : feedType // ignore: cast_nullable_to_non_nullable
as FeedType,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,subTitle: freezed == subTitle ? _self.subTitle : subTitle // ignore: cast_nullable_to_non_nullable
as String?,videoUrl: null == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as AppFile,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as User,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of Reel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppFileCopyWith<$Res> get videoUrl {
  
  return $AppFileCopyWith<$Res>(_self.videoUrl, (value) {
    return _then(_self.copyWith(videoUrl: value));
  });
}/// Create a copy of Reel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get author {
  
  return $UserCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}


/// Adds pattern-matching-related methods to [Reel].
extension ReelPatterns on Reel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Reel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Reel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Reel value)  $default,){
final _that = this;
switch (_that) {
case _Reel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Reel value)?  $default,){
final _that = this;
switch (_that) {
case _Reel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  FeedType feedType,  String? title,  String? subTitle,  AppFile videoUrl,  User author,  DateTime created,  DateTime updated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Reel() when $default != null:
return $default(_that.id,_that.feedType,_that.title,_that.subTitle,_that.videoUrl,_that.author,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  FeedType feedType,  String? title,  String? subTitle,  AppFile videoUrl,  User author,  DateTime created,  DateTime updated)  $default,) {final _that = this;
switch (_that) {
case _Reel():
return $default(_that.id,_that.feedType,_that.title,_that.subTitle,_that.videoUrl,_that.author,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  FeedType feedType,  String? title,  String? subTitle,  AppFile videoUrl,  User author,  DateTime created,  DateTime updated)?  $default,) {final _that = this;
switch (_that) {
case _Reel() when $default != null:
return $default(_that.id,_that.feedType,_that.title,_that.subTitle,_that.videoUrl,_that.author,_that.created,_that.updated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Reel implements Reel {
  const _Reel({this.id, required this.feedType, this.title, this.subTitle, required this.videoUrl, required this.author, required this.created, required this.updated});
  factory _Reel.fromJson(Map<String, dynamic> json) => _$ReelFromJson(json);

@override final  String? id;
@override final  FeedType feedType;
@override final  String? title;
@override final  String? subTitle;
@override final  AppFile videoUrl;
@override final  User author;
@override final  DateTime created;
@override final  DateTime updated;

/// Create a copy of Reel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReelCopyWith<_Reel> get copyWith => __$ReelCopyWithImpl<_Reel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reel&&(identical(other.id, id) || other.id == id)&&(identical(other.feedType, feedType) || other.feedType == feedType)&&(identical(other.title, title) || other.title == title)&&(identical(other.subTitle, subTitle) || other.subTitle == subTitle)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.author, author) || other.author == author)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,feedType,title,subTitle,videoUrl,author,created,updated);

@override
String toString() {
  return 'Reel(id: $id, feedType: $feedType, title: $title, subTitle: $subTitle, videoUrl: $videoUrl, author: $author, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class _$ReelCopyWith<$Res> implements $ReelCopyWith<$Res> {
  factory _$ReelCopyWith(_Reel value, $Res Function(_Reel) _then) = __$ReelCopyWithImpl;
@override @useResult
$Res call({
 String? id, FeedType feedType, String? title, String? subTitle, AppFile videoUrl, User author, DateTime created, DateTime updated
});


@override $AppFileCopyWith<$Res> get videoUrl;@override $UserCopyWith<$Res> get author;

}
/// @nodoc
class __$ReelCopyWithImpl<$Res>
    implements _$ReelCopyWith<$Res> {
  __$ReelCopyWithImpl(this._self, this._then);

  final _Reel _self;
  final $Res Function(_Reel) _then;

/// Create a copy of Reel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? feedType = null,Object? title = freezed,Object? subTitle = freezed,Object? videoUrl = null,Object? author = null,Object? created = null,Object? updated = null,}) {
  return _then(_Reel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,feedType: null == feedType ? _self.feedType : feedType // ignore: cast_nullable_to_non_nullable
as FeedType,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,subTitle: freezed == subTitle ? _self.subTitle : subTitle // ignore: cast_nullable_to_non_nullable
as String?,videoUrl: null == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as AppFile,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as User,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of Reel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AppFileCopyWith<$Res> get videoUrl {
  
  return $AppFileCopyWith<$Res>(_self.videoUrl, (value) {
    return _then(_self.copyWith(videoUrl: value));
  });
}/// Create a copy of Reel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserCopyWith<$Res> get author {
  
  return $UserCopyWith<$Res>(_self.author, (value) {
    return _then(_self.copyWith(author: value));
  });
}
}

/// @nodoc
mixin _$FeedActivity {

 String? get id; String? get title; String? get body; String get feedRel; RelationType get relationType; FeedType get feedType; List<String> get mediaUrls; DateTime get orderTime;
/// Create a copy of FeedActivity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedActivityCopyWith<FeedActivity> get copyWith => _$FeedActivityCopyWithImpl<FeedActivity>(this as FeedActivity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedActivity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.feedRel, feedRel) || other.feedRel == feedRel)&&(identical(other.relationType, relationType) || other.relationType == relationType)&&(identical(other.feedType, feedType) || other.feedType == feedType)&&const DeepCollectionEquality().equals(other.mediaUrls, mediaUrls)&&(identical(other.orderTime, orderTime) || other.orderTime == orderTime));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,body,feedRel,relationType,feedType,const DeepCollectionEquality().hash(mediaUrls),orderTime);

@override
String toString() {
  return 'FeedActivity(id: $id, title: $title, body: $body, feedRel: $feedRel, relationType: $relationType, feedType: $feedType, mediaUrls: $mediaUrls, orderTime: $orderTime)';
}


}

/// @nodoc
abstract mixin class $FeedActivityCopyWith<$Res>  {
  factory $FeedActivityCopyWith(FeedActivity value, $Res Function(FeedActivity) _then) = _$FeedActivityCopyWithImpl;
@useResult
$Res call({
 String? id, String? title, String? body, String feedRel, RelationType relationType, FeedType feedType, List<String> mediaUrls, DateTime orderTime
});




}
/// @nodoc
class _$FeedActivityCopyWithImpl<$Res>
    implements $FeedActivityCopyWith<$Res> {
  _$FeedActivityCopyWithImpl(this._self, this._then);

  final FeedActivity _self;
  final $Res Function(FeedActivity) _then;

/// Create a copy of FeedActivity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = freezed,Object? body = freezed,Object? feedRel = null,Object? relationType = null,Object? feedType = null,Object? mediaUrls = null,Object? orderTime = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,feedRel: null == feedRel ? _self.feedRel : feedRel // ignore: cast_nullable_to_non_nullable
as String,relationType: null == relationType ? _self.relationType : relationType // ignore: cast_nullable_to_non_nullable
as RelationType,feedType: null == feedType ? _self.feedType : feedType // ignore: cast_nullable_to_non_nullable
as FeedType,mediaUrls: null == mediaUrls ? _self.mediaUrls : mediaUrls // ignore: cast_nullable_to_non_nullable
as List<String>,orderTime: null == orderTime ? _self.orderTime : orderTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedActivity].
extension FeedActivityPatterns on FeedActivity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedActivity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedActivity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedActivity value)  $default,){
final _that = this;
switch (_that) {
case _FeedActivity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedActivity value)?  $default,){
final _that = this;
switch (_that) {
case _FeedActivity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? title,  String? body,  String feedRel,  RelationType relationType,  FeedType feedType,  List<String> mediaUrls,  DateTime orderTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedActivity() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.feedRel,_that.relationType,_that.feedType,_that.mediaUrls,_that.orderTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? title,  String? body,  String feedRel,  RelationType relationType,  FeedType feedType,  List<String> mediaUrls,  DateTime orderTime)  $default,) {final _that = this;
switch (_that) {
case _FeedActivity():
return $default(_that.id,_that.title,_that.body,_that.feedRel,_that.relationType,_that.feedType,_that.mediaUrls,_that.orderTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? title,  String? body,  String feedRel,  RelationType relationType,  FeedType feedType,  List<String> mediaUrls,  DateTime orderTime)?  $default,) {final _that = this;
switch (_that) {
case _FeedActivity() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.feedRel,_that.relationType,_that.feedType,_that.mediaUrls,_that.orderTime);case _:
  return null;

}
}

}

/// @nodoc


class _FeedActivity implements FeedActivity {
  const _FeedActivity({this.id, this.title, this.body, required this.feedRel, required this.relationType, required this.feedType, final  List<String> mediaUrls = const [], required this.orderTime}): _mediaUrls = mediaUrls;
  

@override final  String? id;
@override final  String? title;
@override final  String? body;
@override final  String feedRel;
@override final  RelationType relationType;
@override final  FeedType feedType;
 final  List<String> _mediaUrls;
@override@JsonKey() List<String> get mediaUrls {
  if (_mediaUrls is EqualUnmodifiableListView) return _mediaUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_mediaUrls);
}

@override final  DateTime orderTime;

/// Create a copy of FeedActivity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedActivityCopyWith<_FeedActivity> get copyWith => __$FeedActivityCopyWithImpl<_FeedActivity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedActivity&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.feedRel, feedRel) || other.feedRel == feedRel)&&(identical(other.relationType, relationType) || other.relationType == relationType)&&(identical(other.feedType, feedType) || other.feedType == feedType)&&const DeepCollectionEquality().equals(other._mediaUrls, _mediaUrls)&&(identical(other.orderTime, orderTime) || other.orderTime == orderTime));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,body,feedRel,relationType,feedType,const DeepCollectionEquality().hash(_mediaUrls),orderTime);

@override
String toString() {
  return 'FeedActivity(id: $id, title: $title, body: $body, feedRel: $feedRel, relationType: $relationType, feedType: $feedType, mediaUrls: $mediaUrls, orderTime: $orderTime)';
}


}

/// @nodoc
abstract mixin class _$FeedActivityCopyWith<$Res> implements $FeedActivityCopyWith<$Res> {
  factory _$FeedActivityCopyWith(_FeedActivity value, $Res Function(_FeedActivity) _then) = __$FeedActivityCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? title, String? body, String feedRel, RelationType relationType, FeedType feedType, List<String> mediaUrls, DateTime orderTime
});




}
/// @nodoc
class __$FeedActivityCopyWithImpl<$Res>
    implements _$FeedActivityCopyWith<$Res> {
  __$FeedActivityCopyWithImpl(this._self, this._then);

  final _FeedActivity _self;
  final $Res Function(_FeedActivity) _then;

/// Create a copy of FeedActivity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = freezed,Object? body = freezed,Object? feedRel = null,Object? relationType = null,Object? feedType = null,Object? mediaUrls = null,Object? orderTime = null,}) {
  return _then(_FeedActivity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,feedRel: null == feedRel ? _self.feedRel : feedRel // ignore: cast_nullable_to_non_nullable
as String,relationType: null == relationType ? _self.relationType : relationType // ignore: cast_nullable_to_non_nullable
as RelationType,feedType: null == feedType ? _self.feedType : feedType // ignore: cast_nullable_to_non_nullable
as FeedType,mediaUrls: null == mediaUrls ? _self._mediaUrls : mediaUrls // ignore: cast_nullable_to_non_nullable
as List<String>,orderTime: null == orderTime ? _self.orderTime : orderTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
