import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';

/// The "Contract" - Both Simple and Advanced players must follow this.
abstract class VideoPlayerViewModel extends ChangeNotifier {
  VideoPlayerController? _controller;
  VideoPlayerController? get controller => _controller;

  bool _isBuffering = false;
  bool get isBuffering => _isBuffering;

  bool _isFinished = false;
  bool get isFinished => _isFinished;

  String? _error;
  String? get error => _error;

  List<String> _recommendedIds = [];
  List<String> get recommendedIds => _recommendedIds;

  bool get isPlaying => _controller?.value.isPlaying ?? false;

  /// Common functions with identical names
  Future<void> init(String url, {List<String> recommendations = const []});
  void togglePlay();
  Future<void> reset();

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

// --- Implementation 1: Simple Player (Home Page) ---

class SimpleVideoPlayerViewModel extends VideoPlayerViewModel {
  @override
  Future<void> init(
    String url, {
    List<String> recommendations = const [],
  }) async {
    await reset();
    _recommendedIds = recommendations;

    _controller = VideoPlayerController.networkUrl(Uri.parse(url));

    try {
      await _controller!.initialize();
      // Simple player might not need a complex listener for buffering,
      // but it still needs to know when the video ends.
      _controller!.addListener(_basicListener);
      _controller!.pause();
    } catch (e) {
      _error = "Failed to load video";
    }
    notifyListeners();
  }

  void _basicListener() {
    if (_controller == null) return;

    final bool reachedEnd =
        _controller!.value.position >= _controller!.value.duration;
    if (reachedEnd != _isFinished) {
      _isFinished = reachedEnd;
      notifyListeners();
    }
  }

  @override
  void togglePlay() {
    if (_controller == null) return;
    _controller!.value.isPlaying ? _controller!.pause() : _controller!.play();
    notifyListeners();
  }

  @override
  Future<void> reset() async {
    if (_controller != null) {
      _controller!.removeListener(_basicListener);
      await _controller!.dispose();
      _controller = null;
    }
    _isFinished = false;
    _isBuffering = false;
  }
}

// --- Implementation 2: Advanced Player (Details Page) ---

class AdvancedVideoPlayerViewModel extends VideoPlayerViewModel {
  @override
  Future<void> init(
    String url, {
    List<String> recommendations = const [],
  }) async {
    await reset();
    _recommendedIds = recommendations;

    _controller = VideoPlayerController.networkUrl(Uri.parse(url));

    try {
      await _controller!.initialize();
      // Advanced player tracks buffering, analytics, and more.
      _controller!.addListener(_advancedListener);
      _controller!.play();
    } catch (e) {
      _error = "Format not supported or link broken.";
    } finally {
      notifyListeners();
    }
  }

  void _advancedListener() {
    final currentController = _controller;
    if (currentController == null || !currentController.value.isInitialized)
      return;

    final value = currentController.value;
    bool needsUpdate = false;

    // 1. Buffering Logic (Only in Advanced)
    if (value.isBuffering != _isBuffering) {
      _isBuffering = value.isBuffering;
      needsUpdate = true;
    }

    // 2. Finished Logic
    final bool reachedEnd = value.position >= value.duration;
    if (reachedEnd != _isFinished) {
      _isFinished = reachedEnd;
      needsUpdate = true;
    }

    if (needsUpdate) notifyListeners();
  }

  @override
  void togglePlay() {
    if (_controller == null) return;

    // Advanced could add haptic feedback or logging here
    if (_controller!.value.isPlaying) {
      _controller!.pause();
    } else {
      _controller!.play();
    }
    notifyListeners();
  }

  /// Specific Advanced Function (Optional)
  void share() {
    print("Sharing video: ${_controller?.dataSource}");
  }

  @override
  Future<void> reset() async {
    if (_controller != null) {
      _controller!.removeListener(_advancedListener);
      await _controller!.dispose();
      _controller = null;
    }
    _isFinished = false;
    _isBuffering = false;
  }
}
