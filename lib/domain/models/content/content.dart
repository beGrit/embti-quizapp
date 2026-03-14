import 'package:freezed_annotation/freezed_annotation.dart';

part 'article_content.dart';
// Generated files for the entire library
part 'content.freezed.dart';
part 'content.g.dart';
part 'knowledge_content.dart';
part 'video_content.dart';

@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
sealed class Content with _$Content {
  const Content._(); // Required for custom getters/methods

  // Shared getters defined in the base sealed class
  String get id;
  String get authorName;
  String get authorMbti;
  DateTime get createdAt;

  // 1. Article Implementation
  const factory Content.article({
    required String id,
    @Default('Unknown Author') String authorName,
    @Default('XXXX') String authorMbti,
    required DateTime createdAt,
    required String title,
    @Default('') String summary,
    @Default('') String thumbnailUrl,
  }) = ArticleContent;

  // 2. Video Implementation
  const factory Content.video({
    required String id,
    required String authorName,
    required String authorMbti,
    required DateTime createdAt,
    required String videoUrl,
    required bool isShortForm,
    int? matchScore,
  }) = VideoContent;

  // 3. Knowledge Implementation
  const factory Content.knowledge({
    required String id,
    required String authorName,
    required String authorMbti,
    required DateTime createdAt,
    required String title,
    required String category,
    required String iconPath,
  }) = KnowledgeContent;

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);
}
