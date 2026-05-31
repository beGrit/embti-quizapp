import 'package:emombti/app_state/survey_flow_state.dart';
import 'package:emombti/data/repositories/quiz/quiz_repository.dart';
import 'package:emombti/data/repositories/quiz/survey_flow_repository.dart';
import 'package:emombti/domain/models/quiz/survey_models.dart';
import 'package:emombti/utils/command.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';

class SurveyFlowViewModel extends ChangeNotifier {
  SurveyFlowViewModel({
    required this.surveyFlowRepository,
    required this.quizRepository,
    required this.surveyFlowState,
    required this.flowId,
    required this.surveyId,
  }) {
    load = Command0(_load);
    submit = Command0(_submit);
  }

  final SurveyFlowRepository surveyFlowRepository;
  final QuizRepository quizRepository;
  final SurveyFlowState surveyFlowState;
  final String flowId;
  final String surveyId;

  Survey _survey = Survey(id: '', title: '', questions: []);
  SurveyFlow _flow = SurveyFlow(id: '', surveyId: '');

  SurveyFlow get flow => _flow;

  late final Command0<void> load;
  late final Command0<void> submit;

  final PageController pageController = PageController();

  Future<Result<void>> _load() async {
    try {
      final savedFlow = await surveyFlowRepository.getFlowById(flowId);
      final survey = await quizRepository.getSurveyById(surveyId);
      if (savedFlow != null && survey != null) {
        _flow = savedFlow;
        _survey = survey;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (pageController.hasClients) {
            final lastIndex = _flow.currentAnswers.length;
            if (lastIndex > 0 && lastIndex < _flow.totalQuestions) {
              pageController.jumpToPage(lastIndex);
            }
          }
        });
        notifyListeners();
        return Result.ok(null);
      } else {
        throw Exception('Flow or survey not found.');
      }
    } catch (e) {
      notifyListeners();
      return Result.error(Exception(e.toString()));
    }
  }

  Future<Result<void>> _submit() async {
    try {
      _flow = _flow.copyWith(status: SurveyFlowStatus.completed);
      await surveyFlowRepository.saveFlow(_flow);
      surveyFlowState.updateLatest(_flow);
      notifyListeners();
      return Result.ok(null);
    } catch (e) {
      notifyListeners();
      return Result.error(Exception(e.toString()));
    }
  }

  void toggleScore(String questionId, int? score) async {
    final newAnswers = Map<String, int>.from(_flow.currentAnswers);

    if (score == null) {
      newAnswers.remove(questionId);
    } else {
      newAnswers[questionId] = score;
    }

    _flow = _flow.copyWith(currentAnswers: newAnswers);
    notifyListeners();

    // await surveyFlowRepository.saveFlow(_flow);
    surveyFlowState.updateLatest(_flow);

    if (score != null) {
      final currentIndex = pageController.page?.round() ?? 0;
      if (currentIndex < _flow.totalQuestions - 1) {
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  void jumpToQuestion(int index) {
    if (pageController.hasClients) {
      pageController.jumpToPage(index);
    }
  }

  String getQuestionId(int index) => _flow.questionOrder[index];

  Question getQuestion(int index) {
    final id = getQuestionId(index);
    return _survey.questions.firstWhere((q) => q.id == id);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
