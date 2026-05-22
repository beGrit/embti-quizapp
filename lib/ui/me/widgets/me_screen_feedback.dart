import 'package:emombti/ui/core/ui/widgets/app_bar.dart';
import 'package:emombti/ui/me/view_models/me_screen_feedback_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MeFeedbackScreen extends StatelessWidget {
  const MeFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MeFeedbackViewModel(),
      child: const _MeFeedbackScreenContent(),
    );
  }
}

class _MeFeedbackScreenContent extends StatelessWidget {
  const _MeFeedbackScreenContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MeFeedbackViewModel>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: StandardAppBar(title: 'Help & Feedback'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Score', style: theme.textTheme.titleMedium),
            Slider(
              value: viewModel.score,
              min: 0,
              max: 10,
              divisions: 10,
              label: viewModel.score.round().toString(),
              onChanged: (value) => viewModel.score = value,
            ),
            const SizedBox(height: 24),
            Text('Issue Feedback', style: theme.textTheme.titleMedium),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              onChanged: viewModel.updateTitle,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              onChanged: viewModel.updateDescription,
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ListenableBuilder(
                listenable: viewModel.submitCommand,
                builder: (context, _) {
                  return FilledButton(
                    onPressed: viewModel.submitCommand.running
                        ? null
                        : () async {
                            await viewModel.submitCommand.execute();
                            if (context.mounted) {
                              if (viewModel.submitCommand.completed) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Feedback submitted!'),
                                  ),
                                );
                                Navigator.of(context).pop();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Failed to submit feedback.'),
                                  ),
                                );
                              }
                            }
                          },
                    child: viewModel.submitCommand.running
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Submit'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
