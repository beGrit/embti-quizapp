import 'package:emombti/data/services/persistence/local/local_storage.dart';
import 'package:emombti/domain/models/quiz/survey_models.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import 'quiz_repository.dart';

/// Local implementation of [QuizRepository] backed by SQLite
class QuizRepositoryDev extends ChangeNotifier implements QuizRepository {
  final LocalStorage localStorage;
  final _log = Logger('QuizRepositoryDev');

  QuizRepositoryDev({required this.localStorage});

  @override
  Future<List<Survey>> getAvailableSurveys() async {
    try {
      return await localStorage.getQuizzes();
    } catch (e) {
      debugPrint('Error loading surveys: $e');
      return [];
    }
  }

  @override
  Future<Survey?> getSurveyById(String id) => localStorage.getSurvey(id);

  @override
  Future<List<AssessmentResult>> getAssessmentHistory() async {
    try {
      return await localStorage.getAllAssessmentResults();
    } catch (e) {
      debugPrint('Error loading assessment history: $e');
      return [];
    }
  }

  @override
  Future<void> clearHistory() async {
    await localStorage.clearAssessmentHistory();
  }

  @override
  Future<SurveyFlow?> getFlowById(String id) => localStorage.getFlow(id);

  @override
  Future<List<SurveyFlow>> getFlows({String? surveyId}) =>
      localStorage.getFlows(surveyId: surveyId);

  @override
  Future<void> saveFlow(SurveyFlow flow) => localStorage.saveFlow(flow);

  @override
  Future<void> deleteFlow(String id) => localStorage.deleteFlow(id);

  @override
  Future<AssessmentResult?> getAssessmentResult(String surveyFlowId) {
    return localStorage.getAssessmentResult(surveyFlowId);
  }

  @override
  Future<void> saveAssessmentResult(AssessmentResult result) {
    return localStorage.saveResult(result);
  }

  @override
  Future<void> syncLocalToRemote() async {
    _log.info('Syncing local to remote');
  }

  @override
  Future<void> syncRemoteFromLocal() async {}
}
