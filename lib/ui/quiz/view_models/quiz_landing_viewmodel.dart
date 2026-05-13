import 'package:flutter/foundation.dart';
import '../../../data/repositories/quiz/quiz_repository.dart';
import '../../../domain/models/quiz/personality_models.dart';
import '../../../utils/command.dart';
import '../../../utils/result.dart';

class QuizLandingViewModel extends ChangeNotifier {
  QuizLandingViewModel({required QuizRepository repository})
    : _repository = repository {
    load = Command0(_load);
    startAssessment = Command0(_startAssessmentAction);
  }

  final QuizRepository _repository;

  /// Command to load available surveys.
  late final Command0<void> load;

  /// Command to handle the "Start Assessment" action.
  /// Returns the ID of the survey to start.
  late final Command0<String> startAssessment;

  List<Survey> _surveys = [];
  List<Survey> get surveys => _surveys;

  Future<Result<void>> _load() async {
    try {
      _surveys = await _repository.getAvailableSurveys();
      notifyListeners();
      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  Future<Result<String>> _startAssessmentAction() async {
    // Ensure data is loaded before starting
    if (_surveys.isEmpty) {
      final result = await _load();
      if (result is Error) return Result.error((result as Error).error);
    }

    if (_surveys.isNotEmpty) {
      // Return the first survey ID to navigate to
      // Usually "mbti_basic" based on provided mock data
      return Result.ok(_surveys.first.id);
    }

    return Result.error(Exception('No available assessments found.'));
  }
}
