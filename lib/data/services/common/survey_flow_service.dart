import 'package:emombti/app_state/quiz.dart';
import 'package:emombti/data/repositories/quiz/quiz_repository.dart';
import 'package:flutter/foundation.dart';

class SurveyFlowService {
  SurveyFlowService({
    required QuizRepository repository,
    required QuizState state,
  }) : _repository = repository,
       _state = state {
    _init();
  }

  final QuizRepository _repository;
  final QuizState _state;

  Future<void> _init() async {
    try {
      final flows = await _repository.getFlows();
      _state.setSurveyFlows(flows);
    } catch (e) {
      debugPrint('Error initializing SurveyFlowService: $e');
    }
  }
}
