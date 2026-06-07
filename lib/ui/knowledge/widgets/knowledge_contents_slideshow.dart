import 'dart:async';

import 'package:emombti/ui/knowledge/view_models/knowledge_contents_viewmodel.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/content/content.dart';

class KnowledgeContentsSlideshow extends StatefulWidget {
  const KnowledgeContentsSlideshow({super.key, required this.viewModel});

  final KnowledgeContentsViewModel viewModel;

  @override
  State<KnowledgeContentsSlideshow> createState() =>
      _KnowledgeContentsSlideshowState();
}

class _KnowledgeContentsSlideshowState
    extends State<KnowledgeContentsSlideshow> {
  late final PageController pageController;
  Timer? timer;
  int currentPage = 0;
  DateTime lastInteractionTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    widget.viewModel.loadBanners.addListener(_onLoadStatusChanged);
  }

  @override
  void dispose() {
    widget.viewModel.loadBanners.removeListener(_onLoadStatusChanged);
    timer?.cancel();
    pageController.dispose();
    super.dispose();
  }

  void _onLoadStatusChanged() {
    if (widget.viewModel.loadBanners.running) {
      // Pause or reset timer if a refresh starts
      timer?.cancel();
      timer = null;
    } else if (!widget.viewModel.loadBanners.running &&
        widget.viewModel.banners.isNotEmpty) {
      // Data is ready, start the timer
      timer?.cancel();
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        final timeSinceInteraction = DateTime.now().difference(
          lastInteractionTime,
        );
        if (timeSinceInteraction.inSeconds >= 5) {
          autoNextPage();
        }
      });
    }
  }

  void _animateTo(int targetPage) {
    if (pageController.hasClients) {
      pageController.animateToPage(
        targetPage,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void autoNextPage() {
    if (widget.viewModel.banners.isEmpty) return;
    final targetPage = (currentPage + 1) % widget.viewModel.banners.length;
    _animateTo(targetPage);
  }

  void nextPage() {
    if (widget.viewModel.banners.isEmpty) return;
    lastInteractionTime = DateTime.now();
    final targetPage = (currentPage + 1) % widget.viewModel.banners.length;
    _animateTo(targetPage);
  }

  void previousPage() {
    if (widget.viewModel.banners.isEmpty) return;
    lastInteractionTime = DateTime.now();
    final targetPage = currentPage == 0
        ? widget.viewModel.banners.length - 1
        : currentPage - 1;
    _animateTo(targetPage);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        if (widget.viewModel.banners.isEmpty) return const SizedBox.shrink();

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
        controller: pageController,
        onPageChanged: (page) {
          setState(() {
            currentPage = page;
          });
        },
        itemCount: widget.viewModel.banners.length,
        itemBuilder: (context, index) {
          return _BannerMediaCard(
            banner: widget.viewModel.banners[index],
            onPrev: previousPage,
            onNext: nextPage,
          );
        },
      ),
    );
  }

  Widget _buildIndicators(ColorScheme colorScheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.viewModel.banners.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: currentPage == index ? 24 : 8,
          decoration: BoxDecoration(
            color: currentPage == index
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
