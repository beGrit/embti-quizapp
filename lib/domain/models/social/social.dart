import 'package:freezed_annotation/freezed_annotation.dart';

part 'social.freezed.dart';
part 'social.g.dart';

@freezed
sealed class SocialMeta with _$SocialMeta {
  // 必须添加这个私有构造函数，并且去掉 abstract 关键字
  const SocialMeta._();

  const factory SocialMeta({
    @Default(0) int likesCount,
    @Default(false) bool isLiked,
    @Default(0) int favoritesCount,
    @Default(false) bool isFavorited,
    @Default(0) int sharesCount,
    @Default([]) List<Comment> comments,
    @Default(0) int commentsCount,
  }) = _SocialMeta;

  factory SocialMeta.fromJson(Map<String, dynamic> json) =>
      _$SocialMetaFromJson(json);
}

@freezed
sealed class Comment with _$Comment {
  const Comment._();

  const factory Comment({
    required String id,
    required String userId,
    @Default('Anonymous') String authorName,
    @Default('XXXX') String authorMbti,
    String? authorAvatarUrl,
    required String content,
    required DateTime createdAt,
    @Default(0) int likesCount,
    @Default(false) bool isLiked,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
