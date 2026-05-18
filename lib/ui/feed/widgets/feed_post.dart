import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/repositories/feed/feed_repository.dart';
import 'package:emombti/domain/models/feed/feed.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/feed_post_viewmodel.dart';

class FeedPostScreen extends StatelessWidget {
  const FeedPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FeedPostViewModel>(
      create: (context) => FeedPostViewModel(
        authRepository: context.read<AuthRepository>(),
        feedRepository: context.read<FeedRepository>(),
      )..loadPosts(),
      builder: (context, _) {
        final viewModel = context.watch<FeedPostViewModel>();
        final theme = Theme.of(context);
        // Calculate the top offset to account for the floating TabBar header in ExploreScreen
        return Material(
          color: theme.colorScheme.surface,
          child: Column(
            children: [
              const _FeedPostScreenHeader(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: viewModel.loadPosts,
                  child: CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    slivers: [
                      if (viewModel.isLoading && viewModel.posts.isEmpty)
                        const SliverFillRemaining(
                          child: Center(child: CircularProgressIndicator()),
                        )
                      else if (viewModel.errorMessage != null &&
                          viewModel.posts.isEmpty)
                        SliverFillRemaining(
                          child: Center(
                            child: Text('Error: ${viewModel.errorMessage}'),
                          ),
                        )
                      else if (viewModel.posts.isEmpty)
                        const SliverFillRemaining(
                          child: Center(child: Text('No posts found')),
                        )
                      else
                        SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final post = viewModel.posts[index];
                            return _PostListTile(post: post);
                          }, childCount: viewModel.posts.length),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FeedPostScreenHeader extends StatelessWidget {
  const _FeedPostScreenHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [SizedBox(height: MediaQuery.of(context).padding.top + 56.0)],
    );
  }
}

class _PostListTile extends StatelessWidget {
  const _PostListTile({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: colorScheme.surfaceContainer),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row 1: Author Info (Avatar | Name + Date)
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: colorScheme.primaryContainer,
                    child: Text(
                      post.author.name!.substring(0, 1).toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.author.name!,
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${post.created.year}-${post.created.month}-${post.created.day}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.more_horiz, color: colorScheme.onSurfaceVariant),
                ],
              ),
              const SizedBox(height: 12),

              // Row 2: Post content (Title, Body, Photos)
              Text(post.title, style: theme.textTheme.titleSmall),
              if (post.body != null) ...[
                const SizedBox(height: 4),
                Text(
                  post.body!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall,
                ),
              ],
              if (post.photos.isNotEmpty) ...[
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    color: colorScheme.surfaceContainerHigh,
                    child: const Center(
                      child: Icon(Icons.image_outlined, size: 48),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 16),

              // Row 3: Social Interactions
              Row(
                children: [
                  _SocialAction(icon: Icons.favorite_border, label: 'Like'),
                  const SizedBox(width: 16),
                  _SocialAction(
                    icon: Icons.chat_bubble_outline,
                    label: 'Comment',
                  ),
                  const Spacer(),
                  _SocialAction(icon: Icons.share_outlined, label: 'Share'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

class _SocialAction extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SocialAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.onSurfaceVariant),
        const SizedBox(width: 4),
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
