import 'package:emombti/data/repositories/social/social_repository.dart';
import 'package:emombti/domain/models/social/social.dart';
import 'package:emombti/ui/core/ui/view_models/paging.dart';
import 'package:flutter/foundation.dart';

class SocialViewModel extends ChangeNotifier {
  final SocialRepository _repository;
  final String relatedId;

  late final InteractionViewModel interactionVM;
  late final CommentSectionViewModel commentSectionVM;
  late final StickyInputViewModel stickyInputVM;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  SocialViewModel({
    required SocialRepository repository,
    required this.relatedId,
  }) : _repository = repository {
    _init();
  }

  Future<void> _init() async {
    try {
      _isLoading = true;
      interactionVM = InteractionViewModel(
        repository: _repository,
        relatedId: relatedId,
      );

      commentSectionVM = CommentSectionViewModel(
        repository: _repository,
        relatedId: relatedId,
      );

      stickyInputVM = StickyInputViewModel(
        repository: _repository,
        relatedId: relatedId,
      );

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      debugPrint("Failed to initialize SocialViewModel: $e");
      notifyListeners();
    }
  }

  @override
  void dispose() {
    interactionVM.dispose();
    commentSectionVM.dispose();
    stickyInputVM.dispose();
    super.dispose();
  }
}

class InteractionViewModel extends ChangeNotifier {
  final SocialRepository _repository;
  final String relatedId;

  SocialMeta? _meta;
  bool _isLoading = false;

  InteractionViewModel({
    required SocialRepository repository,
    required this.relatedId,
  }) : _repository = repository;

  SocialMeta? get meta => _meta;
  bool get isLoading => _isLoading;

  Future<void> init() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      _meta = await _repository.getSocialMeta(relatedId);
    } catch (e) {
      debugPrint("Error initializing InteractionViewModel: $e");
      // Handle error state if necessary
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleLike() {
    if (_meta == null) return;

    final isLiked = !_meta!.isLiked;
    _meta = _meta!.copyWith(
      isLiked: isLiked,
      likesCount: isLiked ? _meta!.likesCount + 1 : _meta!.likesCount - 1,
    );
    notifyListeners();
  }

  void toggleFavorite() {
    if (_meta == null) return;

    final isFav = !_meta!.isFavorited;
    _meta = _meta!.copyWith(
      isFavorited: isFav,
      favoritesCount: isFav
          ? _meta!.favoritesCount + 1
          : _meta!.favoritesCount - 1,
    );
    notifyListeners();
  }
}

class CommentSectionViewModel extends ChangeNotifier with PagingMixin<Comment> {
  final SocialRepository _repository;
  final String relatedId;

  CommentSectionViewModel({
    required SocialRepository repository,
    required this.relatedId,
  }) : _repository = repository;

  bool get isEmpty => dataItems.isEmpty && !isLoading;

  List<Comment> get comments => dataItems;

  Future<void> init() async {
    await refreshData();
  }

  @override
  Future<List<Comment>> loadData(int page, int pageSize) {
    return _repository.getCommentsByPage(
      relatedId,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<void> toggleLike(String commentId) async {
    try {
      final index = dataItems.indexWhere((c) => c.id == commentId);
      if (index != -1) {
        final comment = dataItems[index];
        final isLiked = !comment.isLiked;

        dataItems[index] = comment.copyWith(
          isLiked: isLiked,
          likesCount: isLiked ? comment.likesCount + 1 : comment.likesCount - 1,
        );
        notifyListeners();

        // Note: You would usually call the repository here to persist the like
      }
    } catch (e) {
      debugPrint("Toggle Like Error: $e");
    }
  }

  /// Handles local UI update when a new comment is submitted
  void onCommentPosted(Comment newComment) {
    dataItems.insert(0, newComment);
    notifyListeners();
  }
}

class StickyInputViewModel extends ChangeNotifier {
  final SocialRepository _repository;
  final String relatedId;

  bool _isSubmitting = false;

  StickyInputViewModel({
    required SocialRepository repository,
    required this.relatedId,
  }) : _repository = repository;

  bool get isSubmitting => _isSubmitting;

  Future<void> submitComment(String commentText) async {
    commentText = commentText.trim();
    if (commentText.isEmpty || _isSubmitting) return;

    try {
      _isSubmitting = true;
      notifyListeners();

      // Uses the internal relatedId
      await _repository.postComment(relatedId, commentText);
    } catch (e) {
      debugPrint("Submit Comment Error: $e");
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
}
