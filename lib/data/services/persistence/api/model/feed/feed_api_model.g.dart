// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostApiModel _$PostApiModelFromJson(Map<String, dynamic> json) =>
    _PostApiModel(
      id: json['id'] as String,
      title: json['title'] as String,
      collectionId: json['collectionId'] as String,
      collectionName: json['collectionName'] as String,
      body: json['body'] as String?,
      expand: json['expand'] as Map<String, dynamic>,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      photos:
          (json['photos'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      created: DateTime.parse(json['created'] as String),
      updated: DateTime.parse(json['updated'] as String),
    );

Map<String, dynamic> _$PostApiModelToJson(_PostApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'collectionId': instance.collectionId,
      'collectionName': instance.collectionName,
      'body': instance.body,
      'expand': instance.expand,
      'tags': instance.tags,
      'photos': instance.photos,
      'created': instance.created.toIso8601String(),
      'updated': instance.updated.toIso8601String(),
    };
