import 'package:emombti/domain/models/social/social.dart';
import 'package:emombti/ui/social/view_models/social_viewmodel.dart';
import 'package:emombti/ui/social/widgets/social.dart';
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
    _headerHeight = 260.0;
  }

  late double _headerHeight;

  late ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      // backgroundColor: colorScheme.primaryContainer.withValues(alpha: .4),
      body: _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    return Column(
      children: [
        Expanded(
          // child: Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                _buildAppBar(context),
                _buildArticleBody(context),
                ..._buildSocial(context),
              ],
            ),
          ),
          // ),
        ),
        StickyInputBarWidget(viewModel: StickyInputViewModel()),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: _headerHeight,
      stretch: true,
      floating: false,
      snap: false,
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          var top = constraints.biggest.height;
          var isCollapsed =
              top <= (MediaQuery.of(context).padding.top + kToolbarHeight);

          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            color: isCollapsed
                ? Theme.of(context).colorScheme.surfaceContainerHighest
                : Theme.of(context).colorScheme.surface,
            child: FlexibleSpaceBar(
              titlePadding: const EdgeInsetsDirectional.only(
                start: 16,
                bottom: 16,
              ),
              centerTitle: false,
              title: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isCollapsed ? 1.0 : 0.0,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        widget.viewModel.article.thumbnailUrl,
                      ),
                    ),
                    const SizedBox(width: 12),
                    FilledButton.tonal(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.tertiaryContainer,
                        foregroundColor: Theme.of(
                          context,
                        ).colorScheme.onTertiaryContainer,
                        // "Small" adaptation via visual density and padding
                        visualDensity: VisualDensity.compact,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        textStyle: Theme.of(context).textTheme.labelSmall,
                      ),
                      child: Text('Follow'),
                    ),
                  ],
                ),
              ),
              background: _buildArticleHeader(context),
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildArticleHeader(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListenableBuilder(
      listenable: widget.viewModel.loadArticleContent,
      builder: (context, _) {
        if (widget.viewModel.loadArticleContent.running) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          );
        }
        if (widget.viewModel.loadArticleContent.error) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text('Failed to load article content'),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: widget.viewModel.loadArticleContent.execute,
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        }

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.viewModel.article.title,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(32.0),
                    border: Border.all(
                      color: colorScheme.outlineVariant.withValues(alpha: .5),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: colorScheme.outlineVariant,
                        backgroundImage: NetworkImage(
                          widget.viewModel.article.thumbnailUrl,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.viewModel.article.authorName,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              widget.viewModel.article.createdAt.toString(),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FilledButton.tonal(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          backgroundColor: colorScheme.tertiaryContainer,
                          foregroundColor: colorScheme.onTertiaryContainer,
                          visualDensity: VisualDensity.compact,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          textStyle: theme.textTheme.labelSmall,
                        ),
                        child: const Text('Follow'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Divider(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildArticleBody(BuildContext context) {
    return SliverToBoxAdapter(
      child: ListenableBuilder(
        listenable: widget.viewModel.loadArticleContent,
        builder: (context, _) {
          if (widget.viewModel.loadArticleContent.running) {
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            );
          }
          if (widget.viewModel.loadArticleContent.error) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text('Failed to load article content'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: widget.viewModel.loadArticleContent.execute,
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          }

          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    widget.viewModel.article.summary,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _buildSocial(BuildContext context) {
    return [
      SliverPadding(
        padding: const EdgeInsets.all(16.0),
        sliver: SliverMainAxisGroup(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade300),
                    left: BorderSide(color: Colors.grey.shade300),
                    right: BorderSide(color: Colors.grey.shade300),
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: InteractionBarWidget(
                  viewModel: InteractionViewModel(
                    SocialMeta(id: '1', relatedId: '1'),
                  ),
                ),
              ),
            ),

            // 评论区（这里假设评论区内部是 SliverList）
            // 注意：如果想让列表也有边框，通常需要为每个 Item 绘制左右边框
            CommentSectionWidget(
              viewModel: CommentSectionViewModel()..fetchComments('1'),
            ),

            // 使用一个带底部边框的装饰
            SliverToBoxAdapter(
              child: Container(
                height: 12,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300),
                    left: BorderSide(color: Colors.grey.shade300),
                    right: BorderSide(color: Colors.grey.shade300),
                  ),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 80)),
    ];
  }
}
