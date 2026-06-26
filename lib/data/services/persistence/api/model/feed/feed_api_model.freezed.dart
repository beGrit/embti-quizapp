// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PostApiModel {

 String get id; String get author; String get feedType; String get title; String? get body; List<String> get tags; List<Map<String, dynamic>> get photos; DateTime get created; DateTime get updated;
/// Create a copy of PostApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostApiModelCopyWith<PostApiModel> get copyWith => _$PostApiModelCopyWithImpl<PostApiModel>(this as PostApiModel, _$identity);

  /// Serializes this PostApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&(identical(other.feedType, feedType) || other.feedType == feedType)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.photos, photos)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,author,feedType,title,body,const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(photos),created,updated);

@override
String toString() {
  return 'PostApiModel(id: $id, author: $author, feedType: $feedType, title: $title, body: $body, tags: $tags, photos: $photos, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class $PostApiModelCopyWith<$Res>  {
  factory $PostApiModelCopyWith(PostApiModel value, $Res Function(PostApiModel) _then) = _$PostApiModelCopyWithImpl;
@useResult
$Res call({
 String id, String author, String feedType, String title, String? body, List<String> tags, List<Map<String, dynamic>> photos, DateTime created, DateTime updated
});




}
/// @nodoc
class _$PostApiModelCopyWithImpl<$Res>
    implements $PostApiModelCopyWith<$Res> {
  _$PostApiModelCopyWithImpl(this._self, this._then);

  final PostApiModel _self;
  final $Res Function(PostApiModel) _then;

/// Create a copy of PostApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? author = null,Object? feedType = null,Object? title = null,Object? body = freezed,Object? tags = null,Object? photos = null,Object? created = null,Object? updated = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,feedType: null == feedType ? _self.feedType : feedType // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PostApiModel].
extension PostApiModelPatterns on PostApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PostApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PostApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PostApiModel value)  $default,){
final _that = this;
switch (_that) {
case _PostApiModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PostApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _PostApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String author,  String feedType,  String title,  String? body,  List<String> tags,  List<Map<String, dynamic>> photos,  DateTime created,  DateTime updated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostApiModel() when $default != null:
return $default(_that.id,_that.author,_that.feedType,_that.title,_that.body,_that.tags,_that.photos,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String author,  String feedType,  String title,  String? body,  List<String> tags,  List<Map<String, dynamic>> photos,  DateTime created,  DateTime updated)  $default,) {final _that = this;
switch (_that) {
case _PostApiModel():
return $default(_that.id,_that.author,_that.feedType,_that.title,_that.body,_that.tags,_that.photos,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String author,  String feedType,  String title,  String? body,  List<String> tags,  List<Map<String, dynamic>> photos,  DateTime created,  DateTime updated)?  $default,) {final _that = this;
switch (_that) {
case _PostApiModel() when $default != null:
return $default(_that.id,_that.author,_that.feedType,_that.title,_that.body,_that.tags,_that.photos,_that.created,_that.updated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostApiModel implements PostApiModel {
  const _PostApiModel({required this.id, required this.author, required this.feedType, required this.title, this.body, final  List<String> tags = const [], final  List<Map<String, dynamic>> photos = const [], required this.created, required this.updated}): _tags = tags,_photos = photos;
  factory _PostApiModel.fromJson(Map<String, dynamic> json) => _$PostApiModelFromJson(json);

@override final  String id;
@override final  String author;
@override final  String feedType;
@override final  String title;
@override final  String? body;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

 final  List<Map<String, dynamic>> _photos;
@override@JsonKey() List<Map<String, dynamic>> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}

@override final  DateTime created;
@override final  DateTime updated;

/// Create a copy of PostApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PostApiModelCopyWith<_PostApiModel> get copyWith => __$PostApiModelCopyWithImpl<_PostApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PostApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&(identical(other.feedType, feedType) || other.feedType == feedType)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&const DeepCollectionEquality().equals(other._tags, _tags)&&const DeepCollectionEquality().equals(other._photos, _photos)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,author,feedType,title,body,const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_photos),created,updated);

@override
String toString() {
  return 'PostApiModel(id: $id, author: $author, feedType: $feedType, title: $title, body: $body, tags: $tags, photos: $photos, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class _$PostApiModelCopyWith<$Res> implements $PostApiModelCopyWith<$Res> {
  factory _$PostApiModelCopyWith(_PostApiModel value, $Res Function(_PostApiModel) _then) = __$PostApiModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String author, String feedType, String title, String? body, List<String> tags, List<Map<String, dynamic>> photos, DateTime created, DateTime updated
});




}
/// @nodoc
class __$PostApiModelCopyWithImpl<$Res>
    implements _$PostApiModelCopyWith<$Res> {
  __$PostApiModelCopyWithImpl(this._self, this._then);

  final _PostApiModel _self;
  final $Res Function(_PostApiModel) _then;

/// Create a copy of PostApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? author = null,Object? feedType = null,Object? title = null,Object? body = freezed,Object? tags = null,Object? photos = null,Object? created = null,Object? updated = null,}) {
  return _then(_PostApiModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,feedType: null == feedType ? _self.feedType : feedType // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$ReelApiModel {

 String get id; String get author; String get feedType; String? get title; String? get subTitle; Map<String, dynamic> get video; DateTime get created; DateTime get updated;
/// Create a copy of ReelApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReelApiModelCopyWith<ReelApiModel> get copyWith => _$ReelApiModelCopyWithImpl<ReelApiModel>(this as ReelApiModel, _$identity);

  /// Serializes this ReelApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReelApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&(identical(other.feedType, feedType) || other.feedType == feedType)&&(identical(other.title, title) || other.title == title)&&(identical(other.subTitle, subTitle) || other.subTitle == subTitle)&&const DeepCollectionEquality().equals(other.video, video)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,author,feedType,title,subTitle,const DeepCollectionEquality().hash(video),created,updated);

@override
String toString() {
  return 'ReelApiModel(id: $id, author: $author, feedType: $feedType, title: $title, subTitle: $subTitle, video: $video, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class $ReelApiModelCopyWith<$Res>  {
  factory $ReelApiModelCopyWith(ReelApiModel value, $Res Function(ReelApiModel) _then) = _$ReelApiModelCopyWithImpl;
@useResult
$Res call({
 String id, String author, String feedType, String? title, String? subTitle, Map<String, dynamic> video, DateTime created, DateTime updated
});




}
/// @nodoc
class _$ReelApiModelCopyWithImpl<$Res>
    implements $ReelApiModelCopyWith<$Res> {
  _$ReelApiModelCopyWithImpl(this._self, this._then);

  final ReelApiModel _self;
  final $Res Function(ReelApiModel) _then;

/// Create a copy of ReelApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? author = null,Object? feedType = null,Object? title = freezed,Object? subTitle = freezed,Object? video = null,Object? created = null,Object? updated = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,feedType: null == feedType ? _self.feedType : feedType // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,subTitle: freezed == subTitle ? _self.subTitle : subTitle // ignore: cast_nullable_to_non_nullable
as String?,video: null == video ? _self.video : video // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ReelApiModel].
extension ReelApiModelPatterns on ReelApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReelApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReelApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReelApiModel value)  $default,){
final _that = this;
switch (_that) {
case _ReelApiModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReelApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _ReelApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String author,  String feedType,  String? title,  String? subTitle,  Map<String, dynamic> video,  DateTime created,  DateTime updated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReelApiModel() when $default != null:
return $default(_that.id,_that.author,_that.feedType,_that.title,_that.subTitle,_that.video,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String author,  String feedType,  String? title,  String? subTitle,  Map<String, dynamic> video,  DateTime created,  DateTime updated)  $default,) {final _that = this;
switch (_that) {
case _ReelApiModel():
return $default(_that.id,_that.author,_that.feedType,_that.title,_that.subTitle,_that.video,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String author,  String feedType,  String? title,  String? subTitle,  Map<String, dynamic> video,  DateTime created,  DateTime updated)?  $default,) {final _that = this;
switch (_that) {
case _ReelApiModel() when $default != null:
return $default(_that.id,_that.author,_that.feedType,_that.title,_that.subTitle,_that.video,_that.created,_that.updated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReelApiModel implements ReelApiModel {
  const _ReelApiModel({required this.id, required this.author, required this.feedType, this.title, this.subTitle, required final  Map<String, dynamic> video, required this.created, required this.updated}): _video = video;
  factory _ReelApiModel.fromJson(Map<String, dynamic> json) => _$ReelApiModelFromJson(json);

@override final  String id;
@override final  String author;
@override final  String feedType;
@override final  String? title;
@override final  String? subTitle;
 final  Map<String, dynamic> _video;
@override Map<String, dynamic> get video {
  if (_video is EqualUnmodifiableMapView) return _video;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_video);
}

@override final  DateTime created;
@override final  DateTime updated;

/// Create a copy of ReelApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReelApiModelCopyWith<_ReelApiModel> get copyWith => __$ReelApiModelCopyWithImpl<_ReelApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReelApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReelApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.author, author) || other.author == author)&&(identical(other.feedType, feedType) || other.feedType == feedType)&&(identical(other.title, title) || other.title == title)&&(identical(other.subTitle, subTitle) || other.subTitle == subTitle)&&const DeepCollectionEquality().equals(other._video, _video)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,author,feedType,title,subTitle,const DeepCollectionEquality().hash(_video),created,updated);

@override
String toString() {
  return 'ReelApiModel(id: $id, author: $author, feedType: $feedType, title: $title, subTitle: $subTitle, video: $video, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class _$ReelApiModelCopyWith<$Res> implements $ReelApiModelCopyWith<$Res> {
  factory _$ReelApiModelCopyWith(_ReelApiModel value, $Res Function(_ReelApiModel) _then) = __$ReelApiModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String author, String feedType, String? title, String? subTitle, Map<String, dynamic> video, DateTime created, DateTime updated
});




}
/// @nodoc
class __$ReelApiModelCopyWithImpl<$Res>
    implements _$ReelApiModelCopyWith<$Res> {
  __$ReelApiModelCopyWithImpl(this._self, this._then);

  final _ReelApiModel _self;
  final $Res Function(_ReelApiModel) _then;

/// Create a copy of ReelApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? author = null,Object? feedType = null,Object? title = freezed,Object? subTitle = freezed,Object? video = null,Object? created = null,Object? updated = null,}) {
  return _then(_ReelApiModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,feedType: null == feedType ? _self.feedType : feedType // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,subTitle: freezed == subTitle ? _self.subTitle : subTitle // ignore: cast_nullable_to_non_nullable
as String?,video: null == video ? _self._video : video // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$FeedActivityApiModel {

 String get id; String? get title; String? get body; String get feedRel; String get relationType; String get feedType; List<Map<String, dynamic>> get medias; DateTime get orderTime;
/// Create a copy of FeedActivityApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FeedActivityApiModelCopyWith<FeedActivityApiModel> get copyWith => _$FeedActivityApiModelCopyWithImpl<FeedActivityApiModel>(this as FeedActivityApiModel, _$identity);

  /// Serializes this FeedActivityApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FeedActivityApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.feedRel, feedRel) || other.feedRel == feedRel)&&(identical(other.relationType, relationType) || other.relationType == relationType)&&(identical(other.feedType, feedType) || other.feedType == feedType)&&const DeepCollectionEquality().equals(other.medias, medias)&&(identical(other.orderTime, orderTime) || other.orderTime == orderTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,feedRel,relationType,feedType,const DeepCollectionEquality().hash(medias),orderTime);

@override
String toString() {
  return 'FeedActivityApiModel(id: $id, title: $title, body: $body, feedRel: $feedRel, relationType: $relationType, feedType: $feedType, medias: $medias, orderTime: $orderTime)';
}


}

/// @nodoc
abstract mixin class $FeedActivityApiModelCopyWith<$Res>  {
  factory $FeedActivityApiModelCopyWith(FeedActivityApiModel value, $Res Function(FeedActivityApiModel) _then) = _$FeedActivityApiModelCopyWithImpl;
@useResult
$Res call({
 String id, String? title, String? body, String feedRel, String relationType, String feedType, List<Map<String, dynamic>> medias, DateTime orderTime
});




}
/// @nodoc
class _$FeedActivityApiModelCopyWithImpl<$Res>
    implements $FeedActivityApiModelCopyWith<$Res> {
  _$FeedActivityApiModelCopyWithImpl(this._self, this._then);

  final FeedActivityApiModel _self;
  final $Res Function(FeedActivityApiModel) _then;

/// Create a copy of FeedActivityApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = freezed,Object? body = freezed,Object? feedRel = null,Object? relationType = null,Object? feedType = null,Object? medias = null,Object? orderTime = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,feedRel: null == feedRel ? _self.feedRel : feedRel // ignore: cast_nullable_to_non_nullable
as String,relationType: null == relationType ? _self.relationType : relationType // ignore: cast_nullable_to_non_nullable
as String,feedType: null == feedType ? _self.feedType : feedType // ignore: cast_nullable_to_non_nullable
as String,medias: null == medias ? _self.medias : medias // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,orderTime: null == orderTime ? _self.orderTime : orderTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [FeedActivityApiModel].
extension FeedActivityApiModelPatterns on FeedActivityApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FeedActivityApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FeedActivityApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FeedActivityApiModel value)  $default,){
final _that = this;
switch (_that) {
case _FeedActivityApiModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FeedActivityApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _FeedActivityApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? title,  String? body,  String feedRel,  String relationType,  String feedType,  List<Map<String, dynamic>> medias,  DateTime orderTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FeedActivityApiModel() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.feedRel,_that.relationType,_that.feedType,_that.medias,_that.orderTime);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? title,  String? body,  String feedRel,  String relationType,  String feedType,  List<Map<String, dynamic>> medias,  DateTime orderTime)  $default,) {final _that = this;
switch (_that) {
case _FeedActivityApiModel():
return $default(_that.id,_that.title,_that.body,_that.feedRel,_that.relationType,_that.feedType,_that.medias,_that.orderTime);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? title,  String? body,  String feedRel,  String relationType,  String feedType,  List<Map<String, dynamic>> medias,  DateTime orderTime)?  $default,) {final _that = this;
switch (_that) {
case _FeedActivityApiModel() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.feedRel,_that.relationType,_that.feedType,_that.medias,_that.orderTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FeedActivityApiModel implements FeedActivityApiModel {
  const _FeedActivityApiModel({required this.id, this.title, this.body, required this.feedRel, required this.relationType, required this.feedType, final  List<Map<String, dynamic>> medias = const [], required this.orderTime}): _medias = medias;
  factory _FeedActivityApiModel.fromJson(Map<String, dynamic> json) => _$FeedActivityApiModelFromJson(json);

@override final  String id;
@override final  String? title;
@override final  String? body;
@override final  String feedRel;
@override final  String relationType;
@override final  String feedType;
 final  List<Map<String, dynamic>> _medias;
@override@JsonKey() List<Map<String, dynamic>> get medias {
  if (_medias is EqualUnmodifiableListView) return _medias;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_medias);
}

@override final  DateTime orderTime;

/// Create a copy of FeedActivityApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FeedActivityApiModelCopyWith<_FeedActivityApiModel> get copyWith => __$FeedActivityApiModelCopyWithImpl<_FeedActivityApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FeedActivityApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FeedActivityApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.feedRel, feedRel) || other.feedRel == feedRel)&&(identical(other.relationType, relationType) || other.relationType == relationType)&&(identical(other.feedType, feedType) || other.feedType == feedType)&&const DeepCollectionEquality().equals(other._medias, _medias)&&(identical(other.orderTime, orderTime) || other.orderTime == orderTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,feedRel,relationType,feedType,const DeepCollectionEquality().hash(_medias),orderTime);

@override
String toString() {
  return 'FeedActivityApiModel(id: $id, title: $title, body: $body, feedRel: $feedRel, relationType: $relationType, feedType: $feedType, medias: $medias, orderTime: $orderTime)';
}


}

/// @nodoc
abstract mixin class _$FeedActivityApiModelCopyWith<$Res> implements $FeedActivityApiModelCopyWith<$Res> {
  factory _$FeedActivityApiModelCopyWith(_FeedActivityApiModel value, $Res Function(_FeedActivityApiModel) _then) = __$FeedActivityApiModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String? title, String? body, String feedRel, String relationType, String feedType, List<Map<String, dynamic>> medias, DateTime orderTime
});




}
/// @nodoc
class __$FeedActivityApiModelCopyWithImpl<$Res>
    implements _$FeedActivityApiModelCopyWith<$Res> {
  __$FeedActivityApiModelCopyWithImpl(this._self, this._then);

  final _FeedActivityApiModel _self;
  final $Res Function(_FeedActivityApiModel) _then;

/// Create a copy of FeedActivityApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = freezed,Object? body = freezed,Object? feedRel = null,Object? relationType = null,Object? feedType = null,Object? medias = null,Object? orderTime = null,}) {
  return _then(_FeedActivityApiModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,feedRel: null == feedRel ? _self.feedRel : feedRel // ignore: cast_nullable_to_non_nullable
as String,relationType: null == relationType ? _self.relationType : relationType // ignore: cast_nullable_to_non_nullable
as String,feedType: null == feedType ? _self.feedType : feedType // ignore: cast_nullable_to_non_nullable
as String,medias: null == medias ? _self._medias : medias // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,orderTime: null == orderTime ? _self.orderTime : orderTime // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
