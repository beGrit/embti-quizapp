import 'package:flutter/foundation.dart';
import 'package:emombti/domain/models/quiz/survey_models.dart';
import 'package:emombti/data/repositories/quiz/survey_flow_repository.dart';

class SurveyFlowState extends ChangeNotifier {
  SurveyFlowState({required SurveyFlowRepository repository})
      : _repository = repository;

  final SurveyFlowRepository _repository;

  SurveyFlow? _latest;
  SurveyFlow? get latest => _latest;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> refresh() async {
    _isLoading = true;
    notifyListeners();

    try {
      final flows = await _repository.getFlows();
      _latest = flows.isEmpty ? null : flows.first;
    } catch (e) {
      debugPrint('Error refreshing SurveyFlowState: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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
