import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/social_viewmodel.dart';

class InteractionBarWidget extends StatelessWidget {
  final InteractionViewModel viewModel;

  const InteractionBarWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    // We use ChangeNotifierProvider.value because the VM is already created
    return ChangeNotifierProvider.value(
      value: viewModel,
      child: Consumer<InteractionViewModel>(
        builder: (context, vm, _) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildActionButton(
                  icon: vm.meta.isLiked ? Icons.favorite : Icons.favorite,
                  color: vm.meta.isLiked ? Colors.red : Colors.grey,
                  label: '${vm.meta.likesCount}',
                  onTap: vm.toggleLike,
                ),
                const SizedBox(width: 20),
                _buildActionButton(
                  icon: Icons.star,
                  color: Colors.orange,
                  label: 'Star',
                  onTap: null,
                ),
                const SizedBox(width: 20),
                const SizedBox(width: 20),
                _buildActionButton(
                  icon: Icons.share_outlined,
                  label: '${vm.meta.sharesCount}',
                  onTap: () {},
                ),
              ],
            ),
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
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 4),
          Text(label),
        ],
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
              return Container(
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(color: Colors.grey),
                    right: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Text(vm.comments[index].content),
              );
            }, childCount: vm.comments.length),
          );
        },
      ),
    );
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
        top: 8,
        bottom: MediaQuery.of(context).padding.bottom + 4,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        border: Border(
          top: BorderSide(color: colorScheme.outlineVariant, width: 0.5),
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
                fillColor: colorScheme.surface,
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
