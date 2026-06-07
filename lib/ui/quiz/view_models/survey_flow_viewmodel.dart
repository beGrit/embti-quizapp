import 'package:emombti/app_state/quiz.dart';
import 'package:emombti/data/repositories/quiz/quiz_repository.dart';
import 'package:emombti/domain/models/quiz/survey_models.dart';
import 'package:emombti/utils/command.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';

class SurveyFlowViewModel extends ChangeNotifier {
  SurveyFlowViewModel({
    required this.repository,
    required this.surveyFlowState,
    required this.flowId,
    required this.surveyId,
  }) {
    load = Command0(_load);
    submit = Command0(_submit);
  }

  final QuizRepository repository;
  final QuizState surveyFlowState;
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
      final savedFlow = await repository.getFlowById(flowId);
      final survey = await repository.getSurveyById(surveyId);
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
      await repository.saveFlow(_flow);
      surveyFlowState.updateLatest(_flow);
      notifyListeners();
      _calculateResult();
      return Result.ok(null);
    } catch (e) {
      notifyListeners();
      return Result.error(Exception(e.toString()));
    }
  }

  Future<Result<void>> _calculateResult() async {
    try {
      final answers = _flow.currentAnswers;
      final questions = _survey.questions;

      final List<AxisScore> calculatedScores = await Future(() {
        final Map<PersonalityAxis, double> scoreSums = {};
        final Map<PersonalityAxis, double> maxPossibleSums = {};

        // Initialize trackers for all axes to handle empty or missing axes gracefully
        for (var axis in PersonalityAxis.values) {
          scoreSums[axis] = 0.0;
          maxPossibleSums[axis] = 0.0;
        }

        // Loop through all questions in the survey to calculate totals
        for (var question in questions) {
          final answerValue = answers[question.id];
          if (answerValue == null) continue; // Skip if unanswered

          const double maxGradeValue = 4.0; // Based on AnwserGrade (0 to 4)
          double actualGrade = answerValue.toDouble();

          // Handle reverse-scored questions (e.g., 4 becomes 0, 3 becomes 1)
          if (question.isReversed) {
            actualGrade = maxGradeValue - actualGrade;
          }

          // Apply weight and accumulate values
          scoreSums[question.axis] =
              scoreSums[question.axis]! + (actualGrade * question.weight);
          maxPossibleSums[question.axis] =
              maxPossibleSums[question.axis]! +
              (maxGradeValue * question.weight);
        }

        // Map accumulated sums to the final normalized AxisScore models (0.0 to 1.0)
        return PersonalityAxis.values.map((axis) {
          final double totalScore = scoreSums[axis]!;
          final double maxScore = maxPossibleSums[axis]!;
          final double normalizedValue = maxScore == 0
              ? 0.0
              : (totalScore / maxScore);

          return AxisScore(axis: axis, value: normalizedValue);
        }).toList();
      });

      // 3. Construct and save the final AssessmentResult model
      final assessmentResult = AssessmentResult(
        surveyFlowId: _flow.id,
        scores: calculatedScores,
        timestamp: DateTime.now(),
      );
      await repository.saveAssessmentResult(assessmentResult);
      notifyListeners();
      return Result.ok(null);
    } catch (e) {
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

    // await quizRepository.saveFlow(_flow);
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

  void debugFinishTest() {
    final Map<String, int> newAnswers = {};
    for (final id in _flow.questionOrder) {
      newAnswers[id] = 3; // Neutral score
    }
    _flow = _flow.copyWith(currentAnswers: newAnswers);
    notifyListeners();
    surveyFlowState.updateLatest(_flow);

    if (pageController.hasClients) {
      pageController.jumpToPage(_flow.totalQuestions - 1);
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
