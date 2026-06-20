import 'package:emombti/domain/models/content/content.dart';
import 'package:emombti/domain/models/quiz/survey_models.dart';

import 'local_storage.dart';
import 'local_storage_file.dart';
import 'local_storage_sqlite.dart';

class LocalStorageFacade implements LocalStorage {
  final LocalStorageSqlite sqlite;
  final LocalStorageFile file;

  LocalStorageFacade({required this.sqlite, required this.file});

  // Content (delegated to sqlite/assets)
  @override
  Future<List<Content>> getMockFeed() => sqlite.getMockFeed();

  @override
  Future<List<ArticleContent>> getArticleContents() =>
      sqlite.getArticleContents();

  @override
  Future<ArticleContent?> getArticleContentById(String id) =>
      sqlite.getArticleContentById(id);

  @override
  Future<List<VideoContent>> getVideoContents() => sqlite.getVideoContents();

  @override
  Future<List<KnowledgeContent>> getKnowledgeContents() =>
      sqlite.getKnowledgeContents();

  @override
  Future<List<BannerContent>> getBannerContents() => sqlite.getBannerContents();

  @override
  Future<void> switchUser(String? userId) => sqlite.switchUser(userId);

  // Quiz - Surveys (delegated to file)
  @override
  Future<List<Survey>> getQuizzes() => file.getQuizzes();

  @override
  Future<Survey?> getSurvey(String id) => file.getSurvey(id);

  @override
  Future<void> saveSurvey(Survey survey) => file.saveSurvey(survey);

  @override
  Future<void> deleteSurvey(String id) => file.deleteSurvey(id);

  // Quiz - Flows & Results (delegated to sqlite)
  @override
  Future<List<AssessmentResult>> getAssessmentResults() =>
      sqlite.getAssessmentResults();

  @override
  Future<void> saveFlow(SurveyFlow flow) => sqlite.saveFlow(flow);

  @override
  Future<SurveyFlow?> getFlow(String id) => sqlite.getFlow(id);

  @override
  Future<List<SurveyFlow>> getFlows({String? surveyId}) =>
      sqlite.getFlows(surveyId: surveyId);

  @override
  Future<void> deleteFlow(String id) => sqlite.deleteFlow(id);

  @override
  Future<void> saveResult(AssessmentResult result) => sqlite.saveResult(result);

  @override
  Future<List<AssessmentResult>> getAllAssessmentResults() =>
      sqlite.getAllAssessmentResults();

  @override
  Future<AssessmentResult?> getAssessmentResult(String surveyFlowId) =>
      sqlite.getAssessmentResult(surveyFlowId);

  @override
  Future<void> clearAssessmentHistory() => sqlite.clearAssessmentHistory();

  @override
  Future<void> saveSubmission(AssessmentResult result) =>
      sqlite.saveSubmission(result);

  @override
  Future<String> loadPolicy(String policyType) => file.loadPolicy(policyType);
}
