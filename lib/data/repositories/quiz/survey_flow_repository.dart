import '../../../domain/models/quiz/survey_models.dart';

/// Repository responsible for managing the state of an active survey session.
abstract class SurveyFlowRepository {
  Future<SurveyFlow?> getFlowById(String id);

  /// Loads all persisted flows (e.g. in-progress sessions), newest [SurveyFlow.startTime] first.
  ///
  /// When [surveyId] is set, only flows for that survey are returned.
  Future<List<SurveyFlow>> getFlows({String? surveyId});

  /// Persists or updates the state of a [SurveyFlow].
  Future<void> saveFlow(SurveyFlow flow);

  /// Removes the [SurveyFlow] associated with the given survey ID.
  Future<void> deleteFlow(String id);
}
