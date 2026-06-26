import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_api_model.freezed.dart';
part 'feed_api_model.g.dart';

/// Model representing a Post
/// Based on PocketBase posts collection schema
@freezed
abstract class PostApiModel with _$PostApiModel {
  const factory PostApiModel({
    required String id,
    required String author,
    required String feedType,
    required String title,
    String? body,
    @Default([]) List<String> tags,
    @Default([]) List<Map<String, dynamic>> photos,
    required DateTime created,
    required DateTime updated,
  }) = _PostApiModel;

  factory PostApiModel.fromJson(Map<String, dynamic> json) =>
      _$PostApiModelFromJson(json);
}

/// Model representing a Reel
/// Based on PocketBase reels collection schema
@freezed
abstract class ReelApiModel with _$ReelApiModel {
  const factory ReelApiModel({
    required String id,
    required String author,
    required String feedType,
    String? title,
    String? subTitle,
    required Map<String, dynamic> video,
    required DateTime created,
    required DateTime updated,
  }) = _ReelApiModel;

  factory ReelApiModel.fromJson(Map<String, dynamic> json) =>
      _$ReelApiModelFromJson(json);
}

/// Model representing a FeedActivity
/// Based on PocketBase feed_activities collection schema
@freezed
abstract class FeedActivityApiModel with _$FeedActivityApiModel {
  const factory FeedActivityApiModel({
    required String id,
    String? title,
    String? body,
    required String feedRel,
    required String relationType,
    required String feedType,
    @Default([]) List<Map<String, dynamic>> medias,
    required DateTime orderTime,
  }) = _FeedActivityApiModel;

  factory FeedActivityApiModel.fromJson(Map<String, dynamic> json) =>
      _$FeedActivityApiModelFromJson(json);
}
