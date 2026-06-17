// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SurveyFlowApiModel _$SurveyFlowApiModelFromJson(Map<String, dynamic> json) =>
    _SurveyFlowApiModel(
      id: json['id'] as String?,
      surveyId: json['surveyId'] as String?,
      status: json['status'] as String?,
      startTime: const FirestoreTimestampConverter().fromJson(
        json['startTime'],
      ),
      endTime: const FirestoreTimestampConverter().fromJson(json['endTime']),
      questionOrder:
          (json['questionOrder'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      currentAnswers:
          (json['currentAnswers'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
      deleted: json['deleted'] as bool? ?? false,
    );

Map<String, dynamic> _$SurveyFlowApiModelToJson(_SurveyFlowApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'surveyId': instance.surveyId,
      'status': instance.status,
      'startTime': _$JsonConverterToJson<dynamic, DateTime>(
        instance.startTime,
        const FirestoreTimestampConverter().toJson,
      ),
      'endTime': _$JsonConverterToJson<dynamic, DateTime>(
        instance.endTime,
        const FirestoreTimestampConverter().toJson,
      ),
      'questionOrder': instance.questionOrder,
      'currentAnswers': instance.currentAnswers,
      'deleted': instance.deleted,
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

_AxisScoreApiModel _$AxisScoreApiModelFromJson(Map<String, dynamic> json) =>
    _AxisScoreApiModel(
      axis: (json['axis'] as num).toInt(),
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$AxisScoreApiModelToJson(_AxisScoreApiModel instance) =>
    <String, dynamic>{'axis': instance.axis, 'value': instance.value};

_AssessmentResultApiModel _$AssessmentResultApiModelFromJson(
  Map<String, dynamic> json,
) => _AssessmentResultApiModel(
  surveyFlowId: json['surveyFlowId'] as String?,
  type: json['type'] as String?,
  scores:
      (json['scores'] as List<dynamic>?)
          ?.map((e) => AxisScoreApiModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  timestamp: const FirestoreTimestampConverter().fromJson(json['timestamp']),
);

Map<String, dynamic> _$AssessmentResultApiModelToJson(
  _AssessmentResultApiModel instance,
) => <String, dynamic>{
  'surveyFlowId': instance.surveyFlowId,
  'type': instance.type,
  'scores': instance.scores,
  'timestamp': _$JsonConverterToJson<dynamic, DateTime>(
    instance.timestamp,
    const FirestoreTimestampConverter().toJson,
  ),
};
