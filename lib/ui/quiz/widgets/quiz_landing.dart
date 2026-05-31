import 'package:emombti/app_state/survey_flow_state.dart';
import 'package:emombti/ui/core/ui/widgets/app_bar.dart';
import 'package:emombti/ui/quiz/view_models/quiz_landing_viewmodel.dart';
import 'package:emombti/ui/quiz/widgets/survey_flow_list_view.dart';
import 'package:emombti/ui/quiz/widgets/survey_flow_result.dart';
import 'package:flutter/material.dart';
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
    );
    _pageController = PageController();
  }

  @override
  void dispose() {
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
              onTap: () => Navigator.pop(context),
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
      body: Consumer<SurveyFlowState>(
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
    return SurveyFlowResult(viewModel: viewModel);
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
