// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Post _$PostFromJson(Map<String, dynamic> json) => _Post(
  id: json['id'] as String?,
  feedType: $enumDecode(_$FeedTypeEnumMap, json['feedType']),
  title: json['title'] as String?,
  body: json['body'] as String?,
  photos:
      (json['photos'] as List<dynamic>?)
          ?.map((e) => AppFile.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  author: User.fromJson(json['author'] as Map<String, dynamic>),
  created: DateTime.parse(json['created'] as String),
  updated: DateTime.parse(json['updated'] as String),
);

Map<String, dynamic> _$PostToJson(_Post instance) => <String, dynamic>{
  'id': instance.id,
  'feedType': _$FeedTypeEnumMap[instance.feedType]!,
  'title': instance.title,
  'body': instance.body,
  'photos': instance.photos,
  'author': instance.author,
  'created': instance.created.toIso8601String(),
  'updated': instance.updated.toIso8601String(),
};

const _$FeedTypeEnumMap = {FeedType.post: 'post', FeedType.reel: 'reel'};

_Reel _$ReelFromJson(Map<String, dynamic> json) => _Reel(
  id: json['id'] as String?,
  feedType: $enumDecode(_$FeedTypeEnumMap, json['feedType']),
  title: json['title'] as String?,
  subTitle: json['subTitle'] as String?,
  videoUrl: AppFile.fromJson(json['videoUrl'] as Map<String, dynamic>),
  author: User.fromJson(json['author'] as Map<String, dynamic>),
  created: DateTime.parse(json['created'] as String),
  updated: DateTime.parse(json['updated'] as String),
);

Map<String, dynamic> _$ReelToJson(_Reel instance) => <String, dynamic>{
  'id': instance.id,
  'feedType': _$FeedTypeEnumMap[instance.feedType]!,
  'title': instance.title,
  'subTitle': instance.subTitle,
  'videoUrl': instance.videoUrl,
  'author': instance.author,
  'created': instance.created.toIso8601String(),
  'updated': instance.updated.toIso8601String(),
};
