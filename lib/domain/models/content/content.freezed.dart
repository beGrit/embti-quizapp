// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
Content _$ContentFromJson(
  Map<String, dynamic> json
) {
        switch (json['type']) {
                  case 'article':
          return ArticleContent.fromJson(
            json
          );
                case 'video':
          return VideoContent.fromJson(
            json
          );
                case 'knowledge':
          return KnowledgeContent.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'type',
  'Content',
  'Invalid union type "${json['type']}"!'
);
        }
      
}

/// @nodoc
mixin _$Content {

 String get id; String get authorName; String get authorMbti; DateTime get createdAt;
/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContentCopyWith<Content> get copyWith => _$ContentCopyWithImpl<Content>(this as Content, _$identity);

  /// Serializes this Content to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Content&&(identical(other.id, id) || other.id == id)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorMbti, authorMbti) || other.authorMbti == authorMbti)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorName,authorMbti,createdAt);

@override
String toString() {
  return 'Content(id: $id, authorName: $authorName, authorMbti: $authorMbti, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ContentCopyWith<$Res>  {
  factory $ContentCopyWith(Content value, $Res Function(Content) _then) = _$ContentCopyWithImpl;
@useResult
$Res call({
 String id, String authorName, String authorMbti, DateTime createdAt
});




}
/// @nodoc
class _$ContentCopyWithImpl<$Res>
    implements $ContentCopyWith<$Res> {
  _$ContentCopyWithImpl(this._self, this._then);

  final Content _self;
  final $Res Function(Content) _then;

/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? authorName = null,Object? authorMbti = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,authorMbti: null == authorMbti ? _self.authorMbti : authorMbti // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Content].
extension ContentPatterns on Content {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ArticleContent value)?  article,TResult Function( VideoContent value)?  video,TResult Function( KnowledgeContent value)?  knowledge,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ArticleContent() when article != null:
return article(_that);case VideoContent() when video != null:
return video(_that);case KnowledgeContent() when knowledge != null:
return knowledge(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ArticleContent value)  article,required TResult Function( VideoContent value)  video,required TResult Function( KnowledgeContent value)  knowledge,}){
final _that = this;
switch (_that) {
case ArticleContent():
return article(_that);case VideoContent():
return video(_that);case KnowledgeContent():
return knowledge(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ArticleContent value)?  article,TResult? Function( VideoContent value)?  video,TResult? Function( KnowledgeContent value)?  knowledge,}){
final _that = this;
switch (_that) {
case ArticleContent() when article != null:
return article(_that);case VideoContent() when video != null:
return video(_that);case KnowledgeContent() when knowledge != null:
return knowledge(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String id,  String authorName,  String authorMbti,  DateTime createdAt,  String title,  String summary,  String thumbnailUrl)?  article,TResult Function( String id,  String authorName,  String authorMbti,  DateTime createdAt,  String videoUrl,  bool isShortForm,  int? matchScore)?  video,TResult Function( String id,  String authorName,  String authorMbti,  DateTime createdAt,  String title,  String category,  String iconPath)?  knowledge,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ArticleContent() when article != null:
return article(_that.id,_that.authorName,_that.authorMbti,_that.createdAt,_that.title,_that.summary,_that.thumbnailUrl);case VideoContent() when video != null:
return video(_that.id,_that.authorName,_that.authorMbti,_that.createdAt,_that.videoUrl,_that.isShortForm,_that.matchScore);case KnowledgeContent() when knowledge != null:
return knowledge(_that.id,_that.authorName,_that.authorMbti,_that.createdAt,_that.title,_that.category,_that.iconPath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String id,  String authorName,  String authorMbti,  DateTime createdAt,  String title,  String summary,  String thumbnailUrl)  article,required TResult Function( String id,  String authorName,  String authorMbti,  DateTime createdAt,  String videoUrl,  bool isShortForm,  int? matchScore)  video,required TResult Function( String id,  String authorName,  String authorMbti,  DateTime createdAt,  String title,  String category,  String iconPath)  knowledge,}) {final _that = this;
switch (_that) {
case ArticleContent():
return article(_that.id,_that.authorName,_that.authorMbti,_that.createdAt,_that.title,_that.summary,_that.thumbnailUrl);case VideoContent():
return video(_that.id,_that.authorName,_that.authorMbti,_that.createdAt,_that.videoUrl,_that.isShortForm,_that.matchScore);case KnowledgeContent():
return knowledge(_that.id,_that.authorName,_that.authorMbti,_that.createdAt,_that.title,_that.category,_that.iconPath);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String id,  String authorName,  String authorMbti,  DateTime createdAt,  String title,  String summary,  String thumbnailUrl)?  article,TResult? Function( String id,  String authorName,  String authorMbti,  DateTime createdAt,  String videoUrl,  bool isShortForm,  int? matchScore)?  video,TResult? Function( String id,  String authorName,  String authorMbti,  DateTime createdAt,  String title,  String category,  String iconPath)?  knowledge,}) {final _that = this;
switch (_that) {
case ArticleContent() when article != null:
return article(_that.id,_that.authorName,_that.authorMbti,_that.createdAt,_that.title,_that.summary,_that.thumbnailUrl);case VideoContent() when video != null:
return video(_that.id,_that.authorName,_that.authorMbti,_that.createdAt,_that.videoUrl,_that.isShortForm,_that.matchScore);case KnowledgeContent() when knowledge != null:
return knowledge(_that.id,_that.authorName,_that.authorMbti,_that.createdAt,_that.title,_that.category,_that.iconPath);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class ArticleContent extends Content {
  const ArticleContent({required this.id, this.authorName = 'Unknown Author', this.authorMbti = 'XXXX', required this.createdAt, required this.title, this.summary = '', this.thumbnailUrl = '', final  String? $type}): $type = $type ?? 'article',super._();
  factory ArticleContent.fromJson(Map<String, dynamic> json) => _$ArticleContentFromJson(json);

@override final  String id;
@override@JsonKey() final  String authorName;
@override@JsonKey() final  String authorMbti;
@override final  DateTime createdAt;
 final  String title;
@JsonKey() final  String summary;
@JsonKey() final  String thumbnailUrl;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArticleContentCopyWith<ArticleContent> get copyWith => _$ArticleContentCopyWithImpl<ArticleContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArticleContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArticleContent&&(identical(other.id, id) || other.id == id)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorMbti, authorMbti) || other.authorMbti == authorMbti)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.title, title) || other.title == title)&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.thumbnailUrl, thumbnailUrl) || other.thumbnailUrl == thumbnailUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorName,authorMbti,createdAt,title,summary,thumbnailUrl);

