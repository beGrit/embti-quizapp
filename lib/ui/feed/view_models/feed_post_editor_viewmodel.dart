import 'dart:convert';

import 'package:emombti/data/repositories/auth/auth_repository.dart';
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
    required AuthRepository authRepository,
    required FeedRepository feedRepository,
  }) : _authRepository = authRepository,
       _feedRepository = feedRepository {
    saveCommand = Command1<Post, SavePostParams>(_savePost);
  }

  final AuthRepository _authRepository;
  final FeedRepository _feedRepository;

  late final Command1<Post, SavePostParams> saveCommand;

  Future<Result<Post>> _savePost(SavePostParams params) async {
    final newPost = Post(
      id: '',
      author: _authRepository.user!,
      created: DateTime.now(),
      title: params.title,
      body: jsonEncode(params.body),
      photos: params.photos
          .map((f) => AppFile(uri: Uri.file(f.path), name: f.name))
          .toList(),
    );

    final result = await _feedRepository.createPost(newPost);

    if (result is Ok<Post>) {
      notifyListeners();
    }
    return result;
  }
}
