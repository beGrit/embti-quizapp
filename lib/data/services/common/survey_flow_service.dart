import 'package:emombti/app_state/survey_flow_state.dart';
import 'package:emombti/data/repositories/quiz/survey_flow_repository.dart';
import 'package:flutter/foundation.dart';

class SurveyFlowService {
  SurveyFlowService({
    required SurveyFlowRepository repository,
    required SurveyFlowState state,
  }) : _repository = repository,
       _state = state {
    _init();
  }

  final SurveyFlowRepository _repository;
  final SurveyFlowState _state;

  Future<void> _init() async {
    try {
      final flows = await _repository.getFlows();
      _state.setSurveyFlows(flows);
    } catch (e) {
      debugPrint('Error initializing SurveyFlowService: $e');
    }
  }
}
