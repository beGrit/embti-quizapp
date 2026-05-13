import 'package:emombti/domain/models/quiz/personality_models.dart';

import '../../services/local/local_data_service.dart';
import 'quiz_repository.dart';

/// A local implementation of [QuizRepository] that handles data in-memory or
/// via local persistent storage (e.g., Hive, SharedPreferences, or SQLite).
class QuizRepositoryLocal extends QuizRepository {
  // Mock internal storage for demonstration.
  // In a production app, replace these with a local database service.
  QuizRepositoryLocal({LocalDataService? localDataService})
    : _localDataService = localDataService ?? LocalDataService();

  final LocalDataService _localDataService;
  final List<AssessmentResult> _history = [];

  @override
  Future<List<Survey>> getAvailableSurveys() async {
    try {
      return await _localDataService.getQuizzes();
    } catch (e) {
      // In a real application, consider more robust error handling or logging
      // In a real application, consider more robust error handling
      print('Error loading surveys: $e');
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

    // Utilize the PersonalityEngine logic provided in personality_models.dart
    final result = PersonalityEngine.process(survey, response);

    // Save to local history
    _history.insert(0, result);

    // TODO: Persist to disk here (e.g., await _storage.save(result))

    return result;
  }

  @override
  Future<List<AssessmentResult>> getAssessmentHistory() async {
    if (_history.isEmpty) {
      try {
        final results = await _localDataService.getAssessmentResults();
        _history.addAll(results);
      } catch (e) {
        // Handle or log error if the asset is missing or malformed
        print('Error loading assessment history: $e');
      }
    }
    return List.unmodifiable(
      _history..sort((a, b) => b.timestamp.compareTo(a.timestamp)),
    );
  }

  @override
  Future<void> clearHistory() async {
    _history.clear();
    // TODO: Clear disk storage
  }
}
