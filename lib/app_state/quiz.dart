import 'package:emombti/data/repositories/quiz/quiz_repository.dart';
import 'package:emombti/domain/models/quiz/survey_models.dart';
import 'package:flutter/foundation.dart';

class QuizState extends ChangeNotifier {
  final QuizRepository repository;

  QuizState({required this.repository});

  List<SurveyFlow> _surveyFlows = [];
  List<SurveyFlow> get surveyFlows => _surveyFlows;

  SurveyFlow? _latest;
  SurveyFlow? get latest => _latest;

  SurveyFlow? _latestCompleted;
  SurveyFlow? get latestCompleted => _latestCompleted;
  bool get hasLatestCompleted => _latestCompleted != null;

  SurveyFlow? getSurveyFlowById(String id) {
    return _surveyFlows.where((flow) => flow.id == id).firstOrNull;
  }

  void setSurveyFlows(List<SurveyFlow> flows) {
    _surveyFlows = flows;
    _setUpLatest();
    notifyListeners();
  }

  void removeSurveyFlow(SurveyFlow flow) {
    _surveyFlows.removeWhere((__) => __.id == flow.id);
    _setUpLatest();
    notifyListeners();
  }

  void _setUpLatest() {
    _latest = _surveyFlows.isEmpty ? null : _surveyFlows.first;
    _latestCompleted = _surveyFlows
        .where((flow) => flow.status == SurveyFlowStatus.completed)
        .firstOrNull;
  }

  void updateLatest(SurveyFlow flow) {
    // Only update if this is the flow currently tracked as latest.
    // This prevents older sessions from displacing the newest started flow in the FAB.
    if (_latest != null && _latest!.id == flow.id) {
      _latest = flow;
      notifyListeners();
    }
  }

  void updateLatestCompleted(SurveyFlow flow) {
    _latestCompleted = flow;
    notifyListeners();
  }

  void clearLatest() {
    _latest = null;
    notifyListeners();
  }
}
