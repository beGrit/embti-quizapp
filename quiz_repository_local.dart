import 'dart:convert';

import 'package:emombti/domain/models/quiz/personality_models.dart';
import 'package:flutter/services.dart';

import 'quiz_repository.dart';

/// A local implementation of [QuizRepository] that handles data in-memory or
/// via local persistent storage (e.g., Hive, SharedPreferences, or SQLite).
class QuizRepositoryLocal implements QuizRepository {
  // Mock internal storage for demonstration.
  // In a production app, replace these with a local database service.
  final List<AssessmentResult> _history = [];

  @override
  Future<List<Survey>> getAvailableSurveys() async {
    try {
      // Load the string from assets
      final String jsonString = await rootBundle.loadString(
        'assets/json/mock_quiz.json',
      );
      // Decode the JSON list
      final List<dynamic> jsonList = json.decode(jsonString);
      // Map to Survey objects using the generated fromJson
      return jsonList.map((json) => Survey.fromJson(json)).toList();
    } catch (e) {
      // In a real application, consider more robust error handling or logging
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
        final String jsonString = await rootBundle.loadString(
          'assets/json/mock_assessment_result.json',
        );
        final List<dynamic> jsonList = json.decode(jsonString);
        final results = jsonList
            .map((j) => AssessmentResult.fromJson(j))
            .toList();
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
