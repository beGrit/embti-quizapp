import 'package:emombti/domain/models/quiz/personality_models.dart';

/// Repository interface for managing personality quizzes and results.
abstract class QuizRepository {
  /// Retrieves all available personality surveys.
  Future<List<Survey>> getAvailableSurveys();

  /// Fetches a specific survey by its unique ID.
  Future<Survey?> getSurveyById(String id);

  /// Processes a user's response and saves the resulting assessment.
  ///
  /// Returns the computed [AssessmentResult].
  Future<AssessmentResult> submitResponse(SurveyResponse response);

  /// Retrieves the history of all completed assessments.
  Future<List<AssessmentResult>> getAssessmentHistory();

  /// Clears local assessment history.
  Future<void> clearHistory();
}
