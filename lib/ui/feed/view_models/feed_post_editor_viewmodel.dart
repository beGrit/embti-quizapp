import 'dart:convert';
import 'dart:io';

import 'package:emombti/app_state/auth.dart';
import 'package:emombti/data/repositories/feed/feed_repository.dart';
import 'package:emombti/domain/models/common/common.dart';
import 'package:emombti/domain/models/feed/feed.dart';
import 'package:emombti/utils/command.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

typedef SavePostParams = ({String title, Object body, List<XFile> photos});

class FeedPostEditorViewModel extends ChangeNotifier {
  FeedPostEditorViewModel({
    required AuthState authState,
    required FeedRepository feedRepository,
  }) : _authState = authState,
       _feedRepository = feedRepository {
    saveCommand = Command1<Post, SavePostParams>(_savePost);
  }

  /// Maximum number of photos allowed per post.
  static const int maxPhotoCount = 5;

  /// Maximum allowed size per photo file (5 MB).
  static const int maxPhotoSizeBytes = 5 * 1024 * 1024;

  final AuthState _authState;
  final FeedRepository _feedRepository;

  late final Command1<Post, SavePostParams> saveCommand;

  /// Validates [photos] against count and per-file size limits.
  ///
  /// Returns a human-readable error string, or `null` when all files are valid.
  Future<String?> validatePhotos(List<XFile> photos) async {
    if (photos.length > maxPhotoCount) {
      return 'You can attach at most $maxPhotoCount photos per post.';
    }
    for (final photo in photos) {
      final size = await File(photo.path).length();
      if (size > maxPhotoSizeBytes) {
        final mb = (size / (1024 * 1024)).toStringAsFixed(1);
        return '"${photo.name}" is $mb MB — each photo must be under 5 MB.';
      }
    }
    return null;
  }

  Future<Result<Post>> _savePost(SavePostParams params) async {
    final user = _authState.user;
    if (user == null) {
      return Result.error(Exception('User not authenticated'));
    }

    // Safety-net: enforce limits even if the widget skipped validation.
    final validationError = await validatePhotos(params.photos);
    if (validationError != null) {
      return Result.error(Exception(validationError));
    }

    var now = DateTime.now();
    var newPost = Post(
      id: '',
      feedType: FeedType.post,
      author: user,
      created: now,
      updated: now,
      title: params.title,
      body: jsonEncode(params.body),
      photos: params.photos
          .map((f) => AppFile(uri: Uri.file(f.path), name: f.name))
          .toList(),
    );
    try {
      if (params.photos.isNotEmpty) {
        List<AppFile> fileTempList = [];
        for (XFile file in params.photos) {
          Result<AppFile> result = await _feedRepository.uploadImageForPost(
            file.name,
            await file.readAsBytes(),
          );
          if (result is Ok) {
            fileTempList.add((result as Ok).value);
          }
        }
        newPost = newPost.copyWith(photos: fileTempList);
      }
    } catch (e) {
      return Result.error(Exception('Failed to upload file.'));
    }

    final result = await _feedRepository.createPost(newPost);

    if (result is Ok<Post>) {
      notifyListeners();
    }
    return result;
  }
}
