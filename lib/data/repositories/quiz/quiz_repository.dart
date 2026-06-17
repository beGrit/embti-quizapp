import '../../../domain/models/quiz/survey_models.dart';

/// Repository responsible for managing the state of an active survey session.
abstract class QuizRepository {
  Future<void> sync(String userId);

  Future<void> syncLocalToRemote();

  Future<void> syncRemoteFromLocal();

  /// Retrieves all available personality surveys.
  Future<List<Survey>> getAvailableSurveys();

  /// Fetches a specific survey by its unique ID.
  Future<Survey?> getSurveyById(String id);

  /// Retrieves the history of all completed assessments.
  Future<List<AssessmentResult>> getAssessmentHistory();

  /// Clears local assessment history.
  Future<void> clearHistory();

  Future<SurveyFlow?> getFlowById(String id);

  /// Loads all persisted flows (e.g. in-progress sessions), newest [SurveyFlow.startTime] first.
  ///
  /// When [surveyId] is set, only flows for that survey are returned.
  Future<List<SurveyFlow>> getFlows({String? surveyId});

  /// Persists or updates the state of a [SurveyFlow].
  Future<void> saveFlow(SurveyFlow flow);

  /// Removes the [SurveyFlow] associated with the given survey ID.
  Future<void> deleteFlow(SurveyFlow flow);

  Future<AssessmentResult?> getAssessmentResult(String surveyFlowId);

  Future<void> saveAssessmentResult(AssessmentResult result);
}
