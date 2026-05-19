import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/repositories/feed/feed_repository.dart';
import 'package:emombti/domain/models/feed/feed.dart';
import 'package:emombti/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../view_models/feed_post_viewmodel.dart';
import 'feed_post_viewer_body_preview.dart';

class FeedPostScreen extends StatelessWidget {
  const FeedPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FeedPostViewModel>(
      create: (context) => FeedPostViewModel(
        authRepository: context.read<AuthRepository>(),
        feedRepository: context
            .read<FeedRepository>(), // Execute the command here
      )..loadPostsCommand.execute(),
      builder: (context, _) {
        final viewModel = context.watch<FeedPostViewModel>();
        final theme = Theme.of(context);
        // Calculate the top offset to account for the floating TabBar header in ExploreScreen
        return Scaffold(
          backgroundColor: theme.colorScheme.surface,
          body: Column(
            children: [
              const _FeedPostScreenHeader(),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => context
                      .read<FeedPostViewModel>()
                      .loadPostsCommand
                      .execute(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: ListenableBuilder(
                      listenable: viewModel.loadPostsCommand,
                      builder: (context, child) {
                        return CustomScrollView(
                          physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics(),
                          ),
                          slivers: [
                            if (viewModel.loadPostsCommand.running &&
                                viewModel.posts.isEmpty)
                              const SliverFillRemaining(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            else if (viewModel.loadPostsCommand.error)
                              SliverFillRemaining(
                                child: Center(child: Text('Error')),
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
                                  return _PostListTile(
                                    post: post,
                                    viewModel: viewModel,
                                  );
                                }, childCount: viewModel.posts.length),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: theme.colorScheme.primaryContainer,
            foregroundColor: theme.colorScheme.onPrimaryContainer,
            onPressed: () async {
              final newPost = await context.push<Post>(Routes.feedPostEditor);
              if (newPost != null && context.mounted) {
                viewModel.addPost(newPost);
              }
            },
            child: const Icon(Icons.edit),
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
  _PostListTile({required this.post, required this.viewModel});

  FeedPostViewModel viewModel;

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
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row 1: Author Info (Avatar | Name + Date)
              Row(
                children: [
                  CircleAvatar(
                    // Use author's avatar if available, otherwise display initial
                    radius: 24,
                    backgroundColor: colorScheme.primaryContainer,
                    backgroundImage: post.author.avatar != null
                        ? NetworkImage(
                            post.author.avatar!.uri.toString(),
                          ) // Assuming AppFile has a 'url' property
                        : null,
                    child: post.author.avatar == null
                        ? Text(
                            (post.author.name ?? '?')
                                .substring(0, 1)
                                .toUpperCase(),
                            style: TextStyle(
                              fontSize: 12,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                post.author.name!,
                                style: theme.textTheme.labelMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 4),
                            FilledButton.tonal(
                              onPressed: () {},
                              style: FilledButton.styleFrom(
                                backgroundColor: colorScheme.tertiaryContainer,
                                foregroundColor:
                                    colorScheme.onTertiaryContainer,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 4,
                                ), // Strips left/right and top/bottom inner spaces
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                textStyle: theme.textTheme.labelSmall,
                              ),
                              child: const Text('Follow Up?'),
                            ),
                          ],
                        ),
                        Text(
                          timeago.format(post.created),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MenuAnchor(
                    // 1. Set the anchor's alignment origin to the bottom-right of your button
                    alignmentOffset: const Offset(
                      -50,
                      5,
                    ), // 2. Shift it left to expand leftwards (adjust -120 based on your menu width)
                    builder: (context, controller, child) {
                      return IconButton.filledTonal(
                        onPressed: () {
                          if (controller.isOpen) {
                            controller.close();
                          } else {
                            controller.open();
                          }
                        },
                        icon: const Icon(Icons.more_horiz),
                      );
                    },
                    menuChildren: [
                      MenuItemButton(
                        leadingIcon: const Icon(Icons.favorite_border),
                        onPressed: () {},
                        child: const Text('Like'),
                      ),
                      MenuItemButton(
                        leadingIcon: const Icon(Icons.bookmark_border),
                        onPressed: () {},
                        child: const Text('Save'),
                      ),
                      MenuItemButton(
                        leadingIcon: const Icon(Icons.share_outlined),
                        onPressed: () {},
                        child: const Text('Share'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Row 2: Post content (Title, Body, Photos)
              Text(post.title ?? '', style: theme.textTheme.titleMedium),
              if (post.body != null) ...[
                const SizedBox(height: 4),
                FeedPostViewerBodyPreview(
                  initialJson: post.body,
                  viewModel: viewModel,
                  maxLines: 2,
                ),
              ],
              if (post.photos.isNotEmpty) ...[
                const SizedBox(height: 12),
                SizedBox(
                  height: 200,
                  child: Row(
                    spacing: 8,
                    children: post.photos.take(2).map((photo) {
                      return Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            photo.uri.toString(),
                            fit: BoxFit.cover,
                            height: 200,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  color: colorScheme.surfaceContainerHigh,
                                  child: const Center(
                                    child: Icon(
                                      Icons.broken_image_outlined,
                                      size: 48,
                                    ),
                                  ),
                                ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Row(
                spacing: 2,
                children: [
                  FilledButton(
                    onPressed: () {},
                    child: const Text('View post'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Show related'),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
