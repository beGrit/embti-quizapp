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

 String get id; String get title; String get collectionId; String get collectionName; String? get body; Map<String, dynamic> get author; List<String> get tags; List<String> get photos; DateTime get created; DateTime get updated;
/// Create a copy of PostApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PostApiModelCopyWith<PostApiModel> get copyWith => _$PostApiModelCopyWithImpl<PostApiModel>(this as PostApiModel, _$identity);

  /// Serializes this PostApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PostApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.collectionId, collectionId) || other.collectionId == collectionId)&&(identical(other.collectionName, collectionName) || other.collectionName == collectionName)&&(identical(other.body, body) || other.body == body)&&const DeepCollectionEquality().equals(other.author, author)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.photos, photos)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,collectionId,collectionName,body,const DeepCollectionEquality().hash(author),const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(photos),created,updated);

@override
String toString() {
  return 'PostApiModel(id: $id, title: $title, collectionId: $collectionId, collectionName: $collectionName, body: $body, author: $author, tags: $tags, photos: $photos, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class $PostApiModelCopyWith<$Res>  {
  factory $PostApiModelCopyWith(PostApiModel value, $Res Function(PostApiModel) _then) = _$PostApiModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String collectionId, String collectionName, String? body, Map<String, dynamic> author, List<String> tags, List<String> photos, DateTime created, DateTime updated
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? collectionId = null,Object? collectionName = null,Object? body = freezed,Object? author = null,Object? tags = null,Object? photos = null,Object? created = null,Object? updated = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,collectionId: null == collectionId ? _self.collectionId : collectionId // ignore: cast_nullable_to_non_nullable
as String,collectionName: null == collectionName ? _self.collectionName : collectionName // ignore: cast_nullable_to_non_nullable
as String,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<String>,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String collectionId,  String collectionName,  String? body,  Map<String, dynamic> author,  List<String> tags,  List<String> photos,  DateTime created,  DateTime updated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PostApiModel() when $default != null:
return $default(_that.id,_that.title,_that.collectionId,_that.collectionName,_that.body,_that.author,_that.tags,_that.photos,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String collectionId,  String collectionName,  String? body,  Map<String, dynamic> author,  List<String> tags,  List<String> photos,  DateTime created,  DateTime updated)  $default,) {final _that = this;
switch (_that) {
case _PostApiModel():
return $default(_that.id,_that.title,_that.collectionId,_that.collectionName,_that.body,_that.author,_that.tags,_that.photos,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String collectionId,  String collectionName,  String? body,  Map<String, dynamic> author,  List<String> tags,  List<String> photos,  DateTime created,  DateTime updated)?  $default,) {final _that = this;
switch (_that) {
case _PostApiModel() when $default != null:
return $default(_that.id,_that.title,_that.collectionId,_that.collectionName,_that.body,_that.author,_that.tags,_that.photos,_that.created,_that.updated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PostApiModel implements PostApiModel {
  const _PostApiModel({required this.id, required this.title, required this.collectionId, required this.collectionName, this.body, required final  Map<String, dynamic> author, final  List<String> tags = const [], final  List<String> photos = const [], required this.created, required this.updated}): _author = author,_tags = tags,_photos = photos;
  factory _PostApiModel.fromJson(Map<String, dynamic> json) => _$PostApiModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String collectionId;
@override final  String collectionName;
@override final  String? body;
 final  Map<String, dynamic> _author;
@override Map<String, dynamic> get author {
  if (_author is EqualUnmodifiableMapView) return _author;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_author);
}

 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

 final  List<String> _photos;
@override@JsonKey() List<String> get photos {
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PostApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.collectionId, collectionId) || other.collectionId == collectionId)&&(identical(other.collectionName, collectionName) || other.collectionName == collectionName)&&(identical(other.body, body) || other.body == body)&&const DeepCollectionEquality().equals(other._author, _author)&&const DeepCollectionEquality().equals(other._tags, _tags)&&const DeepCollectionEquality().equals(other._photos, _photos)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,collectionId,collectionName,body,const DeepCollectionEquality().hash(_author),const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_photos),created,updated);

@override
String toString() {
  return 'PostApiModel(id: $id, title: $title, collectionId: $collectionId, collectionName: $collectionName, body: $body, author: $author, tags: $tags, photos: $photos, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class _$PostApiModelCopyWith<$Res> implements $PostApiModelCopyWith<$Res> {
  factory _$PostApiModelCopyWith(_PostApiModel value, $Res Function(_PostApiModel) _then) = __$PostApiModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String collectionId, String collectionName, String? body, Map<String, dynamic> author, List<String> tags, List<String> photos, DateTime created, DateTime updated
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? collectionId = null,Object? collectionName = null,Object? body = freezed,Object? author = null,Object? tags = null,Object? photos = null,Object? created = null,Object? updated = null,}) {
  return _then(_PostApiModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,collectionId: null == collectionId ? _self.collectionId : collectionId // ignore: cast_nullable_to_non_nullable
as String,collectionName: null == collectionName ? _self.collectionName : collectionName // ignore: cast_nullable_to_non_nullable
as String,body: freezed == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String?,author: null == author ? _self._author : author // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<String>,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
