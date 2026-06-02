import 'package:emombti/domain/models/feed/feed.dart';
import 'package:emombti/ui/core/ui/view_models/video_player.dart';
import 'package:emombti/ui/social/view_models/social_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SimpleVideoPlayerWidget extends StatelessWidget {
  final SimpleVideoPlayerViewModel viewModel;
  final String title;

  const SimpleVideoPlayerWidget({
    super.key,
    required this.viewModel,
    this.title = "Video Title",
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        final controller = viewModel.controller;

        if (controller == null || !controller.value.isInitialized) {
          return const AspectRatio(
            aspectRatio: 16 / 9,
            child: Center(child: CircularProgressIndicator.adaptive()),
          );
        }

        // Determine if we should show the UI overlays
        final bool showControls = !viewModel.isPlaying || viewModel.isFinished;

        // 1. Video Content (Always Visible)
        Widget videoContent = AspectRatio(
          aspectRatio: 16 / 9,
          child: VideoPlayer(controller),
        );

        // 2. Play/Pause/Replay Icon Logic
        IconData toggleGestureIcon = Icons.play_circle_filled;
        if (viewModel.isFinished) {
          toggleGestureIcon = Icons.replay_circle_filled;
        } else if (viewModel.isPlaying) {
          toggleGestureIcon = Icons.pause_circle_filled;
        }

        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              children: [
                videoContent,

                // Main Interaction Layer
                Positioned.fill(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: viewModel.togglePlay,
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: !showControls
                          ? const SizedBox.shrink()
                          : Container(
                              color: Colors.black26,
                              child: Stack(
                                children: [
                                  // Title (Top)
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.black54,
                                            Colors.transparent,
                                          ],
                                        ),
                                      ),
                                      child: Text(
                                        title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Center Play/Pause Icon
                                  Center(
                                    child: Icon(
                                      toggleGestureIcon,
                                      color: Colors.white70,
                                      size: 50.0,
                                    ),
                                  ),

                                  // Progress Bar (Bottom)
                                  Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: VideoProgressIndicator(
                                      controller,
                                      allowScrubbing: true,
                                      colors: const VideoProgressColors(
                                        playedColor: Colors.red,
                                        bufferedColor: Colors.white24,
                                        backgroundColor: Colors.black26,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                ),

                // Buffering Indicator (Independent of showControls)
                if (viewModel.isBuffering)
                  const Center(
                    child: CircularProgressIndicator(color: Colors.white70),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class FeedReelVideoPlayer extends StatefulWidget {
  const FeedReelVideoPlayer({
    super.key,
    required this.feedReel,
    required this.socialViewModel,
  });

  final Reel feedReel;

  final SocialViewModel socialViewModel;

  @override
  State<FeedReelVideoPlayer> createState() => _FeedReelVideoPlayerState();
}

class _FeedReelVideoPlayerState extends State<FeedReelVideoPlayer> {
  late final VideoPlayerController _controller;
  late bool _isInitialized = false;
  late bool _initFailed = false;
  late bool _isPlaying = false;
  late bool _isBuffering = false;
  Duration _lastPosition = Duration.zero;
  DateTime _lastPositionUpdateTime = DateTime.now();
  bool _isStuck = false;
  bool playMode = true;
  bool commentMode = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      widget.feedReel.videoUrl.uri,
    );
    _controller.addListener(videoPlayerControllerListener);
    _controller.initialize().onError((error, stackTrace) {
      setState(() => _initFailed = true);
    });
  }

  @override
  void dispose() {
    _controller.removeListener(videoPlayerControllerListener);
    _controller.dispose();
    super.dispose();
  }

  void videoPlayerControllerListener() {
    final value = _controller.value;

    // Handle Error State
    if (value.hasError) {
      if (!_initFailed) {
        setState(() => _initFailed = true);
      }
      return;
    }

    // Handle Auto-Play on Initialization
    if (value.isInitialized && !_isInitialized) {
      setState(() => _isInitialized = true);
      _controller.play();
      _lastPositionUpdateTime = DateTime.now(); // Reset timer right as it plays
      return;
    }

    // Sync Playing State safely
    if (value.isPlaying != _isPlaying) {
      setState(() => _isPlaying = value.isPlaying);
    }

    // Sync Buffering State safely
    if (value.isBuffering != _isBuffering) {
      setState(() => _isBuffering = value.isBuffering);
    }

    if (value.isPlaying) {
      final currentPosition = value.position;
      final now = DateTime.now();

      if (currentPosition != _lastPosition) {
        // Progress is moving -> Video is healthy!
        _lastPosition = currentPosition;
        _lastPositionUpdateTime = now;

        if (_isStuck) {
          setState(() => _isStuck = false);
        }
      } else {
        // Progress is deadlocked while 'isPlaying' is true.
        // Calculate how long it has been frozen.
        final frozenDuration = now.difference(_lastPositionUpdateTime);

        // If frozen for more than 500ms, mark as stuck (micro-stuttering/lag)
        if (frozenDuration > const Duration(milliseconds: 500) && !_isStuck) {
          setState(() => _isStuck = true);
        }
      }
    } else {
      if (_isStuck) {
        setState(() => _isStuck = false);
      }
    }
  }

  void playOrPause() {
    if (!_isInitialized) return;
    if (_isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  void enterCommentMode() {
    setState(() {
      commentMode = true;
      playMode = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ColoredBox(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) => Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.fastOutSlowIn,
                      height: commentMode
                          ? constraints.maxHeight * 0.3
                          : constraints.maxHeight,
                      width: constraints.maxWidth,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          if (!commentMode) {
                            playOrPause();
                          } else {
                            // quit comment mode.
                            setState(() {
                              commentMode = false;
                            });
                          }
                        },
                        child: _buildVideoLayer(),
                      ),
                    ),
                    if (commentMode)
                      Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.fastOutSlowIn,
                          child: _FeedReelComments(
                            onClose: () {
                              setState(() {
                                commentMode = false;
                              });
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          if (!commentMode)
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
                    padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.feedReel.title != null)
                          Text(
                            widget.feedReel.title!,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        if (widget.feedReel.subTitle != null) ...[
                          const SizedBox(height: 6),
                          Text(
                            widget.feedReel.subTitle!,
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
          if (!commentMode)
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomRight,
                child: _FeedReelVideoPlayerActions(
                  onCommentsToggle: enterCommentMode,
                ),
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
    if (!_isInitialized) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    return Stack(
      children: [
        Positioned.fill(
          child: FittedBox(
            fit: BoxFit.contain,
            child: SizedBox(
              width: c.value.size.width,
              height: c.value.size.height,
              child: VideoPlayer(c),
            ),
          ),
        ),
        if (_isInitialized && !_isPlaying)
          const IgnorePointer(
            child: Center(
              child: Icon(
                Icons.play_circle_fill,
                size: 72,
                color: Colors.white54,
              ),
            ),
          ),
        if (_isInitialized && _isStuck && !_isPlaying)
          const Center(
            child: CircularProgressIndicator(
              color: Colors.white54,
              strokeWidth: 2,
            ),
          ),
      ],
    );
  }
}

class _FeedReelVideoPlayerActions extends StatefulWidget {
  const _FeedReelVideoPlayerActions({required this.onCommentsToggle});

  final VoidCallback onCommentsToggle;

  @override
  State<_FeedReelVideoPlayerActions> createState() =>
      _FeedReelVideoPlayerActionsState();
}

class _FeedReelVideoPlayerActionsState
    extends State<_FeedReelVideoPlayerActions> {
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = false;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 16,
      children: [
        GestureDetector(
          onTap: () {},
          child: Column(
            children: [
              if (!isLiked)
                Icon(
                  Icons.favorite_rounded,
                  color: theme.colorScheme.surfaceContainer,
                  size: 40,
                ),
              if (isLiked)
                Icon(Icons.favorite_rounded, color: Colors.red, size: 40),
              Text(
                'Likes',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.surfaceBright,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: widget.onCommentsToggle,
          child: Column(
            children: [
              Icon(
                Icons.comment_rounded,
                color: theme.colorScheme.surfaceContainer,
                size: 40,
              ),
              Text(
                'Comments',
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
  }
}

class _FeedReelComments extends StatefulWidget {
  const _FeedReelComments({required this.onClose});

  final VoidCallback onClose;

  @override
  State<_FeedReelComments> createState() => _FeedReelCommentsState();
}

class _FeedReelCommentsState extends State<_FeedReelComments> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.surfaceBright,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Comments',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  IconButton(
                    onPressed: widget.onClose,
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
