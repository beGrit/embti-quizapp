import 'package:emombti/app_state/auth.dart';
import 'package:emombti/app_state/quiz.dart';
import 'package:emombti/data/repositories/quiz/quiz_repository.dart';
import 'package:emombti/domain/constants/status.dart';
import 'package:emombti/manager/sync_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/models/quiz/survey_models.dart';
import '../../../utils/command.dart';
import '../../../utils/result.dart';

enum QuizLandingPageMode { unknown, read, edit }

class QuizLandingViewModel extends ChangeNotifier {
  QuizLandingViewModel({
    required QuizRepository repository,
    required QuizRepository surveyFlowRepository,
    required QuizState quizState,
    required AuthState authState,
    required SyncManager syncManager,
  }) : _repository = surveyFlowRepository,
       _quizState = quizState,
       _syncManager = syncManager,
       _authState = authState {
    load = Command0(_load);
    startAssessment = Command0(_startAssessmentAction);
    loadAssessmentResult = Command0(_loadAssessmentResult);
    sync = Command0(_syncAction);
    quizState.addListener(loadAssessmentResult.execute);

    // Find existing job if any
    _activeSyncJob = _syncManager.jobs.cast<SyncJob?>().firstWhere(
      (j) => j?.key == 'sync_quiz_repository',
      orElse: () => null,
    );
    _activeSyncJob?.addListener(notifyListeners);
  }

  final QuizRepository _repository;
  final QuizState _quizState;
  final SyncManager _syncManager;
  final AuthState _authState;
  SyncJob? _activeSyncJob;

  @override
  void dispose() {
    _activeSyncJob?.removeListener(notifyListeners);
    _quizState.removeListener(loadAssessmentResult.execute);
    super.dispose();
  }

  /// Command to load available surveys.
  late final Command0<void> load;

  late final Command0<Map<String, String>> startAssessment;

  late final Command0<AssessmentResult?> loadAssessmentResult;

  late final Command0<void> sync;

  SyncStatus get quizSyncStatus => _activeSyncJob?.status ?? SyncStatus.none;

  String? get quizSyncError => _activeSyncJob?.error;
  List<Survey> _surveys = [];
  List<Survey> get surveys => _surveys;

  bool get hasExistingSurveyFlows => _quizState.surveyFlows.isNotEmpty;

  bool _selectionMode = false;
  bool get selectionMode => _selectionMode;

  final Set<String> _selectedFlowIds = <String>{};
  Set<String> get selectedFlowIds => Set.unmodifiable(_selectedFlowIds);

  int get selectedFlowCount => _selectedFlowIds.length;

  bool get allFlowsSelected =>
      _quizState.surveyFlows.isNotEmpty &&
      _selectedFlowIds.length == _quizState.surveyFlows.length;

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
        ..addAll(_quizState.surveyFlows.map((f) => f.id));
    }
    notifyListeners();
  }

  /// Deletes every checked flow, clears selection, exits selection mode, and reloads.
  Future<void> deleteSelectedSurveyFlows() async {
    final ids = List<String>.from(_selectedFlowIds);
    for (final id in ids) {
      SurveyFlow? surveyFlow = _quizState.getSurveyFlowById(id);
      surveyFlow = surveyFlow?.copyWith(userId: _authState.userId);
      if (surveyFlow != null) {
        _quizState.removeSurveyFlow(surveyFlow);
        await _repository.deleteFlow(surveyFlow);
      }
    }
    _selectedFlowIds.clear();
    _selectionMode = false;
    await _refreshSurveyFlows();
    notifyListeners();
  }

  /// Removes a saved session from local storage and refreshes [surveyFlows].
  Future<void> deleteSurveyFlow(SurveyFlow flow) async {
    flow = flow.copyWith(userId: _authState.userId);
    _selectedFlowIds.remove(flow.id);
    _quizState.removeSurveyFlow(flow);
    if (_quizState.surveyFlows.isEmpty) {
      _selectionMode = false;
    }
    notifyListeners();
    await _repository.deleteFlow(flow);
  }

  Future<Result<void>> _load() async {
    try {
      final surveys = await _repository.getAvailableSurveys();
      _surveys = surveys;

      await _refreshSurveyFlows();

      _selectedFlowIds.removeWhere(
        (id) => !_quizState.surveyFlows.any((f) => f.id == id),
      );
      if (_quizState.surveyFlows.isEmpty) {
        _selectionMode = false;
      }
      notifyListeners();
      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }

  Future<void> _refreshSurveyFlows() async {
    try {
      final flows = await _repository.getFlows();
      _quizState.setSurveyFlows(flows);
    } catch (e) {
      debugPrint('Error fetching survey flows: $e');
    }
  }

  Future<Result<Map<String, String>>> _startAssessmentAction() async {
    // Ensure data is loaded before starting
    if (surveys.isEmpty) {
      final result = await _load();
      if (result is Error) return Result.error(result.error);
    }

    if (surveys.isNotEmpty) {
      SurveyFlow newSurveyFlow = _genNewSurveyFlow(surveys[0]);
      await _repository.saveFlow(newSurveyFlow);
      await _refreshSurveyFlows();
      return Result.ok({'flowId': newSurveyFlow.id, 'surveyId': surveys[0].id});
    }

    return Result.error(Exception('No available assessments found.'));
  }

  SurveyFlow _genNewSurveyFlow(Survey survey, {bool shuffle = false}) {
    List<String> ids = survey.questions.map((q) => q.id).toList();
    if (shuffle) ids.shuffle();

    return SurveyFlow(
      id: const Uuid().v4(), // Generate a unique ID for this flow
      userId: _authState.userId,
      surveyId: survey.id,
      status: SurveyFlowStatus.inProgress,
      startTime: DateTime.now(),
      totalQuestions: survey.questions.length,
      questionOrder: ids,
      synchronized: false,
    );
  }

  Future<Result<AssessmentResult?>> _loadAssessmentResult() async {
    final latestCompleted = _quizState.latestCompleted;
    if (latestCompleted != null) {
      final result = await _repository.getAssessmentResult(latestCompleted.id);
      return Result.ok(result);
    } else {
      return Result.error(Exception('No completed assessment found.'));
    }
  }

  Future<Result<void>> _syncAction() async {
    try {
      final job = SyncJob(
        id: 'sync_quiz_${DateTime.now().millisecondsSinceEpoch}',
        key: 'sync_quiz_repository',
        type: SyncType.localToRemote,
        payload: () => _repository.sync(_authState.userId ?? ''),
      );

      _activeSyncJob?.removeListener(notifyListeners);
      _activeSyncJob = job;
      _activeSyncJob?.addListener(notifyListeners);

      await _syncManager.addSyncJob(job, unique: true, override: true);
      return Result.ok(null);
    } catch (e) {
      return Result.error(Exception(e.toString()));
    }
  }
}
