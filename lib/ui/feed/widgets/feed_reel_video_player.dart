import 'package:chewie/chewie.dart';
import 'package:emombti/domain/models/feed/feed.dart';
import 'package:emombti/ui/social/view_models/social_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class FeedReelVideoPlayer extends StatefulWidget {
  final bool pauseControlFromParent;
  final Reel feedReel;

  const FeedReelVideoPlayer({
    super.key,
    required this.feedReel,
    required this.pauseControlFromParent,
  });

  @override
  State<FeedReelVideoPlayer> createState() => _FeedReelVideoPlayerState();
}

class _FeedReelVideoPlayerState extends State<FeedReelVideoPlayer> {
  late final VideoPlayerController _controller;

  // video state
  late bool _isInitialized = false;
  late bool _initFailed = false;
  late bool _isPlaying = false;
  late bool _isBuffering = false;
  Duration _lastPosition = Duration.zero;
  DateTime _lastPositionUpdateTime = DateTime.now();
  bool _isStuck = false;
  double _videoAspectRatio = 16 / 9;
  bool get isLandscape => _videoAspectRatio > 1;

  // mode state
  List<bool> currentModes = [];
  bool playMode = true;
  bool cleanMode = false;
  bool fullScreenMode = false;

  void playOrPause() {
    if (!_isInitialized) return;
    if (_isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  void play() {
    if (!_isInitialized) return;
    _controller.play();
  }

  void pause() {
    if (!_isInitialized) return;
    _controller.pause();
  }

  void enterCleanMode() {
    setState(() {
      cleanMode = true;
      playMode = false;
    });
  }

  void quitCleanMode() {
    setState(() {
      cleanMode = false;
      playMode = true;
    });
  }

  void enterFullScreenMode() async {
    // 1. 隐藏状态栏和虚拟按键，进入沉浸式全屏
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    await Future.delayed(const Duration(milliseconds: 300), () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    });
    setState(() {
      fullScreenMode = true;
    });
  }

  void quitFullScreenMode() {
    setState(() {
      fullScreenMode = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      widget.feedReel.videoUrl.uri,
    );
    _controller.addListener(videoPlayerControllerListener);
    _controller.initialize().onError((error, stackTrace) {
      debugPrint(error.toString());
      setState(() => _initFailed = true);
    });
  }

  @override
  void didUpdateWidget(covariant FeedReelVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.pauseControlFromParent ? pause() : play();
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
      _videoAspectRatio = _controller.value.aspectRatio;
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

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Stack(
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
                    height: cleanMode
                        ? constraints.maxHeight * 0.3
                        : constraints.maxHeight,
                    width: constraints.maxWidth,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        if (playMode) {
                          playOrPause();
                        } else {
                          setState(() {
                            cleanMode = false;
                          });
                        }
                      },
                      child: _buildVideoLayer(context),
                    ),
                  ),
                  if (cleanMode)
                    Expanded(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.fastOutSlowIn,
                        child: _FeedReelComments(onClose: quitCleanMode),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (!cleanMode)
          // Title & Subtitle
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
        // if (!cleanMode)
        //   Positioned.fill(
        //     child: Align(
        //       alignment: Alignment.bottomRight,
        //       child: _FeedReelVideoPlayerActions(
        //         onCommentsToggle: enterCleanMode,
        //       ),
        //     ),
        //   ),
      ],
    );
  }

  Widget _buildVideoLayer(BuildContext context) {
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
        if (isLandscape && !cleanMode)
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: _videoAspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
              // if (!cleanMode && isLandscape && !fullScreenMode)
              //   GestureDetector(
              //     onTap: enterFullScreenMode,
              //     child: Container(
              //       padding: const EdgeInsets.symmetric(
              //         horizontal: 6,
              //         // vertical: 6,
              //       ),
              //       margin: EdgeInsets.only(top: 6),
              //       decoration: BoxDecoration(
              //         color: theme.colorScheme.inverseSurface,
              //         borderRadius: BorderRadius.circular(20),
              //       ),
              //       child: Row(
              //         mainAxisSize: MainAxisSize.min,
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Icon(
              //             Icons.fullscreen,
              //             color: theme.colorScheme.surfaceBright,
              //             size: 20,
              //           ),
              //           const SizedBox(width: 4),
              //           Text(
              //             'Full Screen',
              //             style: theme.textTheme.labelSmall?.copyWith(
              //               color: theme.colorScheme.surfaceBright,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
            ],
          ),

        if (!isLandscape || cleanMode)
          Positioned.fill(
            child: FittedBox(
              fit: BoxFit.contain,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
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

class FeedReelChewie extends StatefulWidget {
  const FeedReelChewie({
    super.key,
    required this.feedReel,
    required this.socialViewModel,
  });

  final Reel feedReel;

  final SocialViewModel socialViewModel;

  @override
  State<FeedReelChewie> createState() => _FeedReelChewieState();
}

class _FeedReelChewieState extends State<FeedReelChewie> {
  late final VideoPlayerController _vpController;
  ChewieController? _chController;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _vpController = VideoPlayerController.networkUrl(
      widget.feedReel.videoUrl.uri,
    );
    await _vpController.initialize();
    setState(() {
      _chController = ChewieController(
        customControls: const MaterialControls(),
        videoPlayerController: _vpController,
        autoPlay: true,
        looping: true,
      );
    });
  }

  @override
  void dispose() {
    _vpController.dispose();
    _chController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Ensures it stays transparent
        statusBarIconBrightness: Brightness.light, // White icons for Android
        statusBarBrightness: Brightness.dark, // White icons for iOS
      ),
      child: ColoredBox(
        color: Colors.black,
        child: _chController == null
            ? const SizedBox.shrink()
            : Chewie(controller: _chController!),
      ),
    );
  }
}
