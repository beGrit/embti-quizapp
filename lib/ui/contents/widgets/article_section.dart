import 'package:flutter/material.dart';

import '../../../domain/models/content/content.dart';
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
    return SingleChildScrollView(
      child: Column(
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
            constraints: const BoxConstraints(maxHeight: 200),
            child: ListenableBuilder(
              listenable: widget.viewModel.loadArticles,
              builder: (context, _) {
                if (widget.viewModel.loadArticles.running) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (widget.viewModel.loadArticles.error) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Failed to load articles'),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: widget.viewModel.loadArticles.execute,
                          child: const Text('Try Again'),
                        ),
                      ],
                    ),
                  );
                }

                return ListenableBuilder(
                  listenable: widget.viewModel,
                  builder: (context, _) {
                    return CustomScrollView(
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
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ArticleItem extends StatelessWidget {
  const _ArticleItem({super.key, required this.article});
  final ArticleContent article;

  @override
  Widget build(BuildContext context) {
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
            width: 80,
            height: 80,
            child: Image.network(
              article.thumbnailUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(color: colorScheme.surfaceContainerHighest),
            ),
          ),

          // 2. Content Area
          Expanded(
            child: Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    article.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  // Author Row (Refactored as a Styled Card)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 8,
                          backgroundColor: colorScheme.secondary,
                          child: Text(
                            article.authorMbti[0],
                            style: TextStyle(
                              fontSize: 8,
                              color: colorScheme.onSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            article.authorName,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSecondaryContainer,
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
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
