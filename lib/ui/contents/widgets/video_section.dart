// lib/ui/contents/widgets/video_section.dart

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../view_models/video_viewmodel.dart';

class VideoHomeSection extends StatelessWidget {
  final VideoViewModel viewModel;

  const VideoHomeSection({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Videos',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            _buildPlayerArea(context),
          ],
        );
      },
    );
  }

  Widget _buildPlayerArea(BuildContext context) {
    if (viewModel.isLoading) {
      return const AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(child: CircularProgressIndicator.adaptive()),
      );
    }

    if (viewModel.error != null) {
      return Center(
        child: Text(
          viewModel.error!,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    final controller = viewModel.controller;
    if (controller == null || !viewModel.isInitialized)
      return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: Stack(
            children: [
              // 1. The Video Player
              GestureDetector(
                onTap: viewModel.togglePlay,
                child: VideoPlayer(controller),
              ),

              // 2. Play Button Overlay (Visible only when paused and not finished)
              if (!controller.value.isPlaying && !viewModel.isFinished)
                IgnorePointer(
                  child: Center(
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.black54,
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ),

              // 3. YouTube-style End Screen (Recommendations)
              if (viewModel.isFinished) _buildEndScreen(context),

              // 4. Progress Indicator (Bottom of video)
              if (!viewModel.isFinished)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: VideoProgressIndicator(
                    controller,
                    allowScrubbing: true,
                    colors: VideoProgressColors(
                      playedColor: Theme.of(context).colorScheme.primary,
                      bufferedColor: Colors.white24,
                      backgroundColor: Colors.black26,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEndScreen(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Up Next",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 110,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: viewModel.allVideos.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final video = viewModel.allVideos[index];
                return GestureDetector(
                  onTap: () => viewModel.playVideo(video),
                  child: Column(
                    children: [
                      Container(
                        width: 140,
                        height: 78,
                        decoration: BoxDecoration(
                          color: Colors.white10,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: const Icon(
                          Icons.play_circle_outline,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: 140,
                        child: Text(
                          video.id,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          TextButton.icon(
            onPressed: viewModel.togglePlay,
            icon: const Icon(Icons.replay, color: Colors.white),
            label: const Text("Replay", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
