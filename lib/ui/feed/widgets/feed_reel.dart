import 'package:emombti/ui/feed/view_models/feed_reel_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// Vertical, full-viewport paging feed of videos (TikTok / Instagram Reels style).
class FeedReel extends StatefulWidget {
  const FeedReel({super.key, required this.viewModel});

  final FeedReelViewModel viewModel;

  @override
  State<FeedReel> createState() => _FeedReelState();
}

class _FeedReelState extends State<FeedReel> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.viewModel.currentIndex,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = widget.viewModel;
    if (vm.items.isEmpty) {
      return const Center(child: Text('No videos'));
    }

    return ListenableBuilder(
      listenable: vm,
      builder: (context, _) {
        return PageView.custom(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          allowImplicitScrolling: false,
          onPageChanged: vm.onPageChanged,

          // 使用 childrenDelegate 来精细化控制子 Widget 的生命周期
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) {
              final item = vm.items[index];
              return _ReelPage(
                key: ValueKey<String>(item.id),
                item: item,
                index: index,
                currentIndex: vm.currentIndex,
              );
            },
            childCount: vm.items.length,
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: true,
          ),
        );
      },
    );
  }
}

class _ReelPage extends StatefulWidget {
  const _ReelPage({
    super.key,
    required this.item,
    required this.index,
    required this.currentIndex,
  });

  final FeedReelItem item;
  final int index;
  final int currentIndex;

  @override
  State<_ReelPage> createState() => _ReelPageState();
}

class _ReelPageState extends State<_ReelPage> {
  static const int _preloadRadius = 1;

  VideoPlayerController? _controller;
  bool _initFailed = false;
  bool _userPaused = false;

  bool get _inPreloadWindow =>
      (widget.index - widget.currentIndex).abs() <= _preloadRadius;

  bool get _isActive => widget.index == widget.currentIndex;

  @override
  void initState() {
    super.initState();
    debugPrint('init: ' + widget.index.toString());
    if (_inPreloadWindow) {
      _startLoad();
    }
  }

  @override
  void didUpdateWidget(covariant _ReelPage oldWidget) {
    debugPrint('didUpdateWidget: ' + widget.index.toString());
    super.didUpdateWidget(oldWidget);
    final wasActive = widget.index == oldWidget.currentIndex;
    if (wasActive && !_isActive) {
      _userPaused = false;
    }
    if (_inPreloadWindow) {
      _startLoad();
    } else {
      _tearDown();
    }
    _applyPlayback();
  }

  @override
  void dispose() {
    debugPrint('dispose: ' + widget.index.toString());
    _controller?.removeListener(_onControllerUpdate);
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _startLoad() async {
    if (_controller != null || _initFailed) return;

    final c = VideoPlayerController.networkUrl(Uri.parse(widget.item.videoUrl));
    _controller = c;

    try {
      await c.initialize();
    } catch (_) {
      if (!mounted) {
        await c.dispose();
        return;
      }
      setState(() {
        _initFailed = true;
        _controller = null;
      });
      await c.dispose();
      return;
    }

    if (!mounted || _controller != c) {
      await c.dispose();
      if (_controller == c) _controller = null;
      return;
    }
    if (!_inPreloadWindow) {
      await c.dispose();
      _controller = null;
      return;
    }

    c.addListener(_onControllerUpdate);
    await c.setLooping(true);
    if (!mounted) return;
    setState(() {});
    _applyPlayback();
  }

  void _onControllerUpdate() {
    if (mounted) setState(() {});
  }

  void _tearDown() {
    _controller?.removeListener(_onControllerUpdate);
    _controller?.dispose();
    _controller = null;
    _userPaused = false;
    _initFailed = false;
  }

  void _applyPlayback() {
    final c = _controller;
    if (c == null || !c.value.isInitialized) return;

    if (_isActive) {
      if (_userPaused) {
        c.pause();
      } else {
        c.play();
      }
    } else {
      c.pause();
      c.seekTo(Duration.zero);
    }
  }

  void _onTap() {
    if (!_isActive) return;
    final c = _controller;
    if (c == null || !c.value.isInitialized) return;
    setState(() {
      _userPaused = c.value.isPlaying;
      if (c.value.isPlaying) {
        c.pause();
      } else {
        c.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build: ' + widget.index.toString());
    final padding = MediaQuery.paddingOf(context);
    final theme = Theme.of(context);

    return ColoredBox(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _onTap,
            child: _buildVideoLayer(),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.75),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 48, 16, 16 + padding.bottom),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.item.title != null)
                        Text(
                          widget.item.title!,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      if (widget.item.subtitle != null) ...[
                        const SizedBox(height: 6),
                        Text(
                          widget.item.subtitle!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_isActive &&
              _controller != null &&
              _controller!.value.isInitialized &&
              !_controller!.value.isPlaying)
            const IgnorePointer(
              child: Center(
                child: Icon(
                  Icons.play_circle_fill,
                  size: 72,
                  color: Colors.white54,
                ),
              ),
            ),
          if (_controller != null && _controller!.value.isBuffering)
            const Center(
              child: CircularProgressIndicator(
                color: Colors.white54,
                strokeWidth: 2,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildVideoLayer() {
    final c = _controller;
    if (_initFailed) {
      return Center(
        child: Text(
          'Could not load video',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: Colors.white54),
        ),
      );
    }
    if (c == null || !c.value.isInitialized) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    return FittedBox(
      fit: BoxFit.cover,
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: c.value.size.width,
        height: c.value.size.height,
        child: VideoPlayer(c),
      ),
    );
  }
}
