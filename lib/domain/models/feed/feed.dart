import 'package:emombti/domain/models/user/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed.freezed.dart';
part 'feed.g.dart';

/// Model representing a Post
/// Based on PocketBase posts collection schema
@freezed
sealed class Post with _$Post {
  const Post._();

  const factory Post({
    required String id,
    required String title,
    String? body,
    required User author,
    @Default([]) List<String> tags,
    @Default([]) List<String> photos,
    required DateTime created,
    required DateTime updated,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

/// Model representing a Tag
/// Based on PocketBase tags collection schema
@freezed
sealed class Tag with _$Tag {
  const Tag._();

  const factory Tag({
    required String id,
    required String name,
    required DateTime created,
    required DateTime updated,
  }) = _Tag;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
}
