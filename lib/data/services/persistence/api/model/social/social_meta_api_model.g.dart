// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_meta_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SocialMetaApiModel _$SocialMetaApiModelFromJson(Map<String, dynamic> json) =>
    _SocialMetaApiModel(
      relatedId: json['relatedId'] as String,
      metrics: SocialMetricsApiModel.fromJson(
        json['metrics'] as Map<String, dynamic>,
      ),
      created: const FirestoreTimestampConverter().fromJson(json['created']),
      updated: const FirestoreTimestampConverter().fromJson(json['updated']),
    );

Map<String, dynamic> _$SocialMetaApiModelToJson(_SocialMetaApiModel instance) =>
    <String, dynamic>{
      'relatedId': instance.relatedId,
      'metrics': instance.metrics,
      'created': const FirestoreTimestampConverter().toJson(instance.created),
      'updated': const FirestoreTimestampConverter().toJson(instance.updated),
    };

_SocialMetricsApiModel _$SocialMetricsApiModelFromJson(
  Map<String, dynamic> json,
) => _SocialMetricsApiModel(
  favorites: (json['favorites'] as num?)?.toInt() ?? 0,
  likes: (json['likes'] as num?)?.toInt() ?? 0,
  shares: (json['shares'] as num?)?.toInt() ?? 0,
  comments: (json['comments'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$SocialMetricsApiModelToJson(
  _SocialMetricsApiModel instance,
) => <String, dynamic>{
  'favorites': instance.favorites,
  'likes': instance.likes,
  'shares': instance.shares,
  'comments': instance.comments,
};

_CommentApiModel _$CommentApiModelFromJson(Map<String, dynamic> json) =>
    _CommentApiModel(
      userId: json['userId'] as String,
      authorName: json['authorName'] as String? ?? 'Anonymous',
      authorMbti: json['authorMbti'] as String? ?? 'XXXX',
      authorAvatarUrl: json['authorAvatarUrl'] as String?,
      content: json['content'] as String,
      createdAt: const FirestoreTimestampConverter().fromJson(
        json['createdAt'],
      ),
      likesCount: (json['likesCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$CommentApiModelToJson(
  _CommentApiModel instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'authorName': instance.authorName,
  'authorMbti': instance.authorMbti,
  'authorAvatarUrl': instance.authorAvatarUrl,
  'content': instance.content,
  'createdAt': const FirestoreTimestampConverter().toJson(instance.createdAt),
  'likesCount': instance.likesCount,
};
