import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'social_meta_api_model.freezed.dart';
part 'social_meta_api_model.g.dart';

class FirestoreTimestampConverter implements JsonConverter<DateTime, dynamic> {
  const FirestoreTimestampConverter();

  @override
  DateTime fromJson(dynamic json) {
    if (json is Timestamp) {
      return json.toDate();
    }
    if (json is String) {
      return DateTime.parse(json);
    }
    return DateTime.now();
  }

  @override
  dynamic toJson(DateTime object) => Timestamp.fromDate(object);
}

@freezed
abstract class SocialMetaApiModel with _$SocialMetaApiModel {
  @JsonSerializable(explicitToJson: true)
  const factory SocialMetaApiModel({
    @JsonKey(includeFromJson: false, includeToJson: false) String? id,
    required String relatedId,
    required SocialMetricsApiModel metrics,
    @FirestoreTimestampConverter() required DateTime created,
    @FirestoreTimestampConverter() required DateTime updated,
  }) = _SocialMetaApiModel;

  factory SocialMetaApiModel.fromJson(Map<String, dynamic> json) =>
      _$SocialMetaApiModelFromJson(json);
}

@freezed
abstract class SocialMetricsApiModel with _$SocialMetricsApiModel {
  const factory SocialMetricsApiModel({
    @Default(0) int favorites,
    @Default(0) int likes,
    @Default(0) int shares,
    @Default(0) int comments,
  }) = _SocialMetricsApiModel;

  factory SocialMetricsApiModel.fromJson(Map<String, dynamic> json) =>
      _$SocialMetricsApiModelFromJson(json);
}

@freezed
abstract class CommentApiModel with _$CommentApiModel {
  const factory CommentApiModel({
    @JsonKey(includeFromJson: false, includeToJson: false) String? id,
    required String userId,
    @Default('Anonymous') String authorName,
    @Default('XXXX') String authorMbti,
    String? authorAvatarUrl,
    required String content,
    @FirestoreTimestampConverter() required DateTime createdAt,
    @Default(0) int likesCount,
  }) = _CommentApiModel;

  factory CommentApiModel.fromJson(Map<String, dynamic> json) =>
      _$CommentApiModelFromJson(json);
}
