import 'package:emombti/data/repositories/feed/feed_repository.dart';
import 'package:emombti/data/repositories/user/user_repository.dart';
import 'package:emombti/domain/models/feed/feed.dart';
import 'package:emombti/domain/models/user/user.dart';
import 'package:emombti/utils/command.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';

class FeedPostDetailViewmodel extends ChangeNotifier {
  FeedPostDetailViewmodel({
    required this.feedPostId,
    required FeedRepository feedRepository,
    required UserRepository userRepository,
  }) : _feedRepository = feedRepository,
       _userRepository = userRepository {
    loadPostCommand = Command0<Post?>(_loadPost);
  }

  final String feedPostId;
  final FeedRepository _feedRepository;
  final UserRepository _userRepository;

  Post? _post;
  Post? get post => _post;

  late final Command0<Post?> loadPostCommand;

  Future<Result<Post?>> _loadPost() async {
    final result = await _feedRepository.getPostById(feedPostId);

    switch (result) {
      case Ok<Post>():
        _post = await _loadAuthor(result.value);
        notifyListeners();
      case Error<Post>():
        break;
    }
    return result;
  }

  Future<Post> _loadAuthor(Post post) async {
    final authorId = post.author.id;
    if (authorId == null || authorId.isEmpty) return post;

    final result = await _userRepository.getUsersByIds([authorId]);
    if (result is Ok<List<User>>) {
      final users = result.value;
      if (users.isNotEmpty) {
        return post.copyWith(author: users.first);
      }
    }
    return post;
  }
}
