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
}
