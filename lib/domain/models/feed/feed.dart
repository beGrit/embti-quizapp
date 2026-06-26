import 'package:emombti/domain/models/common/common.dart';
import 'package:emombti/domain/models/user/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed.freezed.dart';
part 'feed.g.dart';

enum RelationType { owner, history, share }

enum FeedType { post, reel }

/// Model representing a Post
/// Based on PocketBase posts collection schema
@freezed
abstract class Post with _$Post {
  const factory Post({
    String? id,
    required FeedType feedType,
    String? title,
    String? body,
    @Default([]) List<AppFile> photos,
    required User author,
    required DateTime created,
    required DateTime updated,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

@freezed
abstract class Reel with _$Reel {
  const factory Reel({
    String? id,
    required FeedType feedType,
    String? title,
    String? subTitle,
    required AppFile videoUrl,
    required User author,
    required DateTime created,
    required DateTime updated,
  }) = _Reel;

  factory Reel.fromJson(Map<String, dynamic> json) => _$ReelFromJson(json);
}

@freezed
abstract class FeedActivity with _$FeedActivity {
  const factory FeedActivity({
    String? id,
    String? title,
    String? body,
    required String feedRel,
    required RelationType relationType,
    required FeedType feedType,
    @Default([]) final List<String> mediaUrls,
    required DateTime orderTime,
  }) = _FeedActivity;
}
