// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Post _$PostFromJson(Map<String, dynamic> json) => _Post(
  id: json['id'] as String?,
  title: json['title'] as String?,
  body: json['body'] as String?,
  author: User.fromJson(json['author'] as Map<String, dynamic>),
  photos:
      (json['photos'] as List<dynamic>?)
          ?.map((e) => AppFile.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  created: DateTime.parse(json['created'] as String),
);

Map<String, dynamic> _$PostToJson(_Post instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'body': instance.body,
  'author': instance.author,
  'photos': instance.photos,
  'created': instance.created.toIso8601String(),
};
