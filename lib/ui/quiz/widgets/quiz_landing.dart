import 'package:emombti/routing/routes.dart';
import 'package:emombti/ui/core/ui/widgets/app_bar.dart';
import 'package:emombti/ui/quiz/view_models/quiz_landing_viewmodel.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuizLandingScreen extends StatefulWidget {
  const QuizLandingScreen({super.key, required this.viewModel});

  final QuizLandingViewModel viewModel;

  @override
  State<QuizLandingScreen> createState() => _QuizLandingScreenState();
}

class _QuizLandingScreenState extends State<QuizLandingScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.startAssessment.addListener(_onStartAssessmentChanged);
    widget.viewModel.load.execute();
  }

  @override
  void dispose() {
    widget.viewModel.startAssessment.removeListener(_onStartAssessmentChanged);
    super.dispose();
  }

  void _onStartAssessmentChanged() {
    final result = widget.viewModel.startAssessment.result;
    if (result is Ok<String>) {
      context.push('${Routes.quizLanding}/${result.value}');
      widget.viewModel.startAssessment.clearResult();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: StandardAppBar(
        title: 'Quiz',
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.psychology_outlined,
                size: 120,
                color: Colors.blueAccent,
              ),
              Text(
                'Discover YourSelf',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '  This assessment analyzes your cognitive functions to help you understand your personality type, strengths, and communication style.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 32),
              ListenableBuilder(
                listenable: widget.viewModel.startAssessment,
                builder: (context, child) {
                  return FilledButton(
                    onPressed: widget.viewModel.startAssessment.running
                        ? null
                        : () => widget.viewModel.startAssessment.execute(),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: widget.viewModel.startAssessment.running
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Start Assessment'),
                  );
                },
              ),
              const SizedBox(height: 24),
              _buildInstruction(
                context,
                Icons.timer_outlined,
                'Takes approximately 5-10 minutes',
              ),
              _buildInstruction(
                context,
                Icons.bolt,
                'Answer honestly and intuitively for best results',
              ),
              _buildInstruction(
                context,
                Icons.history_edu,
                'Your results will be saved to your profile',
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstruction(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