@override
String toString() {
  return 'Content.article(id: $id, authorName: $authorName, authorMbti: $authorMbti, createdAt: $createdAt, title: $title, summary: $summary, thumbnailUrl: $thumbnailUrl)';
}


}

/// @nodoc
abstract mixin class $ArticleContentCopyWith<$Res> implements $ContentCopyWith<$Res> {
  factory $ArticleContentCopyWith(ArticleContent value, $Res Function(ArticleContent) _then) = _$ArticleContentCopyWithImpl;
@override @useResult
$Res call({
 String id, String authorName, String authorMbti, DateTime createdAt, String title, String summary, String thumbnailUrl
});




}
/// @nodoc
class _$ArticleContentCopyWithImpl<$Res>
    implements $ArticleContentCopyWith<$Res> {
  _$ArticleContentCopyWithImpl(this._self, this._then);

  final ArticleContent _self;
  final $Res Function(ArticleContent) _then;

/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorName = null,Object? authorMbti = null,Object? createdAt = null,Object? title = null,Object? summary = null,Object? thumbnailUrl = null,}) {
  return _then(ArticleContent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,authorMbti: null == authorMbti ? _self.authorMbti : authorMbti // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,thumbnailUrl: null == thumbnailUrl ? _self.thumbnailUrl : thumbnailUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
@JsonSerializable()

class VideoContent extends Content {
  const VideoContent({required this.id, required this.authorName, required this.authorMbti, required this.createdAt, required this.videoUrl, required this.isShortForm, this.matchScore, final  String? $type}): $type = $type ?? 'video',super._();
  factory VideoContent.fromJson(Map<String, dynamic> json) => _$VideoContentFromJson(json);

@override final  String id;
@override final  String authorName;
@override final  String authorMbti;
@override final  DateTime createdAt;
 final  String videoUrl;
 final  bool isShortForm;
 final  int? matchScore;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoContentCopyWith<VideoContent> get copyWith => _$VideoContentCopyWithImpl<VideoContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VideoContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoContent&&(identical(other.id, id) || other.id == id)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorMbti, authorMbti) || other.authorMbti == authorMbti)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.videoUrl, videoUrl) || other.videoUrl == videoUrl)&&(identical(other.isShortForm, isShortForm) || other.isShortForm == isShortForm)&&(identical(other.matchScore, matchScore) || other.matchScore == matchScore));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorName,authorMbti,createdAt,videoUrl,isShortForm,matchScore);

