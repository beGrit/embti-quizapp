import 'dart:async';

import 'package:emombti/app_state/quiz.dart';
import 'package:emombti/domain/models/quiz/survey_models.dart';
import 'package:emombti/routing/routes.dart';
import 'package:emombti/ui/quiz/view_models/quiz_landing_viewmodel.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SurveyFlowListView extends StatefulWidget {
  const SurveyFlowListView({super.key, required this.viewModel});

  final QuizLandingViewModel viewModel;

  @override
  State<SurveyFlowListView> createState() => _SurveyFlowListViewState();
}

class _SurveyFlowListViewState extends State<SurveyFlowListView> {
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
    if (result is Ok<Map<String, String>>) {
      unawaited(_pushSurveyFlow(result.value));
    }
  }

  Future<void> _pushSurveyFlow(Map<String, String> queryParameters) async {
    await context.push(
      Uri(path: Routes.surveyFlow, queryParameters: queryParameters).toString(),
    );
    if (mounted) widget.viewModel.load.execute();
  }

  @override
  Widget build(BuildContext context) {
    final surveyFlowState = context.watch<QuizState>();
    return Scaffold(
      body: _buildLandingPage(surveyFlowState, Theme.of(context)),
    );
  }

  Widget _buildLandingPage(QuizState surveyFlowState, ThemeData theme) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        widget.viewModel,
        widget.viewModel.load,
        surveyFlowState,
      ]),
      builder: (context, child) {
        final initialLoading =
            widget.viewModel.load.running &&
            widget.viewModel.surveys.isEmpty &&
            surveyFlowState.surveyFlows.isEmpty;

        if (initialLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (widget.viewModel.hasExistingSurveyFlows) {
          return _SurveyFlowListBody(
            viewModel: widget.viewModel,
            surveyFlowState: surveyFlowState,
            theme: theme,
            onOpenFlow: _pushSurveyFlow,
          );
        }

        return _LandingBody(viewModel: widget.viewModel, theme: theme);
      },
    );
  }
}

Future<void> _confirmBatchDeleteSurveyFlows(
  BuildContext context,
  QuizLandingViewModel viewModel,
) async {
  final count = viewModel.selectedFlowCount;
  final ok = await showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: const Text('Delete sessions?'),
        content: Text(
          'Permanently delete $count saved session(s)? This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(dialogContext).colorScheme.error,
              foregroundColor: Theme.of(dialogContext).colorScheme.onError,
            ),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
  if (ok == true && context.mounted) {
    await viewModel.deleteSelectedSurveyFlows();
  }
}

class _SurveyFlowListBody extends StatelessWidget {
  const _SurveyFlowListBody({
    required this.viewModel,
    required this.surveyFlowState,
    required this.theme,
    required this.onOpenFlow,
  });

