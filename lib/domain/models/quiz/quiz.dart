import 'package:freezed_annotation/freezed_annotation.dart';

part 'history.dart';
part 'question.dart';
part 'quiz.freezed.dart';
part 'quiz.g.dart';
part 'result.dart';

@freezed
sealed class Quiz with _$Quiz {
  const factory Quiz({
    required String id,
    required String title,
    required String description,
    String? imageUrl,
    @Default(0) int questionCount,
    @Default([]) List<Question> questions,
    @Default({}) Map<String, String> metadata,
  }) = _Quiz;

  factory Quiz.fromJson(Map<String, dynamic> json) => _$QuizFromJson(json);
}
