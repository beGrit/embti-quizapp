import 'package:flutter/material.dart';

import '../../../domain/models/content/content.dart';
import '../view_models/slideshow_viewmodel.dart';

class SlideshowHomeSection extends StatelessWidget {
  const SlideshowHomeSection({super.key, required this.viewModel});

  final SlideshowViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        if (viewModel.banners.isEmpty) return const SizedBox.shrink();

        return Column(
          children: [
            _buildBannerCards(colorScheme),
            const SizedBox(height: 12),
            _buildIndicators(colorScheme),
          ],
        );
      },
    );
  }

  Widget _buildBannerCards(ColorScheme colorScheme) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: viewModel.pageController,
        onPageChanged: viewModel.handlePageChanged,
        itemCount: viewModel.banners.length,
        itemBuilder: (context, index) {
          return _BannerMediaCard(
            banner: viewModel.banners[index],
            onPrev: viewModel.previousPage,
            onNext: viewModel.nextPage,
          );
        },
      ),
    );
  }

  Widget _buildIndicators(ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        viewModel.banners.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: viewModel.currentPage == index ? 24 : 8,
          decoration: BoxDecoration(
            color: viewModel.currentPage == index
                ? colorScheme.primary
                : colorScheme.outlineVariant,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

class _BannerMediaCard extends StatefulWidget {
  const _BannerMediaCard({
    required this.banner,
    required this.onPrev,
    required this.onNext,
  });

  final BannerContent banner;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  @override
  State<_BannerMediaCard> createState() => _BannerMediaCardState();
}

class _BannerMediaCardState extends State<_BannerMediaCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Material(
        elevation: 2.0,
        shadowColor: theme.shadowColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // 1. Media Layer
            _buildMediaContent(widget.banner),

            // 2. Gradient overlay
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black54],
                ),
              ),
            ),

            // 3. Text Content
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Text(
                widget.banner.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // 4. Arrow Controls (Conditional visibility)
            if (_isHovered) ...[
              _ArrowButton(
                icon: Icons.chevron_left,
                alignment: Alignment.centerLeft,
                onPressed: widget.onPrev,
              ),
              _ArrowButton(
                icon: Icons.chevron_right,
                alignment: Alignment.centerRight,
                onPressed: widget.onNext,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMediaContent(BannerContent banner) {
    if (banner.mediaType == 'video') {
      return Container(
        color: Colors.black87,
        child: const Center(
          child: Icon(Icons.play_circle_outline, color: Colors.white, size: 48),
        ),
      );
    }
    return Image.network(
      banner.mediaUrl,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          const Center(child: Icon(Icons.error_outline)),
    );
  }
}

class _ArrowButton extends StatelessWidget {
  const _ArrowButton({
    required this.icon,
    required this.alignment,
    required this.onPressed,
  });

  final IconData icon;
  final Alignment alignment;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: IconButton.filled(
          onPressed: onPressed,
          style: IconButton.styleFrom(
            backgroundColor: Colors.black.withValues(alpha: 0.3),
            foregroundColor: Colors.white,
            hoverColor: Colors.black.withValues(alpha: 0.5),
          ),
          icon: Icon(icon, size: 24),
        ),
      ),
    );
  }
}
