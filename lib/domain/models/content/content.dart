import 'package:freezed_annotation/freezed_annotation.dart';

part 'content.freezed.dart';
part 'content.g.dart';

@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
sealed class Content with _$Content {
  const Content._(); // Required for custom getters/methods

  // Shared getters defined in the base sealed class
  @override
  String get id;
  @override
  String get authorName;
  @override
  String get authorMbti;
  @override
  DateTime get createdAt;

  // Article Implementation
  const factory Content.article({
    required String id,
    @Default('Unknown Author') String authorName,
    @Default('XXXX') String authorMbti,
    required DateTime createdAt,
    required String title,
    @Default('') String summary,
    @Default('') String thumbnailUrl,
  }) = ArticleContent;

  // Video Implementation
  const factory Content.video({
    required String id,
    required String authorName,
    required String authorMbti,
    required DateTime createdAt,
    required String videoUrl,
    required bool isShortForm,
    int? matchScore,
  }) = VideoContent;

  // Knowledge Implementation
  const factory Content.knowledge({
    required String id,
    required String authorName,
    required String authorMbti,
    required DateTime createdAt,
    required String title,
    required String category,
    required String iconPath,
  }) = KnowledgeContent;

  const factory Content.banner({
    required String id,
    @Default('Unknown Author') String authorName,
    @Default('XXXX') String authorMbti,
    required DateTime createdAt,
    required String mediaUrl,
    required String title,
    @Default('image') String mediaType,
    String? linkUrl,
    @Default(false) bool isExternal,
    @Default(false) bool autoPlay,
  }) = BannerContent;

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
}
