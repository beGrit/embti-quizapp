import 'package:emombti/data/services/notification_service.dart';
import 'package:emombti/ui/contents/view_models/banner_viewmodel.dart';
import 'package:emombti/ui/contents/view_models/slideshow_viewmodel.dart';
import 'package:emombti/ui/contents/widgets/knowledge_section.dart';
import 'package:emombti/ui/home/widgets/survey_flow_progress_fab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../contents/view_models/article_viewmodel.dart';
import '../../contents/view_models/video_viewmodel.dart';
import '../../contents/widgets/article_section.dart';
import '../../contents/widgets/slideshow_section.dart';
import '../../contents/widgets/video_section.dart';
import '../../core/ui/widgets/advertising.dart';
import '../widgets/home_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> _scrollScale = ValueNotifier<double>(1.0);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _triggerAd();
      context.read<NotificationService>().startTestCron();
    });
  }

  void _triggerAd() {
    // Delay for 3 seconds before showing the ad
    Future.delayed(const Duration(seconds: 3), () {
      // Check if the widget is still "mounted"
      // This prevents the ad from popping up if the user left the screen already
      if (!mounted) return;

      FullScreenAd.show(
        context,
        title: "Premium MBTI",
        content: "Covering 80% of your screen to show you the best deals!",
        imageUrl: "https://via.placeholder.com/600x800/blue/white?text=Big+Ad",
      );
    });
  }

  void _handleScroll() {
    final double offset = _scrollController.offset;
    final double threshold = HomeAppBar.heightWithSearch * 0.5;

    if (offset > threshold + 50 && _scrollScale.value == 0.88) return;

    if (offset < threshold - 50 && _scrollScale.value == 1.0) return;

    double targetScale = offset > threshold ? 0.9 : 1.0;

    if (targetScale != _scrollScale.value) {
      _scrollScale.value = targetScale;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: PreferredSize(
        // Ensure the height matches your HomeAppBar.heightWithSearch
        preferredSize: Size.fromHeight(HomeAppBar.heightWithSearch),
        child: ValueListenableBuilder<double>(
          valueListenable: _scrollScale,
          builder: (context, scrollScaleValue, child) {
            return HomeAppBar(
              onSearchChanged: (value) => debugPrint("Searching for: $value"),
              scrollScale: scrollScaleValue,
            );
          },
        ),
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          _buildBody(context),
          Positioned(
            right: 16,
            bottom:
                MediaQuery.paddingOf(context).bottom +
                (MediaQuery.sizeOf(context).width >= 600 ? 16.0 : 32.0),
            child: const SurveyFlowProgressFab(),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      // 1. Padding is now the TOP-LEVEL child of the body
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        controller: _scrollController,
        // 2. The ScrollView now lives inside the padding
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Slideshow Section
                SlideshowHomeSection(
                  viewModel: SlideshowViewModel(
                    bannerViewModel: BannerViewModel(context.read()),
                  ),
                ),
                const SizedBox(height: 16),
                // Articles Section
                ArticleHomeSection(viewModel: ArticleViewModel(context.read())),
                const SizedBox(height: 16),
                VideoHomeSection(
                  viewModel: VideoViewModel.forHome(repository: context.read())
                    ..loadFirstVideo(),
                ),
                const SizedBox(height: 16),
                KnowledgeHomeSection(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
