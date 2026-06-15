import 'package:emombti/domain/models/quiz/survey_models.dart';
import 'package:emombti/ui/core/ui/widgets/app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../view_models/survey_flow_viewmodel.dart';

class SurveyFlowScreen extends StatefulWidget {
  final SurveyFlowViewModel viewModel;

  const SurveyFlowScreen({super.key, required this.viewModel});

  @override
  State<SurveyFlowScreen> createState() => _SurveyFlowScreenState();
}

class _SurveyFlowScreenState extends State<SurveyFlowScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.load.execute();
  }

  @override
  void dispose() {
    widget.viewModel.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SurveyFlowScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.viewModel.load.execute();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListenableBuilder(
      listenable: widget.viewModel.load,
      builder: (context, _) {
        if (widget.viewModel.load.completed) {
          return Scaffold(
            appBar: StandardAppBar(
              title: 'Quiz',
              leading: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.grid_view_rounded),
                    onPressed: () => _showQuestionPicker(context),
                  ),
                ],
              ),
              actions: [
                if (kDebugMode)
                  TextButton(
                    onPressed: () => widget.viewModel.debugFinishTest(),
                    child: const Text('Finish'),
                  ),
                _buildProgressBadge(theme),
                _buildSubmitButton(),
              ],
            ),
            body: Column(
              children: [
                ListenableBuilder(
                  listenable: widget.viewModel,
                  builder: (context, child) {
                    return LinearProgressIndicator(
                      value: widget.viewModel.flow.completionRate,
                      minHeight: 4,
                      backgroundColor:
                          theme.colorScheme.surfaceContainerHighest,
                    );
                  },
                ),
                Expanded(
                  child: ListenableBuilder(
                    listenable: widget.viewModel,
                    builder: (context, child) {
                      return PageView(
                        controller: widget.viewModel.pageController,
                        // physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(
                          widget.viewModel.flow.totalQuestions,
                          (index) {
                            final question = widget.viewModel.getQuestion(
                              index,
                            );
                            return _QuestionItem(
                              key: ValueKey(question.id),
                              question: question,
                              // 每次 viewModel 通知更新，这里都会重新计算获取最新值
                              currentScore: widget
                                  .viewModel
                                  .flow
                                  .currentAnswers[question.id],
                              onSelect: (score) => widget.viewModel.toggleScore(
                                question.id,
                                score,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(body: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildProgressBadge(ThemeData theme) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, child) => Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: theme.colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            "${widget.viewModel.flow.currentAnswers.length} / ${widget.viewModel.flow.totalQuestions}",
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSecondaryContainer,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ListenableBuilder(
      listenable: Listenable.merge([widget.viewModel, widget.viewModel.submit]),
      builder: (context, _) {
        final canSubmit =
            widget.viewModel.flow.currentAnswers.length ==
            widget.viewModel.flow.totalQuestions;

        if (!canSubmit) return const SizedBox.shrink();

        return Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: widget.viewModel.submit.running
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : FilledButton(
                  onPressed:
                      widget.viewModel.pageMode != SurveyFlowPageMode.edit
                      ? null
                      : () async {
                          await widget.viewModel.submit.execute();
                          if (context.mounted &&
                              widget.viewModel.submit.completed) {
                            Navigator.of(context).pop();
                          }
                        },
                  child: const Text('Submit'),
                ),
        );
      },
    );
  }

  void _showQuestionPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.4,
        maxChildSize: 0.9,
        minChildSize: 0.3,
        expand: false,
        builder: (_, scrollController) =>
            _QuestionGridPicker(viewModel: widget.viewModel),
      ),
    );
  }
}

class _QuestionGridPicker extends StatelessWidget {
  final SurveyFlowViewModel viewModel;
  const _QuestionGridPicker({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Jump to Question", style: theme.textTheme.headlineSmall),
          const SizedBox(height: 20),
          Flexible(
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: viewModel.flow.totalQuestions,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final qId = viewModel.getQuestionId(index);
                final score = viewModel.flow.currentAnswers[qId];
                final isAnswered = score != null;

                return InkWell(
                  onTap: () {
                    viewModel.jumpToQuestion(index);
                    Navigator.pop(context);
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isAnswered
                          ? theme.colorScheme.primary
                          : theme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isAnswered
                              ? theme.colorScheme.onPrimary
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _QuestionItem extends StatelessWidget {
  final Question question;
  final int? currentScore;
  final Function(int?) onSelect;

  const _QuestionItem({
    super.key,
    required this.question,
    this.currentScore,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
      child: Column(
        children: [
          // 1. 旋转卡片展示区域
          Expanded(
            child: Center(
              child: Transform.rotate(
                angle: -0.03,
                child: Container(
                  padding: const EdgeInsets.all(48.0),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: (0.08)),
                        blurRadius: 25,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Text(
                    question.text,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 50),

          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Agree",
                      style: textTheme.labelLarge?.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Disagree",
                      style: textTheme.labelLarge?.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12.0),
              _RatingButtonList(initialScore: currentScore, onSelect: onSelect),
            ],
          ),
        ],
      ),
    );
  }
}

class _RatingButtonList extends StatefulWidget {
  const _RatingButtonList({this.initialScore, required this.onSelect});

  final int? initialScore;
  final Function(int?) onSelect;

  @override
  State<_RatingButtonList> createState() => _RatingButtonListState();
}

class _RatingButtonListState extends State<_RatingButtonList> {
  // Local state that tracks the current selection
  int? _currentScore;

  @override
  void initState() {
    super.initState();
    // Initialize the local state with the value passed from the parent
    _currentScore = widget.initialScore;
  }

  @override
  void didUpdateWidget(covariant _RatingButtonList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialScore != oldWidget.initialScore &&
        _currentScore != widget.initialScore) {
      _currentScore = widget.initialScore;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(5, (index) {
        final score = index + 1;

        // Calculate size based on distance from center (M3 look)
        final distanceToCenter = (index - 2).abs().toDouble();
        final buttonSize = 46 + (distanceToCenter * 8);

        return _RatingButton(
          score: score,
          size: buttonSize,
          isSelected: _currentScore == score,
          onTap: () async {
            final newScore = (_currentScore == score) ? null : score;

            setState(() {
              _currentScore = newScore;
            });

            await Future.delayed(const Duration(milliseconds: 300));

            widget.onSelect(newScore);
          },
        );
      }),
    );
  }
}

class _RatingButton extends StatefulWidget {
  final int score;
  final double size;
  final bool isSelected;
  final VoidCallback onTap;

  const _RatingButton({
    required this.score,
    required this.size,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_RatingButton> createState() => _RatingButtonState();
}

class _RatingButtonState extends State<_RatingButton> {
  @override
  Widget build(BuildContext context) {
    // 根据位置分配颜色
    Color baseColor;
    if (widget.score < 3) {
      baseColor = Colors.green;
    } else if (widget.score > 3) {
      baseColor = Colors.red;
    } else {
      baseColor = Colors.grey;
    }

    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.isSelected ? baseColor : Colors.white,
          border: Border.all(
            color: baseColor.withValues(alpha: widget.isSelected ? 1.0 : 0.4),
            width: widget.isSelected ? 5 : 2.5,
          ),
          boxShadow: widget.isSelected
              ? [
                  BoxShadow(
                    color: baseColor.withValues(alpha: 0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ]
              : [],
        ),
        child: widget.isSelected
            ? const Icon(Icons.check, color: Colors.white, size: 20)
            : null,
      ),
    );
  }
}
