part of 'quiz.dart';

enum QuizStatus {
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('done')
  done,
}

@freezed
sealed class QuizHistory with _$QuizHistory {
  const factory QuizHistory({
    required String id,
    required String quizId,
    required String quizTitle,
    @Default(QuizStatus.inProgress) QuizStatus status,
    QuizResult? result,
    DateTime? completedAt,
  }) = _QuizHistory;

  factory QuizHistory.fromJson(Map<String, dynamic> json) =>
      _$QuizHistoryFromJson(json);
}
