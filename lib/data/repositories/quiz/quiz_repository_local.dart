import 'package:emombti/domain/models/quiz/survey_models.dart';
import 'package:flutter/cupertino.dart';

import '../../services/persistence/local/local_data_service.dart';
import '../../services/persistence/local/local_data_sqlite_service.dart';
import 'quiz_repository.dart';

/// Local [QuizRepository]: surveys from assets, submissions in SQLite.
class QuizRepositoryLocal extends QuizRepository {
  QuizRepositoryLocal({
    LocalDataService? localDataService,
    LocalDataSqliteService? localDataSqliteService,
  }) : _localDataService = localDataService ?? LocalDataService(),
       _localDataSqliteService =
           localDataSqliteService ?? LocalDataSqliteService();

  final LocalDataService _localDataService;
  final LocalDataSqliteService _localDataSqliteService;

  @override
  Future<List<Survey>> getAvailableSurveys() async {
    try {
      return await _localDataService.getQuizzes();
    } catch (e) {
      debugPrint('Error loading surveys: $e');
      return [];
    }
  }

  @override
  Future<Survey?> getSurveyById(String id) async {
    final surveys = await getAvailableSurveys();
    try {
      return surveys.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<AssessmentResult> submitResponse(SurveyResponse response) async {
    final survey = await getSurveyById(response.surveyId);

    if (survey == null) {
      throw Exception('Survey with ID ${response.surveyId} not found.');
    }

    final result = AssessmentResult(
      surveyFlowId: response.surveyFlowId,
      scores: <AxisScore>[],
      timestamp: DateTime.now(),
    );

    await _localDataSqliteService.saveSubmission(response, result);

    return result;
  }

  @override
  Future<List<AssessmentResult>> getAssessmentHistory() async {
    try {
      return await _localDataSqliteService.getAllAssessmentResults();
    } catch (e) {
      debugPrint('Error loading assessment history: $e');
      return [];
    }
  }

  @override
  Future<void> clearHistory() async {
    await _localDataSqliteService.clearAssessmentHistory();
  }
}
