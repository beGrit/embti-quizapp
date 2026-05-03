// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SocialMeta _$SocialMetaFromJson(Map<String, dynamic> json) => _SocialMeta(
  likesCount: (json['likesCount'] as num?)?.toInt() ?? 0,
  isLiked: json['isLiked'] as bool? ?? false,
  favoritesCount: (json['favoritesCount'] as num?)?.toInt() ?? 0,
  isFavorited: json['isFavorited'] as bool? ?? false,
  sharesCount: (json['sharesCount'] as num?)?.toInt() ?? 0,
  comments:
      (json['comments'] as List<dynamic>?)
          ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  commentsCount: (json['commentsCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$SocialMetaToJson(_SocialMeta instance) =>
    <String, dynamic>{
      'likesCount': instance.likesCount,
      'isLiked': instance.isLiked,
      'favoritesCount': instance.favoritesCount,
      'isFavorited': instance.isFavorited,
      'sharesCount': instance.sharesCount,
      'comments': instance.comments,
      'commentsCount': instance.commentsCount,
    };

_Comment _$CommentFromJson(Map<String, dynamic> json) => _Comment(
  id: json['id'] as String,
  userId: json['userId'] as String,
  authorName: json['authorName'] as String? ?? 'Anonymous',
  authorMbti: json['authorMbti'] as String? ?? 'XXXX',
  authorAvatarUrl: json['authorAvatarUrl'] as String?,
  content: json['content'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  likesCount: (json['likesCount'] as num?)?.toInt() ?? 0,
  isLiked: json['isLiked'] as bool? ?? false,
);

Map<String, dynamic> _$CommentToJson(_Comment instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'authorName': instance.authorName,
  'authorMbti': instance.authorMbti,
  'authorAvatarUrl': instance.authorAvatarUrl,
  'content': instance.content,
  'createdAt': instance.createdAt.toIso8601String(),
  'likesCount': instance.likesCount,
  'isLiked': instance.isLiked,
};
