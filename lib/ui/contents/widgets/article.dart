import 'package:flutter/material.dart';

import '../../../domain/models/content/content.dart';
import '../view_models/article_viewmodel.dart';

class ArticleListView extends StatefulWidget {
  const ArticleListView({super.key, required this.viewModel});

  final ArticleViewModel viewModel;

  @override
  State<ArticleListView> createState() => _ArticleListViewState();
}

class _ArticleListViewState extends State<ArticleListView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.loadArticles.execute();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  sliver: SliverList.builder(
                    itemCount: widget.viewModel.articles.length,
                    itemBuilder: (context, index) => _ArticleItem(
                      key: ValueKey(widget.viewModel.articles[index].id),
                      article: widget.viewModel.articles[index],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _ArticleItem extends StatelessWidget {
  const _ArticleItem({super.key, required this.article});
  final ArticleContent article;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: 110,
              child: Image.network(
                article.thumbnailUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Container(color: Colors.grey.shade100),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      article.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.indigo.shade50,
                          child: Text(
                            article.authorMbti[0],
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.indigo.shade900,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          article.authorName,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
