import 'package:emombti/ui/core/ui/view_models/video_player.dart';
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
