import 'package:freezed_annotation/freezed_annotation.dart';

part 'feed_api_model.freezed.dart';
part 'feed_api_model.g.dart';

/// Model representing a Post
/// Based on PocketBase posts collection schema
@freezed
abstract class PostApiModel with _$PostApiModel {
  const factory PostApiModel({
    required String id,
    required String title,
    required String collectionId,
    required String collectionName,
    String? body,
    required Map<String, dynamic> author,
    @Default([]) List<String> tags,
    @Default([]) List<String> photos,
    required DateTime created,
    required DateTime updated,
  }) = _PostApiModel;

  factory PostApiModel.fromJson(Map<String, dynamic> json) =>
      _$PostApiModelFromJson(json);
}
