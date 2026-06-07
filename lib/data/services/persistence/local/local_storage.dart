import 'package:emombti/domain/models/content/content.dart';
import 'package:emombti/domain/models/quiz/survey_models.dart';

abstract class LocalStorage {
  // Content
  Future<List<Content>> getMockFeed();
  Future<List<ArticleContent>> getArticleContents();
  Future<ArticleContent?> getArticleContentById(String id);
  Future<List<VideoContent>> getVideoContents();
  Future<List<KnowledgeContent>> getKnowledgeContents();
  Future<List<BannerContent>> getBannerContents();

  // Quiz
  Future<List<Survey>> getQuizzes();
  Future<List<AssessmentResult>> getAssessmentResults();
  Future<Survey?> getSurvey(String id);
  Future<void> saveFlow(SurveyFlow flow);
  Future<SurveyFlow?> getFlow(String id);
  Future<List<SurveyFlow>> getFlows({String? surveyId});
  Future<void> deleteFlow(String id);
  Future<void> saveResult(AssessmentResult result);
  Future<List<AssessmentResult>> getAllAssessmentResults();
  Future<AssessmentResult?> getAssessmentResult(String surveyFlowId);
  Future<void> clearAssessmentHistory();
  Future<void> saveSubmission(AssessmentResult result);
}
