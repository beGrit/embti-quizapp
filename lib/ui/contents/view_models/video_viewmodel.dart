// lib/ui/contents/view_models/video_viewmodel.dart

import 'package:emombti/ui/core/ui/view_models/video_player.dart';
import 'package:flutter/material.dart';

import '../../../data/repositories/video_content/video_content_repository.dart';
import '../../../domain/models/content/content.dart';
import '../../../utils/result.dart';

class VideoViewModel extends ChangeNotifier {
  final VideoContentRepository _repository;

  final VideoPlayerViewModel _playerVM;
  VideoPlayerViewModel get playerVM => _playerVM;

  List<VideoContent> _allVideos = <VideoContent>[];
  List<VideoContent> get allVideos => _allVideos;

  String? _error;
  String? get error => _error;

  factory VideoViewModel.forHome({required VideoContentRepository repository}) {
    return VideoViewModel(
      playerVM: SimpleVideoPlayerViewModel(),
      repository: repository,
    );
  }

  factory VideoViewModel.forDetails({
    required VideoContentRepository repository,
  }) {
    return VideoViewModel(
      playerVM: AdvancedVideoPlayerViewModel(),
      repository: repository,
    );
  }

  VideoViewModel({
    required VideoPlayerViewModel playerVM,
    required VideoContentRepository repository,
  }) : _repository = repository,
       _playerVM = playerVM;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadFirstVideo() async {
    _isLoading = true;
    notifyListeners();

    final result = await _repository.getAll();
    _error = null;

    if (result is Ok<List<VideoContent>>) {
      _allVideos = result.value;
      if (_allVideos.isNotEmpty) {
        await _playerVM.init(_allVideos.first.videoUrl);
      } else {
        _error = "No videos found.";
      }
    } else if (result is Error<List<VideoContent>>) {
      _error = result.error.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
