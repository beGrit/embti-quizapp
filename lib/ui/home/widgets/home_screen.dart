import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/services/common/advertising_service.dart';
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
      AdvertisingService advertisingService = context
          .read<AdvertisingService>();
      advertisingService.showAd(context);
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
    final authRepository = context.watch<AuthRepository>();
    final user = authRepository.user;

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
              avatarUrl: user?.avatar?.uri.toString(),
            );
          },
        ),
      ),
      body: _buildBody(context),
      floatingActionButton: const SurveyFlowProgressFab(),
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
                ArticleHomeSection(
                  viewModel: ArticleViewModel(context.read())
                    ..loadArticles.execute(),
                ),
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
