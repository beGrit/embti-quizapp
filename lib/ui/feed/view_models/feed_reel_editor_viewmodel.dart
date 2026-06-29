import 'dart:io';

import 'package:emombti/app_state/auth.dart';
import 'package:emombti/data/repositories/feed/feed_repository.dart';
import 'package:emombti/domain/models/common/common.dart';
import 'package:emombti/domain/models/feed/feed.dart';
import 'package:emombti/utils/command.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

typedef SaveReelParams = ({
  String title,
  String subTitle,
  XFile video,
});

class FeedReelEditorViewModel extends ChangeNotifier {
  FeedReelEditorViewModel({
    required AuthState authState,
    required FeedRepository feedRepository,
  }) : _authState = authState,
       _feedRepository = feedRepository {
    saveCommand = Command1<Reel, SaveReelParams>(_saveReel);
  }

  /// Maximum allowed video file size (30 MB).
  static const int maxVideoSizeBytes = 30 * 1024 * 1024;

  final AuthState _authState;
  final FeedRepository _feedRepository;

  late final Command1<Reel, SaveReelParams> saveCommand;

  /// The currently selected video file, if any.
  XFile? selectedVideo;

  /// Upload progress in the range [0.0, 1.0], or null when not uploading.
  double? uploadProgress;

  /// Non-null when the selected video violates the size limit.
  String? videoSizeError;

  /// Selects a video file, validates its size, and notifies listeners.
  /// Sets [videoSizeError] if the file exceeds [maxVideoSizeBytes].
  Future<void> setSelectedVideo(XFile? video) async {
    if (video == null) {
      selectedVideo = null;
      videoSizeError = null;
      notifyListeners();
      return;
    }

    final fileSize = await File(video.path).length();
    if (fileSize > maxVideoSizeBytes) {
      selectedVideo = null;
      videoSizeError =
          'Video is too large (${(fileSize / (1024 * 1024)).toStringAsFixed(1)} MB). '
          'Maximum allowed size is 30 MB.';
      notifyListeners();
      return;
    }

    selectedVideo = video;
    videoSizeError = null;
    notifyListeners();
  }

  Future<Result<Reel>> _saveReel(SaveReelParams params) async {
    final user = _authState.user;
    if (user == null) {
      return Result.error(Exception('User not authenticated'));
    }

    // Guard: re-check size in case the ViewModel state is bypassed.
    final fileSize = await File(params.video.path).length();
    if (fileSize > maxVideoSizeBytes) {
      return Result.error(
        Exception('Video exceeds the 30 MB size limit.'),
      );
    }

    // Upload the video first.
    AppFile uploadedVideo;
    try {
      uploadProgress = 0.0;
      notifyListeners();

      final bytes = await params.video.readAsBytes();
      final uploadResult = await _feedRepository.uploadVideoForReel(
        params.video.name,
        bytes,
      );

      uploadProgress = null;
      notifyListeners();

      switch (uploadResult) {
        case Ok<AppFile>(:final value):
          uploadedVideo = value;
        case Error<AppFile>(:final error):
          return Result.error(error);
      }
    } catch (e) {
      uploadProgress = null;
      notifyListeners();
      return Result.error(Exception('Failed to upload video: $e'));
    }

    final now = DateTime.now();
    final newReel = Reel(
      feedType: FeedType.reel,
      title: params.title.isEmpty ? null : params.title,
      subTitle: params.subTitle.isEmpty ? null : params.subTitle,
      videoUrl: uploadedVideo,
      author: user,
      created: now,
      updated: now,
    );

    final result = await _feedRepository.createReel(newReel);

    if (result is Ok<Reel>) {
      notifyListeners();
    }

    return result;
  }
}