@override
String toString() {
  return 'Content.video(id: $id, authorName: $authorName, authorMbti: $authorMbti, createdAt: $createdAt, videoUrl: $videoUrl, isShortForm: $isShortForm, matchScore: $matchScore)';
}


}

/// @nodoc
abstract mixin class $VideoContentCopyWith<$Res> implements $ContentCopyWith<$Res> {
  factory $VideoContentCopyWith(VideoContent value, $Res Function(VideoContent) _then) = _$VideoContentCopyWithImpl;
@override @useResult
$Res call({
 String id, String authorName, String authorMbti, DateTime createdAt, String videoUrl, bool isShortForm, int? matchScore
});




}
/// @nodoc
class _$VideoContentCopyWithImpl<$Res>
    implements $VideoContentCopyWith<$Res> {
  _$VideoContentCopyWithImpl(this._self, this._then);

  final VideoContent _self;
  final $Res Function(VideoContent) _then;

/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorName = null,Object? authorMbti = null,Object? createdAt = null,Object? videoUrl = null,Object? isShortForm = null,Object? matchScore = freezed,}) {
  return _then(VideoContent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,authorMbti: null == authorMbti ? _self.authorMbti : authorMbti // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,videoUrl: null == videoUrl ? _self.videoUrl : videoUrl // ignore: cast_nullable_to_non_nullable
as String,isShortForm: null == isShortForm ? _self.isShortForm : isShortForm // ignore: cast_nullable_to_non_nullable
as bool,matchScore: freezed == matchScore ? _self.matchScore : matchScore // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class KnowledgeContent extends Content {
  const KnowledgeContent({required this.id, required this.authorName, required this.authorMbti, required this.createdAt, required this.title, required this.category, required this.iconPath, final  String? $type}): $type = $type ?? 'knowledge',super._();
  factory KnowledgeContent.fromJson(Map<String, dynamic> json) => _$KnowledgeContentFromJson(json);

@override final  String id;
@override final  String authorName;
@override final  String authorMbti;
@override final  DateTime createdAt;
 final  String title;
 final  String category;
 final  String iconPath;

@JsonKey(name: 'type')
final String $type;


/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KnowledgeContentCopyWith<KnowledgeContent> get copyWith => _$KnowledgeContentCopyWithImpl<KnowledgeContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KnowledgeContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KnowledgeContent&&(identical(other.id, id) || other.id == id)&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.authorMbti, authorMbti) || other.authorMbti == authorMbti)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category)&&(identical(other.iconPath, iconPath) || other.iconPath == iconPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,authorName,authorMbti,createdAt,title,category,iconPath);

@override
String toString() {
  return 'Content.knowledge(id: $id, authorName: $authorName, authorMbti: $authorMbti, createdAt: $createdAt, title: $title, category: $category, iconPath: $iconPath)';
}


}

/// @nodoc
abstract mixin class $KnowledgeContentCopyWith<$Res> implements $ContentCopyWith<$Res> {
  factory $KnowledgeContentCopyWith(KnowledgeContent value, $Res Function(KnowledgeContent) _then) = _$KnowledgeContentCopyWithImpl;
@override @useResult
$Res call({
 String id, String authorName, String authorMbti, DateTime createdAt, String title, String category, String iconPath
});




}
/// @nodoc
class _$KnowledgeContentCopyWithImpl<$Res>
    implements $KnowledgeContentCopyWith<$Res> {
  _$KnowledgeContentCopyWithImpl(this._self, this._then);

  final KnowledgeContent _self;
  final $Res Function(KnowledgeContent) _then;

/// Create a copy of Content
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorName = null,Object? authorMbti = null,Object? createdAt = null,Object? title = null,Object? category = null,Object? iconPath = null,}) {
  return _then(KnowledgeContent(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,authorMbti: null == authorMbti ? _self.authorMbti : authorMbti // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,iconPath: null == iconPath ? _self.iconPath : iconPath // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
