import 'package:flutter/foundation.dart';
import 'package:emombti/domain/models/quiz/survey_models.dart';

class SurveyFlowState extends ChangeNotifier {
  SurveyFlowState();

  List<SurveyFlow> _surveyFlows = [];
  List<SurveyFlow> get surveyFlows => _surveyFlows;

  SurveyFlow? _latest;
  SurveyFlow? get latest => _latest;

  void setSurveyFlows(List<SurveyFlow> flows) {
    _surveyFlows = flows;
    _latest = _surveyFlows.isEmpty ? null : _surveyFlows.first;
    notifyListeners();
  }

  void updateLatest(SurveyFlow flow) {
    // Only update if this is the flow currently tracked as latest.
    // This prevents older sessions from displacing the newest started flow in the FAB.
    if (_latest != null && _latest!.id == flow.id) {
      _latest = flow;
      notifyListeners();
    }
  }

  void clearLatest() {
    _latest = null;
    notifyListeners();
  }
}
