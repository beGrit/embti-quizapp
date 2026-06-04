import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/services/common/advertising_service.dart';
import 'package:emombti/routing/routes.dart';
import 'package:emombti/ui/contents/view_models/banner_viewmodel.dart';
import 'package:emombti/ui/contents/view_models/slideshow_viewmodel.dart';
import 'package:emombti/ui/contents/widgets/knowledge_section.dart';
import 'package:emombti/ui/core/ui/widgets/speech.dart';
import 'package:emombti/ui/home/view_models/home_viewmodel.dart';
import 'package:emombti/ui/home/widgets/survey_flow_progress_fab.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../contents/view_models/article_viewmodel.dart';
import '../../contents/view_models/video_viewmodel.dart';
import '../../contents/widgets/article_section.dart';
import '../../contents/widgets/slideshow_section.dart';
import '../../contents/widgets/video_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final SearchController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = SearchController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AdvertisingService advertisingService = context
          .read<AdvertisingService>();
      advertisingService.showAd(context);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authRepository = context.watch<AuthRepository>();
    final user = authRepository.user;

    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(),
      child: Consumer<HomeViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: theme.colorScheme.surface,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  flexibleSpace: _HomeHeaderDelegate(
                    topPadding: MediaQuery.of(context).padding.top,
                    avatarUrl: user?.avatar?.uri.toString(),
                    searchController: _searchController,
                    onSearchChanged: viewModel.updateSearchQuery,
                    suggestions: viewModel.suggestions,
                    theme: theme,
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  sliver: SliverToBoxAdapter(
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
                                bannerViewModel: BannerViewModel(
                                  context.read(),
                                ),
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
                              viewModel: VideoViewModel.forHome(
                                repository: context.read(),
                              )..loadFirstVideo(),
                            ),
                            const SizedBox(height: 16),
                            KnowledgeHomeSection(),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: const SurveyFlowProgressFab(),
          );
        },
      ),
    );
  }
}

class _HomeHeaderDelegate extends StatelessWidget {
  const _HomeHeaderDelegate({
    required this.topPadding,
    required this.avatarUrl,
    required this.searchController,
    required this.onSearchChanged,
    required this.suggestions,
    required this.theme,
  });

  final double topPadding;
  final String? avatarUrl;
  final SearchController searchController;
  final ValueChanged<String> onSearchChanged;
  final List<String> suggestions;
  final ThemeData theme;

  static const double _expandedHeight = 140.0;
  static const double _collapsedHeight = 70.0;

  double get minExtent => _collapsedHeight + topPadding;

  double get maxExtent => _expandedHeight + topPadding;

  @override
  Widget build(BuildContext context) {
    final colorScheme = theme.colorScheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: SearchAnchor(
                  searchController: searchController,
                  builder: (context, controller) {
                    return SearchBar(
                      controller: controller,
                      padding: const WidgetStatePropertyAll<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                      onTap: () {
                        controller.openView();
                      },
                      onChanged: (value) {
                        onSearchChanged(value);
                        controller.openView();
                      },
                      leading: const Icon(Icons.search),
                      trailing: [
                        SpeechToTextIconWidget(
                          onResult: (text) {
                            controller.text = text;
                            onSearchChanged(text);
                            controller.openView();
                          },
                        ),
                      ],
                      hintText: 'Search for personality...',
                      elevation: const WidgetStatePropertyAll<double>(0),
                      backgroundColor: WidgetStatePropertyAll<Color>(
                        theme.colorScheme.surfaceContainerHighest.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    );
                  },
                  suggestionsBuilder: (context, controller) {
                    return suggestions.map((suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                        onTap: () {
                          onSearchChanged(suggestion);
                          controller.closeView(suggestion);
                        },
                      );
                    }).toList();
                  },
                ),
              ),
            ),
            GestureDetector(
              onTap: () => context.push(Routes.meStandalone),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: colorScheme.primaryContainer,
                backgroundImage: avatarUrl != null
                    ? NetworkImage(avatarUrl!)
                    : null,
                child: avatarUrl == null
                    ? Text(
                        'SF',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
