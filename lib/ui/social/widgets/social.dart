import 'package:emombti/domain/models/social/social.dart';
import 'package:emombti/utils/number_formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/social_viewmodel.dart';

class InteractionBarWidget extends StatelessWidget {
  final InteractionViewModel viewModel;

  const InteractionBarWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<SocialMeta?>(
      valueListenable: viewModel.socialModel,
      builder: (context, meta, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 5,
          children: [
            if (meta == null)
              const CircularProgressIndicator()
            else ...[
              ActionButton(
                icon: meta.isLiked ? Icons.favorite : Icons.favorite_border,
                count: meta.likesCount,
                suffix: ' Likes',
                onTap: viewModel.toggleLike,
                color: meta.isLiked
                    ? Colors.red
                    : Theme.of(context).colorScheme.secondary,
              ),
              ActionButton(
                icon: meta.isFavorited ? Icons.star : Icons.star_border,
                count: meta.favoritesCount,
                suffix: ' Favorites',
                onTap: viewModel.toggleFavorite,
                color: meta.isFavorited
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.secondary,
              ),
              ActionButton(
                icon: Icons.chat_bubble_outline,
                count: meta.commentsCount,
                suffix: ' Comments',
                onTap: viewModel.onCommentRequest,
                color: Theme.of(context).colorScheme.secondary,
              ),
              ActionButton(
                icon: Icons.share_outlined,
                count: meta.sharesCount,
                suffix: ' Shares',
                onTap: null,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ],
          ],
        );
      },
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.icon,
    this.count,
    this.suffix,
    this.onTap,
    this.color,
  });

  final IconData icon;
  final int? count;
  final String? suffix;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 32),
            // Only render the spacing and text if count is not null
            if (count != null) ...[
              Text(
                '${NumberFormatter.formatSocialCount(count ?? 0)}${suffix ?? ""}',
                style: TextStyle(fontSize: 9),
              ),
            ] else
              Text(suffix ?? "", style: TextStyle(fontSize: 10)),
          ],
        ),
      ),
    );
  }
}

class CommentSectionWidget extends StatelessWidget {
  final CommentSectionViewModel viewModel;
  final StickyInputViewModel stickyInputViewModel;

  const CommentSectionWidget({
    super.key,
    required this.viewModel,
    required this.stickyInputViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: viewModel),
        ChangeNotifierProvider.value(value: stickyInputViewModel),
      ],
      child: Consumer2<CommentSectionViewModel, StickyInputViewModel>(
        builder: (context, vm, stickyVM, _) {
          return ValueListenableBuilder<SocialMeta?>(
            valueListenable: vm.socialModel,
            builder: (context, meta, _) {
              final comments = meta?.comments ?? [];

              if (vm.isLoading && comments.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                );
              }

              if (comments.isEmpty && !stickyVM.isSubmitting) {
                return SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 64.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No comments yet.',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        Text(
                          'Be the first to share your thoughts!',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    // Show submitting indicator at the top
                    if (stickyVM.isSubmitting && index == 0) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      );
                    }

                    final commentIndex = stickyVM.isSubmitting
                        ? index - 1
                        : index;

                    if (commentIndex == comments.length && !vm.hasMore) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            'No more comments',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ),
                      );
                    }

                    if (commentIndex == comments.length) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    }

                    final comment = comments[commentIndex];
                    return CommentItem(
                      comment: comment,
                      onLike: () => vm.toggleLike(comment.id),
                    );
                  },
                  childCount:
                      comments.length +
                      (vm.isFetchingMore || !vm.hasMore ? 1 : 0) +
                      (stickyVM.isSubmitting ? 1 : 0),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CommentItem extends StatelessWidget {
  final Comment comment;
  final VoidCallback? onLike;

  const CommentItem({super.key, required this.comment, this.onLike});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Check if the comment is "new" (within last 5 seconds) to play animation
    final isNew = DateTime.now().difference(comment.createdAt).inSeconds < 5;

    Widget content = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: colorScheme.primaryContainer,
          backgroundImage:
              comment.authorAvatarUrl != null &&
                  comment.authorAvatarUrl!.isNotEmpty
              ? NetworkImage(comment.authorAvatarUrl!)
              : null,
          child: comment.authorAvatarUrl == null
              ? Text(comment.authorName[0].toUpperCase())
              : null,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    comment.authorName,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      comment.authorMbti,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    _formatDate(comment.createdAt),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(comment.content, style: theme.textTheme.bodySmall),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );

    if (isNew) {
      return TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(seconds: 2),
        curve: Curves.easeOut,
        builder: (context, value, child) {
          // Pulse the background color from primaryContainer to surface
          return Container(
            decoration: BoxDecoration(
              color: Color.lerp(
                colorScheme.primaryContainer.withValues(alpha: 0.3),
                Colors.transparent,
                value,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            margin: const EdgeInsets.symmetric(vertical: 2),
            child: child,
          );
        },
        child: content,
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: content,
    );
  }

  String _formatDate(DateTime date) {
    final duration = DateTime.now().difference(date);
    if (duration.inMinutes < 1) return 'now';
    if (duration.inMinutes < 60) return '${duration.inMinutes}m';
    if (duration.inHours < 24) return '${duration.inHours}h';
    return '${date.month}/${date.day}';
  }
}

