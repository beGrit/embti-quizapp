// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Question _$QuestionFromJson(Map<String, dynamic> json) => _Question(
  id: json['id'] as String,
  text: json['text'] as String,
  axis: $enumDecode(_$PersonalityAxisEnumMap, json['axis']),
  isReversed: json['isReversed'] as bool? ?? false,
  weight: (json['weight'] as num?)?.toDouble() ?? 1.0,
);

Map<String, dynamic> _$QuestionToJson(_Question instance) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'axis': _$PersonalityAxisEnumMap[instance.axis]!,
  'isReversed': instance.isReversed,
  'weight': instance.weight,
};

const _$PersonalityAxisEnumMap = {
  PersonalityAxis.axis1: 0,
  PersonalityAxis.axis2: 1,
  PersonalityAxis.axis3: 2,
  PersonalityAxis.axis4: 3,
};

_Survey _$SurveyFromJson(Map<String, dynamic> json) => _Survey(
  id: json['id'] as String,
  title: json['title'] as String,
  questions: (json['questions'] as List<dynamic>)
      .map((e) => Question.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SurveyToJson(_Survey instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'questions': instance.questions,
};

_SurveyFlow _$SurveyFlowFromJson(Map<String, dynamic> json) => _SurveyFlow(
  id: json['id'] as String,
  surveyId: json['surveyId'] as String,
  survey: json['survey'] == null
      ? null
      : Survey.fromJson(json['survey'] as Map<String, dynamic>),
  status:
      $enumDecodeNullable(_$SurveyFlowStatusEnumMap, json['status']) ??
      SurveyFlowStatus.idle,
  startTime: json['startTime'] == null
      ? null
      : DateTime.parse(json['startTime'] as String),
  endTime: json['endTime'] == null
      ? null
      : DateTime.parse(json['endTime'] as String),
  totalQuestions: (json['totalQuestions'] as num?)?.toInt() ?? 0,
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
);

Map<String, dynamic> _$SurveyFlowToJson(_SurveyFlow instance) =>
    <String, dynamic>{
      'id': instance.id,
      'surveyId': instance.surveyId,
      'survey': instance.survey,
      'status': _$SurveyFlowStatusEnumMap[instance.status]!,
      'startTime': instance.startTime?.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'totalQuestions': instance.totalQuestions,
      'questionOrder': instance.questionOrder,
      'currentAnswers': instance.currentAnswers,
    };

const _$SurveyFlowStatusEnumMap = {
  SurveyFlowStatus.idle: 'idle',
  SurveyFlowStatus.inProgress: 'inProgress',
  SurveyFlowStatus.completed: 'completed',
  SurveyFlowStatus.expired: 'expired',
};

_AxisScore _$AxisScoreFromJson(Map<String, dynamic> json) => _AxisScore(
  axis: $enumDecode(_$PersonalityAxisEnumMap, json['axis']),
  value: (json['value'] as num).toDouble(),
);

Map<String, dynamic> _$AxisScoreToJson(_AxisScore instance) =>
    <String, dynamic>{
      'axis': _$PersonalityAxisEnumMap[instance.axis]!,
      'value': instance.value,
    };

_AssessmentResult _$AssessmentResultFromJson(Map<String, dynamic> json) =>
    _AssessmentResult(
      surveyFlowId: json['surveyFlowId'] as String,
      surveyFlow: json['surveyFlow'] == null
          ? null
          : SurveyFlow.fromJson(json['surveyFlow'] as Map<String, dynamic>),
      scores: (json['scores'] as List<dynamic>)
          .map((e) => AxisScore.fromJson(e as Map<String, dynamic>))
          .toList(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$AssessmentResultToJson(_AssessmentResult instance) =>
    <String, dynamic>{
      'surveyFlowId': instance.surveyFlowId,
      'surveyFlow': instance.surveyFlow,
      'scores': instance.scores,
      'timestamp': instance.timestamp.toIso8601String(),
    };
