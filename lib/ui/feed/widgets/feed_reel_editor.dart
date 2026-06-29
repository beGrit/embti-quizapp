import 'dart:io';

import 'package:emombti/domain/models/feed/feed.dart';
import 'package:emombti/ui/core/ui/widgets/app_bar.dart';
import 'package:emombti/ui/feed/view_models/feed_reel_editor_viewmodel.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class FeedReelEditor extends StatefulWidget {
  const FeedReelEditor({super.key, required this.viewModel});

  final FeedReelEditorViewModel viewModel;

  @override
  State<FeedReelEditor> createState() => _FeedReelEditorState();
}

class _FeedReelEditorState extends State<FeedReelEditor> {
  late final TextEditingController _titleController;
  late final TextEditingController _subTitleController;
  final ImagePicker _picker = ImagePicker();

  VideoPlayerController? _videoController;
  bool _videoInitialized = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _subTitleController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subTitleController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  Future<void> _pickVideo(FeedReelEditorViewModel viewModel) async {
    final video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video == null) return;

    // Dispose the old controller if one exists.
    await _videoController?.dispose();
    _videoController = null;

    setState(() {
      _videoInitialized = false;
    });

    // Validate size inside the ViewModel (sets videoSizeError if too large).
    await viewModel.setSelectedVideo(video);

    // Do not initialise a preview for a rejected video.
    if (viewModel.videoSizeError != null) return;

    final controller = VideoPlayerController.file(File(video.path));
    await controller.initialize();

    if (mounted) {
      setState(() {
        _videoController = controller;
        _videoInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        widget.viewModel,
        widget.viewModel.saveCommand,
      ]),
      builder: (context, _) => _buildScaffold(context, widget.viewModel),
    );
  }

  Widget _buildScaffold(
    BuildContext context,
    FeedReelEditorViewModel viewModel,
  ) {
    final theme = Theme.of(context);
    final isRunning = viewModel.saveCommand.running;

    return PopScope(
      canPop: !isRunning,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: StandardAppBar(
          title: 'New Reel',
          leading: IconButton(
            onPressed: isRunning ? null : () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          ),
          actions: [
            if (isRunning)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: FilledButton(
                  onPressed: viewModel.selectedVideo == null
                      ? null
                      : () => _onPublish(context, viewModel),
                  child: const Text('Publish'),
                ),
              ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Video picker area ──────────────────────────────────────
              _VideoPickerTile(
                videoController: _videoController,
                videoInitialized: _videoInitialized,
                uploadProgress: viewModel.uploadProgress,
                onTap: isRunning ? null : () => _pickVideo(viewModel),
              ),

              // ── Size error banner ─────────────────────────────────────
              if (viewModel.videoSizeError != null) ...
                [
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 16,
                        color: theme.colorScheme.error,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          viewModel.videoSizeError!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              const SizedBox(height: 24),

              // ── Title field ───────────────────────────────────────────
              TextField(
                controller: _titleController,
                enabled: !isRunning,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                maxLines: null,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurfaceVariant.withValues(
                      alpha: 0.4,
                    ),
                  ),
                  border: InputBorder.none,
                ),
              ),
              Divider(height: 1, color: theme.colorScheme.outlineVariant),
              const SizedBox(height: 8),

              // ── Subtitle field ────────────────────────────────────────
              TextField(
                controller: _subTitleController,
                enabled: !isRunning,
                style: theme.textTheme.bodyMedium,
                maxLines: 3,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: 'Add a subtitle or description…',
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant.withValues(
                      alpha: 0.4,
                    ),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onPublish(
    BuildContext context,
    FeedReelEditorViewModel viewModel,
  ) async {
    final video = viewModel.selectedVideo;
    if (video == null) return;

    await viewModel.saveCommand.execute((
      title: _titleController.text.trim(),
      subTitle: _subTitleController.text.trim(),
      video: video,
    ));

    if (!context.mounted) return;

    if (viewModel.saveCommand.completed) {
      final reel = (viewModel.saveCommand.result as Ok<Reel>).value;
      Navigator.of(context).pop(reel);
    } else if (viewModel.saveCommand.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error publishing reel: ${viewModel.saveCommand.result}',
          ),
        ),
      );
    }
  }
}

// ── Private sub-widget ─────────────────────────────────────────────────────

class _VideoPickerTile extends StatelessWidget {
  const _VideoPickerTile({
    required this.videoController,
    required this.videoInitialized,
    required this.uploadProgress,
    required this.onTap,
  });

  final VideoPlayerController? videoController;
  final bool videoInitialized;
  final double? uploadProgress;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 9 / 16,
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.colorScheme.outlineVariant),
          ),
          clipBehavior: Clip.antiAlias,
          child: _buildContent(theme),
        ),
      ),
    );
  }

  Widget _buildContent(ThemeData theme) {
    // Show upload progress overlay.
    if (uploadProgress != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(value: uploadProgress),
            const SizedBox(height: 12),
            Text(
              'Uploading…',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    // Show video preview.
    if (videoInitialized && videoController != null) {
      return Stack(
        fit: StackFit.expand,
        children: [
          FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: videoController!.value.size.width,
              height: videoController!.value.size.height,
              child: VideoPlayer(videoController!),
            ),
          ),
          // Tap-to-replace hint.
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Tap to change video',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ),
        ],
      );
    }

    // Placeholder: no video selected.
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.video_call_outlined,
          size: 56,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        const SizedBox(height: 12),
        Text(
          'Tap to select a video',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
