import 'dart:async';

import 'package:emombti/domain/models/quiz/survey_models.dart';
import 'package:emombti/routing/routes.dart';
import 'package:emombti/ui/core/ui/widgets/app_bar.dart';
import 'package:emombti/ui/quiz/view_models/quiz_landing_viewmodel.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class QuizLandingScreen extends StatefulWidget {
  const QuizLandingScreen({super.key});

  @override
  State<QuizLandingScreen> createState() => _QuizLandingScreenState();
}

class _QuizLandingScreenState extends State<QuizLandingScreen> {
  late final Listenable _listenable;
  late final QuizLandingViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = QuizLandingViewModel(
      repository: context.read(),
      surveyFlowRepository: context.read(),
    );
    _listenable = Listenable.merge([
      viewModel,
      viewModel.load,
      viewModel.startAssessment,
    ]);
    viewModel.startAssessment.addListener(_onStartAssessmentChanged);
    viewModel.load.execute();
  }

  @override
  void dispose() {
    viewModel.startAssessment.removeListener(_onStartAssessmentChanged);
    super.dispose();
  }

  void _onStartAssessmentChanged() {
    final result = viewModel.startAssessment.result;
    if (result is Ok<Map<String, String>>) {
      unawaited(_pushSurveyFlow(result.value));
    }
  }

  Future<void> _pushSurveyFlow(Map<String, String> queryParameters) async {
    await context.push(
      Uri(path: Routes.surveyFlow, queryParameters: queryParameters).toString(),
    );
    if (mounted) viewModel.load.execute();
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
      body: ListenableBuilder(
        listenable: _listenable,
        builder: (context, child) {
          final vm = viewModel;
          final initialLoading =
              vm.load.running && vm.surveys.isEmpty && vm.surveyFlows.isEmpty;

          if (initialLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.hasExistingSurveyFlows) {
            return _SurveyFlowListBody(
              viewModel: vm,
              theme: theme,
              onOpenFlow: _pushSurveyFlow,
            );
          }

          return _LandingBody(viewModel: vm, theme: theme);
        },
      ),
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
    required this.theme,
    required this.onOpenFlow,
  });

  final QuizLandingViewModel viewModel;
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
            children: [
              Expanded(
                child: Text(
                  'Continue where you left off',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
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
              itemCount: viewModel.surveyFlows.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final flow = viewModel.surveyFlows[index];
                return _SurveyFlowTile(
                  flow: flow,
                  title: viewModel.surveyTitleForFlow(flow),
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
                onPressed: viewModel.startAssessment.running
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
    final pct = (flow.completionRate * 100).clamp(0, 100).round();
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
                  Icons.play_circle_outline_rounded,
                  color: theme.colorScheme.primary,
                  size: 36,
                ),
                const SizedBox(width: 14),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
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
                  onPressed: viewModel.startAssessment.running
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
