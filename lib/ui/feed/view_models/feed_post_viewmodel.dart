import 'dart:convert';

import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/repositories/feed/feed_repository.dart';
import 'package:emombti/domain/models/feed/feed.dart';
import 'package:emombti/utils/command.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';

class FeedPostViewModel extends ChangeNotifier {
  FeedPostViewModel({
    required AuthRepository authRepository,
    required FeedRepository feedRepository,
  }) : _feedRepository = feedRepository {
    loadPostsCommand = Command0<List<Post>>(_loadPostsInternal);
    loadMorePostsCommand = Command0<List<Post>>(_loadMorePostsInternal);
  }

  final FeedRepository _feedRepository;

  List<Post> _posts = [];
  List<Post> get posts => _posts;

  static const int _perPage = 5;
  bool _hasMore = true;
  bool get hasMore => _hasMore;

  late final Command0<List<Post>> loadPostsCommand;
  late final Command0<List<Post>> loadMorePostsCommand;

  Future<Result<List<Post>>> _loadPostsInternal() async {
    _hasMore = true;
    // Fetches the first page of posts (paginated)
    final result = await _feedRepository.getPostsLimit(_perPage, null, null);

    switch (result) {
      case Ok<List<Post>>():
        _posts = result.value; // Update the internal list
        if (result.value.length < _perPage) {
          _hasMore = false;
        }
        notifyListeners();
      case Error<List<Post>>():
        break;
    }
    return result;
  }

  Future<Result<List<Post>>> _loadMorePostsInternal() async {
    if (!_hasMore) return Result.ok([]);

    final result = await _feedRepository.getPostsLimit(
      _perPage,
      posts[posts.length - 1].id,
      null,
    );

    switch (result) {
      case Ok<List<Post>>():
        final newPosts = result.value;
        if (newPosts.isEmpty) {
          _hasMore = false;
        } else {
          _posts.addAll(newPosts);
          if (newPosts.length < _perPage) {
            _hasMore = false;
          }
        }
        notifyListeners();
      case Error<List<Post>>():
        break;
    }
    return result;
  }

  /// Adds a newly created post to the top of the feed list.
  void addPost(Post post) {
    _posts = [post, ..._posts];
    notifyListeners();
  }

  /// Traverses the AppFlowy JSON document block hierarchy to pull out clean plain text
  String getPlainTextFromAppFlowyJson(String? jsonString, {int maxLines = 3}) {
    if (jsonString == null || jsonString.isEmpty) return '';

    try {
      final decoded = jsonDecode(jsonString);
      if (decoded is! Map<String, dynamic>) return '';

      final Map<String, dynamic> documentData = decoded.containsKey('document')
          ? decoded['document'] as Map<String, dynamic>
          : decoded;

      final children = documentData['children'] as List<dynamic>?;
      if (children == null || children.isEmpty) return '';

      final List<String> textBuffer = [];
      bool lastBlockWasEmpty = false;

      for (final child in children) {
        if (child is! Map<String, dynamic>) continue;

        final dataMap = child['data'] as Map<String, dynamic>?;
        if (dataMap != null) {
          final delta = dataMap['delta'] as List<dynamic>?;

          if (delta != null) {
            // 1. Extract and clean raw insert data
            String blockText = delta
                .map((op) {
                  if (op is Map<String, dynamic> && op.containsKey('insert')) {
                    return op['insert']?.toString() ?? '';
                  }
                  return '';
                })
                .join('');

            // 2. Collapse internal multi-line breaks (\n\n\n) inside a single block down to single wraps
            blockText = blockText.replaceAll(RegExp(r'\n+'), '\n').trim();

            if (blockText.isNotEmpty) {
              textBuffer.add(blockText);
              lastBlockWasEmpty = false; // Reset line block state tracker
            } else {
              // 3. This block is entirely empty. Only allow it if the previous line wasn't empty
              if (!lastBlockWasEmpty && textBuffer.isNotEmpty) {
                textBuffer.add(
                  '',
                ); // Acts as a single clean line separation break
                lastBlockWasEmpty = true;
              }
            }
          }
        }

        // Performance safety cap: stop parsing once we have plenty of text lines
        if (textBuffer.length >= maxLines + 2) break;
      }

      // Trim any trailing blank spaces added to the end of the line array balance sheet
      if (textBuffer.isNotEmpty && textBuffer.last.isEmpty) {
        textBuffer.removeLast();
      }

      return textBuffer.join('\n');
    } catch (e) {
      debugPrint('Error compiling AppFlowy text preview: $e');
      return '';
    }
  }
}
