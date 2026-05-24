import 'package:emombti/data/repositories/quiz/survey_flow_repository.dart';
import 'package:emombti/app_state/survey_flow_state.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../../data/repositories/quiz/quiz_repository.dart';
import '../../../domain/models/quiz/survey_models.dart';
import '../../../utils/command.dart';
import '../../../utils/result.dart';

class QuizLandingViewModel extends ChangeNotifier {
  QuizLandingViewModel({
    required QuizRepository repository,
    required SurveyFlowRepository surveyFlowRepository,
    required SurveyFlowState surveyFlowState,
  }) : _surveyFlowRepository = surveyFlowRepository,
       _repository = repository,
       _surveyFlowState = surveyFlowState {
    load = Command0(_load);
    startAssessment = Command0(_startAssessmentAction);
  }

  final QuizRepository _repository;
  final SurveyFlowRepository _surveyFlowRepository;
  final SurveyFlowState _surveyFlowState;

  /// Command to load available surveys.
  late final Command0<void> load;

  late final Command0<Map<String, String>> startAssessment;

  List<Survey> _surveys = [];
  List<Survey> get surveys => _surveys;

  List<SurveyFlow> _surveyFlows = [];
  List<SurveyFlow> get surveyFlows => List.unmodifiable(_surveyFlows);

  bool get hasExistingSurveyFlows => _surveyFlows.isNotEmpty;

  bool _selectionMode = false;
  bool get selectionMode => _selectionMode;

  final Set<String> _selectedFlowIds = <String>{};
  Set<String> get selectedFlowIds => Set.unmodifiable(_selectedFlowIds);

  int get selectedFlowCount => _selectedFlowIds.length;

  bool get allFlowsSelected =>
      _surveyFlows.isNotEmpty &&
      _selectedFlowIds.length == _surveyFlows.length;

  bool isFlowSelected(String flowId) => _selectedFlowIds.contains(flowId);

  void setSelectionMode(bool enabled) {
    _selectionMode = enabled;
    if (!enabled) {
      _selectedFlowIds.clear();
    }
    notifyListeners();
  }

  void toggleFlowSelection(String flowId) {
    if (_selectedFlowIds.contains(flowId)) {
      _selectedFlowIds.remove(flowId);
    } else {
      _selectedFlowIds.add(flowId);
    }
    notifyListeners();
  }

  void toggleSelectAllFlows() {
    if (allFlowsSelected) {
      _selectedFlowIds.clear();
    } else {
      _selectedFlowIds
        ..clear()
        ..addAll(_surveyFlows.map((f) => f.id));
    }
    notifyListeners();
  }

  /// Deletes every checked flow, clears selection, exits selection mode, and reloads.
  Future<void> deleteSelectedSurveyFlows() async {
    final ids = List<String>.from(_selectedFlowIds);
    for (final id in ids) {
      await _surveyFlowRepository.deleteFlow(id);
    }
    _selectedFlowIds.clear();
    _selectionMode = false;
    _surveyFlows = await _surveyFlowRepository.getFlows();
    _surveyFlowState.refresh();
    notifyListeners();
  }

  String surveyTitleForFlow(SurveyFlow flow) {
    for (final s in _surveys) {
      if (s.id == flow.surveyId) return s.title;
    }
    return flow.surveyId;
  }

  /// Removes a saved session from local storage and refreshes [surveyFlows].
  Future<void> deleteSurveyFlow(String flowId) async {
    await _surveyFlowRepository.deleteFlow(flowId);
    _selectedFlowIds.remove(flowId);
    _surveyFlows = await _surveyFlowRepository.getFlows();
    if (_surveyFlows.isEmpty) {
      _selectionMode = false;
    }
    notifyListeners();
  }

  Future<Result<void>> _load() async {
    try {
      final surveys = await _repository.getAvailableSurveys();
      final flows = await _surveyFlowRepository.getFlows();
      _surveys = surveys;
      _surveyFlows = flows;
      _selectedFlowIds.removeWhere(
        (id) => !_surveyFlows.any((f) => f.id == id),
      );
      if (_surveyFlows.isEmpty) {
        _selectionMode = false;
      }
      notifyListeners();
      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  Future<Result<Map<String, String>>> _startAssessmentAction() async {
    // Ensure data is loaded before starting
    if (_surveys.isEmpty) {
      final result = await _load();
      if (result is Error) return Result.error(result.error);
    }

    if (_surveys.isNotEmpty) {
      SurveyFlow newSurveyFlow = _genNewSurveyFlow(_surveys[0]);
      await _surveyFlowRepository.saveFlow(newSurveyFlow);
      await _surveyFlowState.refresh();
      return Result.ok({
        'flowId': newSurveyFlow.id,
        'surveyId': _surveys[0].id,
      });
    }

    return Result.error(Exception('No available assessments found.'));
  }

  SurveyFlow _genNewSurveyFlow(Survey survey, {bool shuffle = false}) {
    List<String> ids = survey.questions.map((q) => q.id).toList();
    if (shuffle) ids.shuffle();

    return SurveyFlow(
      id: const Uuid().v4(), // Generate a unique ID for this flow
      surveyId: survey.id,
      status: SurveyFlowStatus.inProgress,
      startTime: DateTime.now(),
      totalQuestions: survey.questions.length,
      questionOrder: ids,
    );
  }
}
