import 'package:emombti/data/repositories/social/social_repository.dart';
import 'package:emombti/domain/models/social/social.dart';
import 'package:flutter/foundation.dart';

class InteractionViewModel extends ChangeNotifier {
  SocialMeta _meta;
  InteractionViewModel(this._meta);

  SocialMeta get meta => _meta;

  void toggleLike() {
    _meta = _meta.copyWith(
      isLiked: !_meta.isLiked,
      likesCount: _meta.isLiked ? _meta.likesCount - 1 : _meta.likesCount + 1,
    );
    notifyListeners();
  }

  void toggleFavorite() {
    _meta = _meta.copyWith(
      isFavorited: !_meta.isFavorited,
      favoritesCount: _meta.isFavorited
          ? _meta.favoritesCount - 1
          : _meta.favoritesCount + 1,
    );
    notifyListeners();
  }
}

class CommentSectionViewModel extends ChangeNotifier {
  final SocialRepository _repository;

  CommentSectionViewModel({required SocialRepository repository})
    : _repository = repository;

  List<Comment> _comments = [];
  bool _isLoading = false;

  List<Comment> get comments => _comments;
  bool get isLoading => _isLoading;

  Future<void> fetchComments(String relatedId) async {
    if (_isLoading) return; // Prevent duplicate calls

    _isLoading = true;
    notifyListeners();

    try {
      // Use the repository instead of generating data locally
      _comments = await _repository.getComments(relatedId);
    } catch (e) {
      // Handle errors here (e.g., logging)
      print("Error fetching comments: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

class StickyInputViewModel extends ChangeNotifier {
  String _currentText = '';

  void updateText(String val) {
    _currentText = val;
    notifyListeners();
  }

  Future<void> submitComment(String relatedId) async {
    if (_currentText.trim().isEmpty) return;
    // Logic to post comment
    _currentText = '';
    notifyListeners();
  }
}
