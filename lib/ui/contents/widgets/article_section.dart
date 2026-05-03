import 'package:emombti/ui/contents/widgets/content_section.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/models/content/content.dart';
import '../../../routing/routes.dart';
import '../view_models/article_viewmodel.dart';

class ArticleHomeSection extends StatefulWidget {
  const ArticleHomeSection({super.key, required this.viewModel});

  final ArticleViewModel viewModel;

  @override
  State<ArticleHomeSection> createState() => _ArticleHomeSectionState();
}

class _ArticleHomeSectionState extends State<ArticleHomeSection> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.loadArticles.execute();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Articles (Recommended)',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 230),
          child: Center(
            child: ListenableBuilder(
              listenable: widget.viewModel.loadArticles,
              builder: (context, _) {
                if (widget.viewModel.loadArticles.running) {
                  return CircularProgressIndicator();
                }

                if (widget.viewModel.loadArticles.error) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Failed to load articles'),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: widget.viewModel.loadArticles.execute,
                        child: const Text('Try Again'),
                      ),
                    ],
                  );
                }
                return ListenableBuilder(
                  listenable: widget.viewModel,
                  builder: (context, _) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        await widget.viewModel.loadArticles.execute();
                      },
                      child: CustomScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        slivers: [
                          SliverPadding(
                            padding: const EdgeInsets.all(16),
                            sliver: SliverList.builder(
                              itemCount: widget.viewModel.articles.length,
                              itemBuilder: (context, index) => _ArticleItem(
                                key: ValueKey(
                                  widget.viewModel.articles[index].id,
                                ),
                                article: widget.viewModel.articles[index],
                                onTap: () {
                                  context.push(
                                    '${Routes.article}/${widget.viewModel.articles[index].id}',
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _ArticleItem extends StatelessWidget {
  const _ArticleItem({super.key, required this.article, required this.onTap});
  final ArticleContent article;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 0.5,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: theme.dividerColor.withValues(alpha: 0.1)),
      ),
      clipBehavior: Clip.antiAlias,
      color: colorScheme.surface,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Image Thumbnail (Fixed Size)
          SizedBox(
            width: 100,
            height: 100,
            child: Image.network(
              article.thumbnailUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(color: colorScheme.surfaceContainerHighest),
            ),
          ),

          // 2. Content Area
          Expanded(
            child: Container(
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    article.title,
                    style: theme.textTheme.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.tertiaryContainer,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 8,
                          backgroundColor: colorScheme.tertiary,
                          child: Text(
                            article.authorMbti[0],
                            textAlign: TextAlign.center,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: colorScheme.onTertiary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          article.authorName,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onTertiaryContainer,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({super.key, required this.viewModel});

  final ArticleDetailViewModel viewModel;

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.loadArticleContent.execute();
    _scrollController = ScrollController();
  }

  late ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ContentAppBar(title: 'Article'),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_buildArticleDetail(context)],
        ),
      ),
    );
  }

  Widget _buildArticleDetail(BuildContext context) {
    return Text(widget.viewModel.articleId);
  }
}
