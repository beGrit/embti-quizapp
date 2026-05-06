import 'dart:math' as math;

import 'package:emombti/domain/models/social/social.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/social_viewmodel.dart';

class InteractionBarWidget extends StatelessWidget {
  final InteractionViewModel viewModel;

  const InteractionBarWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<InteractionViewModel>(
        builder: (context, vm, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5,
            children: [
              _buildActionButton(
                // Use favorite_border when not liked for better visual feedback
                icon: vm.meta.isLiked ? Icons.favorite : Icons.favorite_border,
                color: vm.meta.isLiked
                    ? Colors.red
                    : Theme.of(context).colorScheme.secondary,
                label: '${vm.meta.likesCount} Likes',
                onTap: vm.toggleLike,
              ),
              _buildActionButton(
                icon: vm.meta.isFavorited ? Icons.star : Icons.star_border,
                color: vm.meta.isFavorited
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.secondary,
                label: '${vm.meta.favoritesCount} Favorites',
                onTap: vm.toggleFavorite,
              ),
              _buildActionButton(
                icon: Icons.chat_bubble_outline,
                label: '${vm.meta.commentsCount} Comments',
                onTap: null,
              ),
              _buildActionButton(
                icon: Icons.share_outlined,
                label: '${vm.meta.sharesCount} Shares',
                onTap: null,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
    Color? color,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentSectionWidget extends StatelessWidget {
  final CommentSectionViewModel viewModel;

  const CommentSectionWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<CommentSectionViewModel>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            );
          }

          if (vm.comments.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.chat_bubble_outline, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No comments yet.',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                Text(
                  'Be the first to share your thoughts!',
                  style: TextStyle(fontSize: 14, color: Colors.blueGrey),
                ),
              ],
            );
          }

          return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final comment = vm.comments[index];
              return CommentItem(comment: comment, onLike: null);
            }, childCount: vm.comments.length),
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

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: colorScheme.primaryContainer,
          backgroundImage: comment.authorAvatarUrl != null
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
              // Header: Name • MBTI • Time
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

              // Comment Text
              Text(comment.content, style: theme.textTheme.bodySmall),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    // Quick helper for time ago - you can use the 'timeago' package here instead
    final duration = DateTime.now().difference(date);
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        top: 4,
        bottom: math.max(MediaQuery.of(context).padding.bottom - 12, 4.0),
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceBright,
        border: Border(
          top: BorderSide(color: colorScheme.outlineVariant, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
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
            // Using filled for the primary action
            onPressed: () {
              widget.viewModel.submitComment(_controller.text);
              _controller.clear();
            },
            icon: const Icon(Icons.send),
            style: IconButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
