// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Quiz _$QuizFromJson(Map<String, dynamic> json) => _Quiz(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  imageUrl: json['imageUrl'] as String?,
  questionCount: (json['questionCount'] as num?)?.toInt() ?? 0,
  questions:
      (json['questions'] as List<dynamic>?)
          ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  metadata:
      (json['metadata'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
);

Map<String, dynamic> _$QuizToJson(_Quiz instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'imageUrl': instance.imageUrl,
  'questionCount': instance.questionCount,
  'questions': instance.questions,
  'metadata': instance.metadata,
};

_QuizHistory _$QuizHistoryFromJson(Map<String, dynamic> json) => _QuizHistory(
  id: json['id'] as String,
  quizId: json['quizId'] as String,
  quizTitle: json['quizTitle'] as String,
  status:
      $enumDecodeNullable(_$QuizStatusEnumMap, json['status']) ??
      QuizStatus.inProgress,
  result: json['result'] == null
      ? null
      : QuizResult.fromJson(json['result'] as Map<String, dynamic>),
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
);

Map<String, dynamic> _$QuizHistoryToJson(_QuizHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quizId': instance.quizId,
      'quizTitle': instance.quizTitle,
      'status': _$QuizStatusEnumMap[instance.status]!,
      'result': instance.result,
      'completedAt': instance.completedAt?.toIso8601String(),
    };

const _$QuizStatusEnumMap = {
  QuizStatus.inProgress: 'in_progress',
  QuizStatus.done: 'done',
};

_Question _$QuestionFromJson(Map<String, dynamic> json) => _Question(
  id: json['id'] as String,
  text: json['text'] as String,
  selectedValue: $enumDecodeNullable(
    _$LikertScaleEnumMap,
    json['selectedValue'],
  ),
  metadata:
      (json['metadata'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  isReversed: json['isReversed'] as bool? ?? false,
);

Map<String, dynamic> _$QuestionToJson(_Question instance) => <String, dynamic>{
  'id': instance.id,
  'text': instance.text,
  'selectedValue': _$LikertScaleEnumMap[instance.selectedValue],
  'metadata': instance.metadata,
  'isReversed': instance.isReversed,
};

const _$LikertScaleEnumMap = {
  LikertScale.stronglyAgree: 7,
  LikertScale.agree: 6,
  LikertScale.somewhatAgree: 5,
  LikertScale.neutral: 4,
  LikertScale.somewhatDisagree: 3,
  LikertScale.disagree: 2,
  LikertScale.stronglyDisagree: 1,
};

_DimensionScore _$DimensionScoreFromJson(Map<String, dynamic> json) =>
    _DimensionScore(
      dimension: json['dimension'] as String,
      score: (json['score'] as num).toDouble(),
      percentage: (json['percentage'] as num).toDouble(),
      dominantTrait: json['dominantTrait'] as String,
      traitLabel: json['traitLabel'] as String,
    );

Map<String, dynamic> _$DimensionScoreToJson(_DimensionScore instance) =>
    <String, dynamic>{
      'dimension': instance.dimension,
      'score': instance.score,
      'percentage': instance.percentage,
      'dominantTrait': instance.dominantTrait,
      'traitLabel': instance.traitLabel,
    };

_QuizResult _$QuizResultFromJson(Map<String, dynamic> json) => _QuizResult(
  id: json['id'] as String,
  quizId: json['quizId'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
  dimensionalAnalysis: (json['dimensionalAnalysis'] as List<dynamic>)
      .map((e) => DimensionScore.fromJson(e as Map<String, dynamic>))
      .toList(),
  mbtiType: json['mbtiType'] as String?,
  summary: json['summary'] as String?,
  detailedDescription: json['detailedDescription'] as String?,
);

Map<String, dynamic> _$QuizResultToJson(_QuizResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quizId': instance.quizId,
      'timestamp': instance.timestamp.toIso8601String(),
      'dimensionalAnalysis': instance.dimensionalAnalysis,
      'mbtiType': instance.mbtiType,
      'summary': instance.summary,
      'detailedDescription': instance.detailedDescription,
    };
