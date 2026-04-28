// lib/ui/contents/view_models/video_viewmodel.dart

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../data/repositories/video_content/video_content_repository.dart';
import '../../../domain/models/content/content.dart';
import '../../../utils/result.dart';

class VideoViewModel extends ChangeNotifier {
  final VideoContentRepository _repository;
  VideoViewModel(this._repository);

  VideoPlayerController? _controller;
  List<VideoContent> _allVideos = [];
  bool _isLoading = false;
  String? _error;
  bool _isFinished = false;

  VideoPlayerController? get controller => _controller;
  List<VideoContent> get allVideos => _allVideos;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isFinished => _isFinished;
  bool get isInitialized => _controller?.value.isInitialized ?? false;

  /// Loads the video list and initializes the first one
  Future<void> loadFirstVideo() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _repository.getAll();

    if (result is Ok<List<VideoContent>>) {
      _allVideos = result.value;
      if (_allVideos.isNotEmpty) {
        await _initController(_allVideos.first.videoUrl);
      } else {
        _error = "No videos found.";
      }
    } else if (result is Error<List<VideoContent>>) {
      _error = result.error.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Switches to a new video (YouTube-style)
  Future<void> playVideo(VideoContent content) async {
    _isFinished = false;
    // Clean up old controller before starting new one
    await _controller?.dispose();
    await _initController(content.videoUrl);
    _controller?.play();
    notifyListeners();
  }

  Future<void> _initController(String url) async {
    _controller = VideoPlayerController.networkUrl(Uri.parse(url));
    try {
      await _controller!.initialize();
      _controller!.addListener(_videoListener);
    } catch (e) {
      _error = "Format not supported or link broken.";
    }
  }

  void _videoListener() {
    if (_controller == null) return;

    // Detect if video has reached the end
    final bool reachedEnd =
        _controller!.value.position >= _controller!.value.duration;

    if (reachedEnd && !_isFinished) {
      _isFinished = true;
      notifyListeners();
    } else if (!reachedEnd && _isFinished) {
      _isFinished = false;
      notifyListeners();
    }

    // Notify for play/pause state changes
    notifyListeners();
  }

  void togglePlay() {
    if (_controller == null || !isInitialized) return;
    if (_isFinished) {
      _controller!.seekTo(Duration.zero);
      _controller!.play();
      _isFinished = false;
    } else {
      _controller!.value.isPlaying ? _controller!.pause() : _controller!.play();
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    super.dispose();
  }
}
