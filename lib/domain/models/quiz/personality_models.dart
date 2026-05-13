import 'package:freezed_annotation/freezed_annotation.dart';

part 'personality_models.freezed.dart';
part 'personality_models.g.dart';

enum PersonalityAxis {
  @JsonValue(0)
  axis1, // 能量来源
  @JsonValue(1)
  axis2, // 信息感知
  @JsonValue(2)
  axis3, // 决策方式
  @JsonValue(3)
  axis4, // 行为模式
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
    required List<AxisScore> scores,
    required DateTime timestamp,
  }) = _AssessmentResult;

  factory AssessmentResult.fromJson(Map<String, dynamic> json) =>
      _$AssessmentResultFromJson(json);

  /// 社交匹配算法：计算欧几里得距离
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
    required String surveyId,
    required Map<String, int> answers, // { "q_id": 1~5 }
  }) = _SurveyResponse;

  factory SurveyResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseFromJson(json);
}

class PersonalityEngine {
  static AssessmentResult process(Survey survey, SurveyResponse response) {
    final Map<PersonalityAxis, List<double>> buffers = {
      for (var a in PersonalityAxis.values) a: [],
    };

    for (var question in survey.questions) {
      final choice = response.answers[question.id];
      if (choice == null) continue;

      // 标准化 1-5 分至 0.0 - 1.0
      double val = (choice - 1) / 4.0;

      if (question.isReversed) {
        val = 1.0 - val;
      }

      buffers[question.axis]?.add(val);
    }

    final finalScores = buffers.entries.map((e) {
      double avg = e.value.isEmpty
          ? 0.5
          : e.value.reduce((a, b) => a + b) / e.value.length;
      return AxisScore(axis: e.key, value: avg);
    }).toList();

    return AssessmentResult(scores: finalScores, timestamp: DateTime.now());
  }
}