  final QuizLandingViewModel viewModel;
  final QuizState surveyFlowState;
  final ThemeData theme;
  final Future<void> Function(Map<String, String> queryParameters) onOpenFlow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                child: Text(
                  'Continue where you left off',
                  style: theme.textTheme.titleLarge,
                ),
              ),
              FilledButton(
                onPressed: () =>
                    viewModel.setSelectionMode(!viewModel.selectionMode),
                child: Text(viewModel.selectionMode ? 'Done' : 'Select'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            viewModel.selectionMode
                ? 'Choose sessions, then delete selected. Swipe is disabled while selecting.'
                : 'Tap a session to resume, or start a new assessment.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          if (viewModel.selectionMode) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                TextButton.icon(
                  onPressed: viewModel.toggleSelectAllFlows,
                  icon: Icon(
                    viewModel.allFlowsSelected
                        ? Icons.deselect_rounded
                        : Icons.select_all_rounded,
                  ),
                  label: Text(
                    viewModel.allFlowsSelected ? 'Deselect all' : 'Select all',
                  ),
                ),
                const Spacer(),
                Text(
                  '${viewModel.selectedFlowCount} selected',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemCount: surveyFlowState.surveyFlows.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final flow = surveyFlowState.surveyFlows[index];
                return _SurveyFlowTile(
                  flow: flow,
                  title: flow.defaultTitle,
                  selectionMode: viewModel.selectionMode,
                  selected: viewModel.isFlowSelected(flow.id),
                  onToggleSelection: () =>
                      viewModel.toggleFlowSelection(flow.id),
                  onTap: () => onOpenFlow({
                    'flowId': flow.id,
                    'surveyId': flow.surveyId,
                  }),
                  onDelete: () => viewModel.deleteSurveyFlow(flow.id),
                );
              },
            ),
          ),
          if (viewModel.selectionMode) ...[
            const SizedBox(height: 8),
            FilledButton(
              onPressed: viewModel.selectedFlowCount == 0
                  ? null
                  : () => _confirmBatchDeleteSurveyFlows(context, viewModel),
              style: FilledButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
                foregroundColor: theme.colorScheme.onError,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Delete selected (${viewModel.selectedFlowCount})'),
            ),
          ],
          const SizedBox(height: 8),
          ListenableBuilder(
            listenable: viewModel.startAssessment,
            builder: (context, child) {
              return FilledButton.tonal(
                onPressed:
                    (viewModel.startAssessment.running ||
                        viewModel.selectionMode)
                    ? null
                    : () => viewModel.startAssessment.execute(),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: viewModel.startAssessment.running
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Start new assessment'),
              );
            },
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SurveyFlowTile extends StatelessWidget {
  const _SurveyFlowTile({
    required this.flow,
    required this.title,
    required this.selectionMode,
    required this.selected,
    required this.onToggleSelection,
    required this.onTap,
    required this.onDelete,
  });

  final SurveyFlow flow;
  final String title;
  final bool selectionMode;
  final bool selected;
  final VoidCallback onToggleSelection;
  final VoidCallback onTap;
  final Future<void> Function() onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pct = flow.completionPercentage;
    final started = flow.startTime;
    final subtitle = started != null
        ? '$pct% complete · Started ${_formatDate(started)}'
        : '$pct% complete';

    final content = Material(
      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
      child: InkWell(
        onTap: selectionMode ? onToggleSelection : onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Row(
            children: [
              if (selectionMode) ...[
                Checkbox(
                  value: selected,
                  onChanged: (_) => onToggleSelection(),
                ),
                const SizedBox(width: 4),
              ] else ...[
                Icon(
                  _getStatusIconData(flow.status),
                  color: _getStatusColor(context, flow.status),
                  size: 36,
                ),
                const SizedBox(width: 14),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            title,
                            style: theme.textTheme.titleSmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        _StatusTag(status: flow.status),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (!selectionMode)
                Icon(
                  Icons.chevron_right_rounded,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
            ],
          ),
        ),
      ),
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: selectionMode
          ? content
          : Slidable(
              key: ValueKey<String>(flow.id),
              endActionPane: ActionPane(
                motion: const DrawerMotion(),
                extentRatio: 0.28,
                children: [
                  SlidableAction(
                    onPressed: (context) async {
                      await onDelete();
                      if (context.mounted) {
                        Slidable.of(context)?.close();
                      }
                    },
                    backgroundColor: theme.colorScheme.error,
                    foregroundColor: theme.colorScheme.onError,
                    icon: Icons.delete_outline_rounded,
                    label: 'Delete',
                    borderRadius: BorderRadius.circular(12),
                  ),
                ],
              ),
              child: content,
            ),
    );
  }

  static String _formatDate(DateTime d) {
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }

  IconData _getStatusIconData(SurveyFlowStatus status) {
    return switch (status) {
      SurveyFlowStatus.idle => Icons.not_started_outlined,
      SurveyFlowStatus.inProgress => Icons.play_circle_outline_rounded,
      SurveyFlowStatus.completed => Icons.check_circle_outline_rounded,
      SurveyFlowStatus.expired => Icons.timer_off_outlined,
    };
  }

  Color _getStatusColor(BuildContext context, SurveyFlowStatus status) {
    final colorScheme = Theme.of(context).colorScheme;
    return switch (status) {
      SurveyFlowStatus.idle => colorScheme.onSurfaceVariant,
      SurveyFlowStatus.inProgress => colorScheme.primary,
      SurveyFlowStatus.completed => colorScheme.tertiary,
      SurveyFlowStatus.expired => colorScheme.error,
    };
  }
}

class _LandingBody extends StatelessWidget {
  const _LandingBody({required this.viewModel, required this.theme});

  final QuizLandingViewModel viewModel;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              'This assessment analyzes your cognitive functions to help you understand your personality type, strengths, and communication style.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 32),
            ListenableBuilder(
              listenable: viewModel.startAssessment,
              builder: (context, child) {
                return FilledButton(
                  onPressed:
                      (viewModel.startAssessment.running ||
                          viewModel.selectionMode)
                      ? null
                      : () => viewModel.startAssessment.execute(),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: viewModel.startAssessment.running
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

class _StatusTag extends StatelessWidget {
  const _StatusTag({required this.status});
  final SurveyFlowStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Color backgroundColor;
    Color foregroundColor;
    String label;

    switch (status) {
      case SurveyFlowStatus.idle:
        backgroundColor = colorScheme.surfaceContainerHigh;
        foregroundColor = colorScheme.onSurfaceVariant;
        label = 'Idle';
      case SurveyFlowStatus.inProgress:
        backgroundColor = colorScheme.primaryContainer;
        foregroundColor = colorScheme.onPrimaryContainer;
        label = 'In Progress';
      case SurveyFlowStatus.completed:
        backgroundColor = colorScheme.tertiaryContainer;
        foregroundColor = colorScheme.onTertiaryContainer;
        label = 'Completed';
      case SurveyFlowStatus.expired:
        backgroundColor = colorScheme.errorContainer;
        foregroundColor = colorScheme.onErrorContainer;
        label = 'Expired';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: foregroundColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
