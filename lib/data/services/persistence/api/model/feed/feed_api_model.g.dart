// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostApiModel _$PostApiModelFromJson(Map<String, dynamic> json) =>
    _PostApiModel(
      id: json['id'] as String,
      author: json['author'] as String,
      feedType: json['feedType'] as String,
      title: json['title'] as String,
      body: json['body'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      photos:
          (json['photos'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          const [],
      created: DateTime.parse(json['created'] as String),
      updated: DateTime.parse(json['updated'] as String),
    );

Map<String, dynamic> _$PostApiModelToJson(_PostApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'feedType': instance.feedType,
      'title': instance.title,
      'body': instance.body,
      'tags': instance.tags,
      'photos': instance.photos,
      'created': instance.created.toIso8601String(),
      'updated': instance.updated.toIso8601String(),
    };

_ReelApiModel _$ReelApiModelFromJson(Map<String, dynamic> json) =>
    _ReelApiModel(
      id: json['id'] as String,
      author: json['author'] as String,
      feedType: json['feedType'] as String,
      title: json['title'] as String?,
      subTitle: json['subTitle'] as String?,
      video: json['video'] as Map<String, dynamic>,
      created: DateTime.parse(json['created'] as String),
      updated: DateTime.parse(json['updated'] as String),
    );

Map<String, dynamic> _$ReelApiModelToJson(_ReelApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'feedType': instance.feedType,
      'title': instance.title,
      'subTitle': instance.subTitle,
      'video': instance.video,
      'created': instance.created.toIso8601String(),
      'updated': instance.updated.toIso8601String(),
    };

_FeedActivityApiModel _$FeedActivityApiModelFromJson(
  Map<String, dynamic> json,
) => _FeedActivityApiModel(
  id: json['id'] as String,
  title: json['title'] as String?,
  body: json['body'] as String?,
  feedRel: json['feedRel'] as String,
  relationType: json['relationType'] as String,
  feedType: json['feedType'] as String,
  medias:
      (json['medias'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList() ??
      const [],
  orderTime: DateTime.parse(json['orderTime'] as String),
);

Map<String, dynamic> _$FeedActivityApiModelToJson(
  _FeedActivityApiModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'body': instance.body,
  'feedRel': instance.feedRel,
  'relationType': instance.relationType,
  'feedType': instance.feedType,
  'medias': instance.medias,
  'orderTime': instance.orderTime.toIso8601String(),
};
