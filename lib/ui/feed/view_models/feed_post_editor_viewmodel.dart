import 'dart:convert';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/repositories/feed/feed_repository.dart';
import 'package:emombti/domain/models/feed/feed.dart';
import 'package:emombti/utils/command.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/foundation.dart';

class FeedPostEditorViewModel extends ChangeNotifier {
  FeedPostEditorViewModel({
    required AuthRepository authRepository,
    required FeedRepository feedRepository,
  }) : _authRepository = authRepository,
       _feedRepository = feedRepository {
    saveCommand = Command1<Post, EditorState>(_savePost);
  }

  final AuthRepository _authRepository;
  final FeedRepository _feedRepository;

  late final Command1<Post, EditorState> saveCommand;

  Future<Result<Post>> _savePost(EditorState editorState) async {
    final documentJson = jsonEncode(editorState.document.toJson());

    final newPost = Post(
      id: '',
      author: _authRepository.user!,
      created: DateTime.now(),
      title: 'New Post',
      body: documentJson,
      photos: [],
    );

    final result = await _feedRepository.createPost(newPost);

    if (result is Ok<Post>) {
      notifyListeners();
    }
    return result;
  }
}
