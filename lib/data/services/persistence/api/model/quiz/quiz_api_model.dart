import 'package:emombti/domain/models/quiz/survey_models.dart';
import 'package:emombti/utils/converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_api_model.freezed.dart';
part 'quiz_api_model.g.dart';

@freezed
abstract class SurveyFlowApiModel with _$SurveyFlowApiModel {
  const SurveyFlowApiModel._();

  const factory SurveyFlowApiModel({
    String? id,
    String? surveyId,
    String? status,
    @FirestoreTimestampConverter() DateTime? startTime,
    @FirestoreTimestampConverter() DateTime? endTime,
    @Default([]) List<String> questionOrder,
    @Default({}) Map<String, int> currentAnswers,
    @Default(false) bool? deleted,
  }) = _SurveyFlowApiModel;

  factory SurveyFlowApiModel.fromJson(Map<String, dynamic> json) =>
      _$SurveyFlowApiModelFromJson(json);

  factory SurveyFlowApiModel.fromDomain(SurveyFlow flow) {
    return SurveyFlowApiModel(
      id: flow.id,
      surveyId: flow.surveyId,
      status: flow.status.name,
      startTime: flow.startTime,
      endTime: flow.endTime,
      questionOrder: flow.questionOrder,
      currentAnswers: flow.currentAnswers,
    );
  }

  SurveyFlow toDomain() {
    return SurveyFlow(
      id: id ?? '',
      surveyId: surveyId ?? '',
      status: SurveyFlowStatus.values.firstWhere(
        (e) => e.name == status,
        orElse: () => SurveyFlowStatus.idle,
      ),
      startTime: startTime,
      endTime: endTime,
      questionOrder: questionOrder,
      currentAnswers: currentAnswers,
    );
  }
}

@freezed
abstract class AxisScoreApiModel with _$AxisScoreApiModel {
  const factory AxisScoreApiModel({required int axis, required double value}) =
      _AxisScoreApiModel;

  factory AxisScoreApiModel.fromJson(Map<String, dynamic> json) =>
      _$AxisScoreApiModelFromJson(json);
}

@freezed
abstract class AssessmentResultApiModel with _$AssessmentResultApiModel {
  const AssessmentResultApiModel._();

  const factory AssessmentResultApiModel({
    String? surveyFlowId,
    String? type,
    @Default([]) List<AxisScoreApiModel> scores,
    @FirestoreTimestampConverter() DateTime? timestamp,
  }) = _AssessmentResultApiModel;

  factory AssessmentResultApiModel.fromJson(Map<String, dynamic> json) =>
      _$AssessmentResultApiModelFromJson(json);

  factory AssessmentResultApiModel.fromDomain(AssessmentResult result) {
    return AssessmentResultApiModel(
      surveyFlowId: result.surveyFlowId,
      type: result.type,
      scores: result.scores
          .map((e) => AxisScoreApiModel(axis: e.axis.index, value: e.value))
          .toList(),
      timestamp: result.timestamp,
    );
  }

  AssessmentResult toDomain() {
    return AssessmentResult(
      surveyFlowId: surveyFlowId ?? '',
      type: type,
      scores: scores
          .map(
            (e) =>
                AxisScore(axis: PersonalityAxis.values[e.axis], value: e.value),
          )
          .toList(),
      timestamp: timestamp ?? DateTime.now(),
    );
  }
}