class StickyInputBarWidget extends StatefulWidget {
  final StickyInputViewModel viewModel;

  const StickyInputBarWidget({super.key, required this.viewModel});

  @override
  State<StickyInputBarWidget> createState() => _StickyInputBarWidgetState();
}

class _StickyInputBarWidgetState extends State<StickyInputBarWidget> {
  final TextEditingController _controller = TextEditingController();

  void _handleSubmit() {
    if (_controller.text.trim().isNotEmpty) {
      widget.viewModel.submitComment(_controller.text);
      _controller.clear();
      // Optionally unfocus after submitting
      widget.viewModel.focusNode.unfocus();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => widget.viewModel.requestFocus(),
      child: Container(
        padding: EdgeInsets.only(left: 12, right: 12, top: 4, bottom: 16.0),
        decoration: BoxDecoration(
          color: colorScheme.surfaceBright,
          border: Border(
            top: BorderSide(color: colorScheme.outlineVariant, width: 1),
          ),
        ),
        child: ListenableBuilder(
          listenable: widget.viewModel,
          builder: (context, child) {
            return Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: widget.viewModel.focusNode,
                    enabled: !widget.viewModel.isSubmitting,
                    onSubmitted: (_) => _handleSubmit(),
                    textInputAction: TextInputAction.send,
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      filled: true,
                      fillColor: colorScheme.surfaceContainerHighest,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: widget.viewModel.isSubmitting
                      ? null
                      : _handleSubmit,
                  icon: widget.viewModel.isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.send),
                  style: IconButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class SocialComposeWidget extends StatefulWidget {
  const SocialComposeWidget({super.key, required this.viewModel});

  final SocialViewModel viewModel;

  @override
  State<SocialComposeWidget> createState() => _SocialComposeWidgetState();
}

class _SocialComposeWidgetState extends State<SocialComposeWidget> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ValueListenableBuilder(
        valueListenable: widget.viewModel.socialModel,
        builder: (context, value, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 16,
            children: [
              GestureDetector(
                onTap: () {},
                child: Column(
                  children: [
                    if (!value.isLiked)
                      Icon(
                        Icons.favorite_rounded,
                        color: theme.colorScheme.surfaceContainer,
                        size: 40,
                      ),
                    if (value.isLiked)
                      Icon(Icons.favorite_rounded, color: Colors.red, size: 40),
                    Text(
                      value.favoritesCount.toString(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.surfaceBright,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showCommentsBottomSheet(context);
                },
                child: Column(
                  children: [
                    Icon(
                      Icons.comment_rounded,
                      color: theme.colorScheme.surfaceContainer,
                      size: 40,
                    ),
                    Text(
                      value.commentsCount.toString(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.surfaceBright,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }

  void _showCommentsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.4,
          maxChildSize: 0.9,
          minChildSize: 0.3,
          expand: false,
          builder: (context, scrollController) {
            return ValueListenableBuilder(
              valueListenable: widget.viewModel.socialModel,
              builder: (context, value, _) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Text(
                          'Comments',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Text(
                          '${value.commentsCount} comments',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
