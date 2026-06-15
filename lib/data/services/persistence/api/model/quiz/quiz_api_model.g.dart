// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SurveyFlowApiModel _$SurveyFlowApiModelFromJson(Map<String, dynamic> json) =>
    _SurveyFlowApiModel(
      id: json['id'] as String?,
      surveyId: json['surveyId'] as String?,
      userId: json['userId'] as String?,
      status: json['status'] as String?,
      startTime: json['startTime'] == null
          ? null
          : DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      deleted: json['deleted'] as bool?,
    );

Map<String, dynamic> _$SurveyFlowApiModelToJson(_SurveyFlowApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'surveyId': instance.surveyId,
      'userId': instance.userId,
      'status': instance.status,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'deleted': instance.deleted,
    };

_AssessmentResultApiModel _$AssessmentResultApiModelFromJson(
  Map<String, dynamic> json,
) => _AssessmentResultApiModel(
  type: json['type'] as String?,
  scores:
      (json['scores'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  timestamp: json['timestamp'] == null
      ? null
      : DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$AssessmentResultApiModelToJson(
  _AssessmentResultApiModel instance,
) => <String, dynamic>{
  'type': instance.type,
  'scores': instance.scores,
  'timestamp': instance.timestamp?.toIso8601String(),
};
