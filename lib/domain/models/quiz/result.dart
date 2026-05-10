part of 'quiz.dart';

@freezed
sealed class DimensionScore with _$DimensionScore {
  const factory DimensionScore({
    required String dimension, // e.g., "EI"
    required double score, // Raw calculated score
    required double percentage, // Normalized 0-100 score
    required String dominantTrait, // e.g., "E" or "I"
    required String traitLabel, // e.g., "Extroversion"
  }) = _DimensionScore;

  factory DimensionScore.fromJson(Map<String, dynamic> json) =>
      _$DimensionScoreFromJson(json);
}

@freezed
sealed class QuizResult with _$QuizResult {
  const factory QuizResult({
    required String id,
    required String quizId,
    required DateTime timestamp,
    required List<DimensionScore> dimensionalAnalysis,
    String? mbtiType, // e.g., "INTJ"
    String? summary,
    String? detailedDescription,
  }) = _QuizResult;

  factory QuizResult.fromJson(Map<String, dynamic> json) =>
      _$QuizResultFromJson(json);
}
