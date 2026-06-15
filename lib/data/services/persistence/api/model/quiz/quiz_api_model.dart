import 'package:freezed_annotation/freezed_annotation.dart';

part 'quiz_api_model.freezed.dart';
part 'quiz_api_model.g.dart';

@freezed
abstract class SurveyFlowApiModel with _$SurveyFlowApiModel {
  const factory SurveyFlowApiModel({
    String? id,
    String? surveyId,
    String? userId,
    String? status,
    DateTime? startTime,
    DateTime? endTime,
    bool? deleted,
  }) = _SurveyFlowApiModel;

  factory SurveyFlowApiModel.fromJson(Map<String, dynamic> json) =>
      _$SurveyFlowApiModelFromJson(json);
}

@freezed
abstract class AssessmentResultApiModel with _$AssessmentResultApiModel {
  const factory AssessmentResultApiModel({
    String? type,
    @Default([]) List<String> scores,
    DateTime? timestamp,
  }) = _AssessmentResultApiModel;

  factory AssessmentResultApiModel.fromJson(Map<String, dynamic> json) =>
      _$AssessmentResultApiModelFromJson(json);
}
