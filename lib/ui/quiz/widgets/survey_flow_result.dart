import 'package:emombti/domain/models/quiz/survey_models.dart';
import 'package:emombti/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class SurveyFlowResult extends StatefulWidget {
  const SurveyFlowResult({super.key, required this.pResult, this.onGoBack});

  final AssessmentResult pResult;
  final VoidCallback? onGoBack;

  @override
  State<SurveyFlowResult> createState() => _SurveyFlowResultState();
}

class _SurveyFlowResultState extends State<SurveyFlowResult> {
  late final AssessmentResult result;

  @override
  void initState() {
    super.initState();
    result = widget.pResult;
  }

  // Helper method to get the titles of the two poles for each axis
  Map<String, String> _getAxisLabels(PersonalityAxis axis) {
    switch (axis) {
      case PersonalityAxis.axis1:
        return {'left': 'Introversion (I)', 'right': 'Extraversion (E)'};
      case PersonalityAxis.axis2:
        return {'left': 'Sensing (S)', 'right': 'Intuition (N)'};
      case PersonalityAxis.axis3:
        return {'left': 'Thinking (T)', 'right': 'Feeling (F)'};
      case PersonalityAxis.axis4:
        return {'left': 'Judging (J)', 'right': 'Perceiving (P)'};
    }
  }

  // Generates the 4-letter MBTI code based on the scores
  String _calculateMBTICode() {
    StringBuffer code = StringBuffer();
    for (var score in result.scores) {
      final labels = _getAxisLabels(score.axis);
      if (score.value < 0.5) {
        code.write(labels['left']!.characters.lastWhere((c) => c != ')'));
      } else {
        code.write(labels['right']!.characters.lastWhere((c) => c != ')'));
      }
    }
    return code.toString().replaceAll(RegExp(r'[^\w]'), '');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mbtiCode = _calculateMBTICode();
    final formattedDate = DateFormat(
      'yyyy-MM-dd HH:mm',
    ).format(result.timestamp);

    return CustomScrollView(
      slivers: [
        // 2. Main Content Body wrapped inside a SliverPadding & SliverList
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // --- HEADER BLOCK: MBTI Type Display ---
              Card(
                elevation: 0,
                color: theme.colorScheme.primaryContainer.withAlpha(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 32.0,
                    horizontal: 16.0,
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Your Personality Type',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        mbtiCode,
                        style: theme.textTheme.displayLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                          letterSpacing: 4,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Completed on $formattedDate',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant.withAlpha(
                            150,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // --- ACTION BUTTONS ---
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FilledButton.icon(
                    onPressed: () {
                      final mbtiCode = _calculateMBTICode();
                      context.push(
                        Routes.userInfo,
                        extra: {'mbtiType': mbtiCode},
                      );
                    },
                    icon: const Icon(Icons.person_outline),
                    label: const Text('Make as Your Type'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () =>
                        widget.onGoBack != null ? widget.onGoBack!() : null,
                    icon: const Icon(Icons.check),
                    label: const Text('Go back'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                'Personality Dimension Breakdown',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // --- BREAKDOWN BLOCK: The 4 Spectrum Progress Bars ---
              ...result.scores.map((score) {
                final labels = _getAxisLabels(score.axis);
                final leftPercent = score.leftPercentage;
                final rightPercent = score.rightPercentage;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${labels['left']} • $leftPercent%',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: leftPercent >= 50
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          Text(
                            '$rightPercent% • ${labels['right']}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: rightPercent > 50
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          children: [
                            Container(
                              height: 12,
                              color: theme.colorScheme.surfaceContainerHighest,
                            ),
                            FractionallySizedBox(
                              widthFactor: score.value,
                              child: Container(
                                height: 12,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      theme.colorScheme.secondary.withAlpha(
                                        150,
                                      ),
                                      theme.colorScheme.primary,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
              // Safe area padding padding at the very bottom
              const SizedBox(height: 24),
            ]),
          ),
        ),
      ],
    );
  }
}
