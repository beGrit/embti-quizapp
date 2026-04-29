// lib/ui/contents/widgets/video_section.dart

import 'package:emombti/ui/core/ui/view_models/video_player.dart';
import 'package:flutter/material.dart';

import '../../core/ui/widgets/video_player.dart';
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
            _buildHeader(context),
            const SizedBox(height: 8),
            _buildVideoPlayer(context),
          ],
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(
        'Videos',
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildVideoPlayer(BuildContext context) {
    Widget content = const SizedBox.shrink();
    if (viewModel.isLoading) {
      content = const AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(child: CircularProgressIndicator.adaptive()),
      );
    } else if (viewModel.error != null) {
      content = AspectRatio(
        aspectRatio: 16 / 9,
        child: Center(child: Text(viewModel.error!)),
      );
    } else {
      content = SimpleVideoPlayerWidget(
        viewModel: viewModel.playerVM as SimpleVideoPlayerViewModel,
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      // Use ternary operator: condition ? widgetIfTrue : widgetIfFalse
      child: content,
    );
  }
}
