import 'package:emombti/domain/models/quiz/survey_models.dart';
import 'package:emombti/app_state/quiz.dart';
import 'package:emombti/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// Circular progress for the most recently started [SurveyFlow], with tap to resume.
class KnowledgeContentsSlideshowSurveyFlowBar extends StatelessWidget {
  const KnowledgeContentsSlideshowSurveyFlowBar({super.key});

  Future<void> _openFlow(BuildContext context, SurveyFlow flow) async {
    await context.push(
      Uri(
        path: Routes.surveyFlow,
        queryParameters: {'flowId': flow.id, 'surveyId': flow.surveyId},
      ).toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      elevation: 4,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: theme.colorScheme.primaryContainer,
      child: Consumer<QuizState>(
        builder: (context, state, _) {
          final flow = state.latest;
          if (flow == null) return const SizedBox.shrink();

          return InkWell(
            onTap: () => _openFlow(context, flow),
            customBorder: const CircleBorder(),
            child: Tooltip(
              message: 'Resume quiz · ${flow.completionPercentage}% complete',
              child: SizedBox(
                width: 64,
                height: 64,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      constraints: const BoxConstraints(
                        minHeight: 48,
                        minWidth: 48,
                      ),
                      value: flow.completionRate,
                      strokeWidth: 3.5,
                      backgroundColor: theme.colorScheme.surfaceContainer,
                      color: theme.colorScheme.onPrimaryContainer,
                      strokeCap: StrokeCap.round,
                    ),
                    Text(
                      '${flow.completionPercentage}%',
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
