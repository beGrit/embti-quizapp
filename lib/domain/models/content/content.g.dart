// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleContent _$ArticleContentFromJson(Map<String, dynamic> json) =>
    ArticleContent(
      id: json['id'] as String,
      authorName: json['authorName'] as String? ?? 'Unknown Author',
      authorMbti: json['authorMbti'] as String? ?? 'XXXX',
      createdAt: DateTime.parse(json['createdAt'] as String),
      title: json['title'] as String,
      summary: json['summary'] as String? ?? '',
      thumbnailUrl: json['thumbnailUrl'] as String? ?? '',
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$ArticleContentToJson(ArticleContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorName': instance.authorName,
      'authorMbti': instance.authorMbti,
      'createdAt': instance.createdAt.toIso8601String(),
      'title': instance.title,
      'summary': instance.summary,
      'thumbnailUrl': instance.thumbnailUrl,
      'type': instance.$type,
    };

VideoContent _$VideoContentFromJson(Map<String, dynamic> json) => VideoContent(
  id: json['id'] as String,
  authorName: json['authorName'] as String,
  authorMbti: json['authorMbti'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  videoUrl: json['videoUrl'] as String,
  isShortForm: json['isShortForm'] as bool,
  matchScore: (json['matchScore'] as num?)?.toInt(),
  $type: json['type'] as String?,
);

Map<String, dynamic> _$VideoContentToJson(VideoContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorName': instance.authorName,
      'authorMbti': instance.authorMbti,
      'createdAt': instance.createdAt.toIso8601String(),
      'videoUrl': instance.videoUrl,
      'isShortForm': instance.isShortForm,
      'matchScore': instance.matchScore,
      'type': instance.$type,
    };

KnowledgeContent _$KnowledgeContentFromJson(Map<String, dynamic> json) =>
    KnowledgeContent(
      id: json['id'] as String,
      authorName: json['authorName'] as String,
      authorMbti: json['authorMbti'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      title: json['title'] as String,
      category: json['category'] as String,
      iconPath: json['iconPath'] as String,
      $type: json['type'] as String?,
    );

Map<String, dynamic> _$KnowledgeContentToJson(KnowledgeContent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorName': instance.authorName,
      'authorMbti': instance.authorMbti,
      'createdAt': instance.createdAt.toIso8601String(),
      'title': instance.title,
      'category': instance.category,
      'iconPath': instance.iconPath,
      'type': instance.$type,
    };
