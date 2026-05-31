import 'package:freezed_annotation/freezed_annotation.dart';

part 'survey_models.freezed.dart';
part 'survey_models.g.dart';

enum PersonalityAxis {
  @JsonValue(0)
  axis1,
  @JsonValue(1)
  axis2,
  @JsonValue(2)
  axis3,
  @JsonValue(3)
  axis4,
}

enum AnwserGrade {
  @JsonValue(0)
  grade0,
  @JsonValue(1)
  grade1,
  @JsonValue(2)
  grade2,
  @JsonValue(3)
  grade3,
  @JsonValue(4)
  grade4,
}

@freezed
sealed class Question with _$Question {
  const factory Question({
    required String id,
    required String text,
    required PersonalityAxis axis,
    @Default(false) bool isReversed,
    @Default(1.0) double weight,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}

@freezed
sealed class Survey with _$Survey {
  const factory Survey({
    required String id,
    required String title,
    required List<Question> questions,
  }) = _Survey;

  factory Survey.fromJson(Map<String, dynamic> json) => _$SurveyFromJson(json);
}

enum SurveyFlowStatus { idle, inProgress, completed, expired }

@freezed
sealed class SurveyFlow with _$SurveyFlow {
  const SurveyFlow._();

  const factory SurveyFlow({
    required String id, // Unique ID for this specific flow instance
    required String surveyId,
    @Default(SurveyFlowStatus.idle) SurveyFlowStatus status,

    DateTime? startTime,
    DateTime? endTime,

    @Default(0) int totalQuestions,
    @Default([]) List<String> questionOrder,
    @Default({}) Map<String, int> currentAnswers,
  }) = _SurveyFlow;

  factory SurveyFlow.fromJson(Map<String, dynamic> json) =>
      _$SurveyFlowFromJson(json);

  double get completionRate =>
      totalQuestions == 0 ? 0.0 : currentAnswers.length / totalQuestions;

  int get completionPercentage =>
      (completionRate.clamp(0.0, 1.0) * 100).round();

  Duration get duration =>
      (endTime ?? DateTime.now()).difference(startTime ?? DateTime.now());

  bool get isAllAnswered =>
      currentAnswers.length >= totalQuestions && totalQuestions > 0;

  String get defaultTitle => 'Assessment: $surveyId';
}

@freezed
sealed class AxisScore with _$AxisScore {
  const AxisScore._();
  const factory AxisScore({
    required PersonalityAxis axis,
    required double value, // 0.0 to 1.0
  }) = _AxisScore;

  factory AxisScore.fromJson(Map<String, dynamic> json) =>
      _$AxisScoreFromJson(json);

  int get leftPercentage => ((1 - value) * 100).round();
  int get rightPercentage => (value * 100).round();
}

@freezed
sealed class AssessmentResult with _$AssessmentResult {
  const AssessmentResult._();
  const factory AssessmentResult({
    required String surveyFlowId,
    required List<AxisScore> scores,
    required DateTime timestamp,
  }) = _AssessmentResult;

  factory AssessmentResult.fromJson(Map<String, dynamic> json) =>
      _$AssessmentResultFromJson(json);

  double computeDistance(AssessmentResult other) {
    double sum = 0;
    for (int i = 0; i < scores.length; i++) {
      double diff = scores[i].value - other.scores[i].value;
      sum += diff * diff;
    }
    return sum;
  }
}

@freezed
sealed class SurveyResponse with _$SurveyResponse {
  const factory SurveyResponse({
    required String surveyFlowId,
    required String surveyId,
    required Map<String, int> answers, // { "q_id": 1~5 }
  }) = _SurveyResponse;

  factory SurveyResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseFromJson(json);
}
