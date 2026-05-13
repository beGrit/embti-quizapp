// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personality_models.dart';

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
      scores: (json['scores'] as List<dynamic>)
          .map((e) => AxisScore.fromJson(e as Map<String, dynamic>))
          .toList(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$AssessmentResultToJson(_AssessmentResult instance) =>
    <String, dynamic>{
      'scores': instance.scores,
      'timestamp': instance.timestamp.toIso8601String(),
    };

_SurveyResponse _$SurveyResponseFromJson(Map<String, dynamic> json) =>
    _SurveyResponse(
      surveyId: json['surveyId'] as String,
      answers: Map<String, int>.from(json['answers'] as Map),
    );

Map<String, dynamic> _$SurveyResponseToJson(_SurveyResponse instance) =>
    <String, dynamic>{
      'surveyId': instance.surveyId,
      'answers': instance.answers,
    };
