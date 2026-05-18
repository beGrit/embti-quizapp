// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Post _$PostFromJson(Map<String, dynamic> json) => _Post(
  id: json['id'] as String,
  title: json['title'] as String,
  body: json['body'] as String?,
  author: User.fromJson(json['author'] as Map<String, dynamic>),
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  photos:
      (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  created: DateTime.parse(json['created'] as String),
  updated: DateTime.parse(json['updated'] as String),
);

Map<String, dynamic> _$PostToJson(_Post instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'body': instance.body,
  'author': instance.author,
  'tags': instance.tags,
  'photos': instance.photos,
  'created': instance.created.toIso8601String(),
  'updated': instance.updated.toIso8601String(),
};

_Tag _$TagFromJson(Map<String, dynamic> json) => _Tag(
  id: json['id'] as String,
  name: json['name'] as String,
  created: DateTime.parse(json['created'] as String),
  updated: DateTime.parse(json['updated'] as String),
);

Map<String, dynamic> _$TagToJson(_Tag instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'created': instance.created.toIso8601String(),
  'updated': instance.updated.toIso8601String(),
};
