import 'package:emombti/app_state/quiz.dart';
import 'package:emombti/domain/constants/status.dart';
import 'package:emombti/routing/routes.dart';
import 'package:emombti/ui/core/ui/widgets/app_bar.dart';
import 'package:emombti/ui/quiz/view_models/quiz_landing_viewmodel.dart';
import 'package:emombti/ui/quiz/widgets/survey_flow_list_view.dart';
import 'package:emombti/ui/quiz/widgets/survey_flow_result.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class QuizLandingScreen extends StatefulWidget {
  const QuizLandingScreen({super.key});

  @override
  State<QuizLandingScreen> createState() => _QuizLandingScreenState();
}

class _QuizLandingScreenState extends State<QuizLandingScreen> {
  late final QuizLandingViewModel viewModel;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    viewModel = QuizLandingViewModel(
      repository: context.read(),
      surveyFlowRepository: context.read(),
      surveyFlowState: context.read(),
      syncManager: context.read(),
    );
    viewModel.loadAssessmentResult.execute();
    _pageController = PageController();
  }

  @override
  void dispose() {
    viewModel.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: StandardAppBar(
        title: 'Quiz',
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu_rounded),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
        actions: [
          ListenableBuilder(
            listenable: viewModel,
            builder: (context, child) {
              if (viewModel.quizSyncStatus == SyncStatus.running) {
                return const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              }
              return IconButton(
                icon: const Icon(Icons.sync_rounded),
                onPressed: () => viewModel.sync.execute(),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
              ),
              child: Text(
                'Quiz Menu',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.menu_book_rounded),
              title: const Text('Knowledge'),
              onTap: () async {
                Navigator.pop(context);
                await context.pushNamed(Routes.knowledgeContents);
              },
            ),
            ListTile(
              leading: const Icon(Icons.question_answer_rounded),
              title: const Text('Q&A'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.feedback_rounded),
              title: const Text('Feedback'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: Consumer<QuizState>(
        builder: (context, surveyFlowState, child) {
          return Center(
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    children: [
                      if (surveyFlowState.hasLatestCompleted)
                        _buildResultPage(),
                      child ?? SizedBox.shrink(),
                    ],
                  ),
                ),
                _QuizLandingPageViewIndicator(
                  initialLength: surveyFlowState.hasLatestCompleted ? 2 : 1,
                  pageController: _pageController,
                ),
              ],
            ),
          );
        },
        child: _buildLandingPage(),
      ),
    );
  }

  Widget _buildResultPage() {
    return ListenableBuilder(
      listenable: viewModel.loadAssessmentResult,
      builder: (context, child) {
        if (viewModel.loadAssessmentResult.running) {
          return const Center(child: CircularProgressIndicator());
        } else if (viewModel.loadAssessmentResult.error) {
          return Center(
            child: Text(
              'Failed to load assessment result: ${viewModel.loadAssessmentResult.error}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          );
        } else if (viewModel.loadAssessmentResult.completed) {
          final result = viewModel.loadAssessmentResult.result;
          if (result is Ok && result.value != null) {
            return SurveyFlowResult(
              pResult: result.value,
              onGoBack: () {
                _pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
            );
          } else {
            return const Center(child: Text('No assessment result found.'));
          }
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildLandingPage() {
    return SurveyFlowListView(viewModel: viewModel);
  }
}

class _QuizLandingPageViewIndicator extends StatefulWidget {
  const _QuizLandingPageViewIndicator({
    required this.initialLength,
    required this.pageController,
  });

  final PageController pageController;

  final int initialLength;

  @override
  State<_QuizLandingPageViewIndicator> createState() =>
      _QuizLandingPageViewIndicatorState();
}

class _QuizLandingPageViewIndicatorState
    extends State<_QuizLandingPageViewIndicator> {
  int currentPage = 0;

  int length = 0;

  @override
  void initState() {
    super.initState();
    length = widget.initialLength;
    widget.pageController.addListener(_pageListener);
  }

  @override
  void dispose() {
    widget.pageController.removeListener(_pageListener);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _QuizLandingPageViewIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialLength != widget.initialLength) {
      setState(() {
        length = widget.initialLength;
        currentPage = 0;
      });
    }
  }

  void _pageListener() {
    setState(() {
      currentPage = widget.pageController.page?.round() ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    if (length <= 1) return SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          length,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 8,
            width: currentPage == index ? 24 : 8,
            decoration: BoxDecoration(
              color: currentPage == index
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }
}
