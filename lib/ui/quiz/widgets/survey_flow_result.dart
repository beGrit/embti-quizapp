import 'package:emombti/ui/quiz/view_models/quiz_landing_viewmodel.dart';
import 'package:flutter/material.dart';

class SurveyFlowResult extends StatefulWidget {
  const SurveyFlowResult({super.key, required this.viewModel});

  final QuizLandingViewModel viewModel;

  @override
  State<SurveyFlowResult> createState() => _SurveyFlowResultState();
}

class _SurveyFlowResultState extends State<SurveyFlowResult> {
  @override
  Widget build(BuildContext context) {
    return Text('Survey Flow Result.');
  }
}
