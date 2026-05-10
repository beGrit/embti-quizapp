part of 'quiz.dart';

/// Represents the 7-degree Likert scale options for a question.
enum LikertScale {
  @JsonValue(7)
  stronglyAgree(7, 'Strongly Agree'),
  @JsonValue(6)
  agree(6, 'Agree'),
  @JsonValue(5)
  somewhatAgree(5, 'Somewhat Agree'),
  @JsonValue(4)
  neutral(4, 'Neutral'),
  @JsonValue(3)
  somewhatDisagree(3, 'Somewhat Disagree'),
  @JsonValue(2)
  disagree(2, 'Disagree'),
  @JsonValue(1)
  stronglyDisagree(1, 'Strongly Disagree');

  final int value;
  final String label;
  const LikertScale(this.value, this.label);
}

@freezed
sealed class Question with _$Question {
  const factory Question({
    required String id,
    required String text,

    /// The user's selected response on the 7-degree scale.
    /// Null indicates the question hasn't been answered yet.
    LikertScale? selectedValue,
    @Default({}) Map<String, String> metadata,
    @Default(false) bool isReversed,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
}
