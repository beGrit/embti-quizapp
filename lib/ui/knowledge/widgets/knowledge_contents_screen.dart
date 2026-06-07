import 'package:emombti/data/repositories/content/content_repository.dart';
import 'package:emombti/ui/core/ui/widgets/speech.dart';
import 'package:emombti/ui/knowledge/view_models/knowledge_contents_viewmodel.dart';
import 'package:emombti/ui/knowledge/widgets/knowledge_contents_book.dart';
import 'package:emombti/ui/knowledge/widgets/knowledge_contents_survey_flow_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'knowledge_contents_article.dart';
import 'knowledge_contents_slideshow.dart';

class KnowledgeContentsScreen extends StatefulWidget {
  const KnowledgeContentsScreen({super.key});

  @override
  State<KnowledgeContentsScreen> createState() =>
      _KnowledgeContentsScreenState();
}

class _KnowledgeContentsScreenState extends State<KnowledgeContentsScreen> {
  late final SearchController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = SearchController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ChangeNotifierProvider<KnowledgeContentsViewModel>(
      create: (context) {
        KnowledgeContentsViewModel viewModel = KnowledgeContentsViewModel(
          repository: context.read<ContentRepository>(),
        );
        viewModel.loadArticles.execute();
        viewModel.loadBanners.execute();
        return viewModel;
      },
      child: Consumer<KnowledgeContentsViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              title: _KnowledgeContentsScreenSearchBar(
                topPadding: MediaQuery.of(context).padding.top,
                searchController: _searchController,
                onSearchChanged: viewModel.updateSearchQuery,
                suggestions: viewModel.suggestions,
                theme: theme,
              ),
            ),
            backgroundColor: theme.colorScheme.surface,
            body: CustomScrollView(
              slivers: [
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
                            KnowledgeContentsSlideshow(viewModel: viewModel),
                            const SizedBox(height: 16),
                            // Articles Section
                            ArticleHomeSection(viewModel: viewModel),
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
            floatingActionButton:
                const KnowledgeContentsSlideshowSurveyFlowBar(),
          );
        },
      ),
    );
  }
}

class _KnowledgeContentsScreenSearchBar extends StatelessWidget {
  const _KnowledgeContentsScreenSearchBar({
    required this.topPadding,
    required this.searchController,
    required this.onSearchChanged,
    required this.suggestions,
    required this.theme,
  });

  final double topPadding;
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
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
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
        ],
      ),
    );
  }
}
