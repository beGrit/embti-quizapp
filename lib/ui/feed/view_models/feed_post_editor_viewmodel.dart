import 'dart:convert';

import 'package:emombti/app_state/auth.dart';
import 'package:emombti/data/repositories/feed/feed_repository.dart';
import 'package:emombti/domain/models/common/common.dart';
import 'package:emombti/domain/models/feed/feed.dart';
import 'package:emombti/utils/command.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

typedef SavePostParams = ({
  String title,
  Map<String, Object> body,
  List<XFile> photos,
});

class FeedPostEditorViewModel extends ChangeNotifier {
  FeedPostEditorViewModel({
    required AuthState authState,
    required FeedRepository feedRepository,
  }) : _authState = authState,
       _feedRepository = feedRepository {
    saveCommand = Command1<Post, SavePostParams>(_savePost);
  }

  final AuthState _authState;
  final FeedRepository _feedRepository;

  late final Command1<Post, SavePostParams> saveCommand;

  Future<Result<Post>> _savePost(SavePostParams params) async {
    final user = _authState.user;
    if (user == null) {
      return Result.error(Exception('User not authenticated'));
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
