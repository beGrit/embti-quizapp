import 'package:emombti/domain/models/common/common.dart';
import 'package:emombti/domain/models/social/social.dart';
import 'package:emombti/domain/models/user/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed.freezed.dart';
part 'feed.g.dart';

/// Model representing a Post
/// Based on PocketBase posts collection schema
@freezed
abstract class Post with _$Post {
  const factory Post({
    String? id,
    String? title,
    String? body,
    required User author,
    @Default([]) List<AppFile> photos,
    required DateTime created,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

@freezed
abstract class Reel with _$Reel {
  const factory Reel({
    String? id,
    String? title,
    String? subTitle,
    required User author,
    required AppFile videoUrl,
    required DateTime created,
    required DateTime updated,
    SocialMeta? meta,
  }) = _Reel;

  factory Reel.fromJson(Map<String, dynamic> json) => _$ReelFromJson(json);
}
