import 'dart:convert';

import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/repositories/feed/feed_repository.dart';
import 'package:emombti/domain/models/feed/feed.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';

class FeedPostViewModel extends ChangeNotifier {
  FeedPostViewModel({
    required AuthRepository authRepository,
    required FeedRepository feedRepository,
  }) : _authRepository = authRepository,
       _feedRepository = feedRepository;

  final AuthRepository _authRepository;
  final FeedRepository _feedRepository;

  List<Post> _posts = [];
  List<Post> get posts => _posts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> loadPosts() async {
    if (_isLoading) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    // Fetches the first page of posts (paginated)
    final result = await _feedRepository.getPostsPaginated(
      page: 1,
      perPage: 20,
    );

    switch (result) {
      case Ok<List<Post>>():
        _posts = result.value;
      case Error<List<Post>>():
        _errorMessage = result.error.toString();
    }

    _isLoading = false;
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
