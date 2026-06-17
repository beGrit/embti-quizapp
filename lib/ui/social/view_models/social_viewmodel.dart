import 'package:emombti/app_state/auth.dart';
import 'package:emombti/data/repositories/social/social_repository.dart';
import 'package:emombti/domain/models/social/social.dart';
import 'package:emombti/domain/models/user/user.dart';
import 'package:emombti/ui/core/ui/view_models/paging.dart';
import 'package:emombti/ui/social/state/social.dart';
import 'package:flutter/widgets.dart';

class SocialViewModel extends ChangeNotifier with PagingMixin<Comment> {
  final SocialRepository _repository;
  final AuthState _authState;
  final String relatedId;

  final SocialState socialModel = SocialState(
    SocialMeta(id: '', relatedId: ''),
  );

  // Loading states
  bool _isInitialLoading = true;
  bool get isInitialLoading => _isInitialLoading;

  bool _isInteractionLoading = false;
  bool get isInteractionLoading => _isInteractionLoading;

  final FocusNode focusNode = FocusNode();
  bool _isCommentSubmitting = false;
  bool get isCommentSubmitting => _isCommentSubmitting;

  SocialViewModel({
    required SocialRepository repository,
    required AuthState authState,
    required this.relatedId,
  }) : _repository = repository,
       _authState = authState {
    _init();
  }

  Future<void> _init() async {
    try {
      _isInitialLoading = true;
      notifyListeners();

      // Load social meta data (likes, favorites counts, user's interaction status)
      await _loadSocialMeta();

      // Load initial comments using paging mixin
      await refreshData();

      _isInitialLoading = false;
      notifyListeners();
    } catch (e) {
      _isInitialLoading = false;
      debugPrint("Failed to initialize SocialViewModel: $e");
      notifyListeners();
    }
  }

  // --- Interaction related methods ---

  SocialMeta? get meta => socialModel.value;

  Future<void> _loadSocialMeta() async {
    if (_isInteractionLoading) return;

    _isInteractionLoading = true;
    notifyListeners();

    try {
      final result = await _repository.getSocialMeta(relatedId);
      socialModel.setMetrics(result);
      notifyListeners();
    } catch (e) {
      debugPrint("Error loading social meta: $e");
    } finally {
      _isInteractionLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleLike() async {
    final currentMeta = socialModel.value;
    final isLiked = !currentMeta.isLiked;
    final oldMeta = currentMeta;

    // Optimistic UI update
    socialModel.toggleLike(isLiked);
    notifyListeners();

    try {
      User? user = _authState.user;
      if (user == null) {
        throw Exception('User not logged in.');
      }
      await _repository.toggleLike(user, relatedId, isLiked);
      notifyListeners();
    } catch (e) {
      debugPrint("Error toggling like: $e");
      // Rollback on error for unexpected exceptions
      socialModel.setMetrics(oldMeta);
      notifyListeners();
    }
  }

  Future<void> toggleFavorite() async {
    final currentMeta = socialModel.value;
    final isFav = !currentMeta.isFavorited;
    final oldMeta = currentMeta;

    // Optimistic UI update
    socialModel.toggleFavorite(isFav);
    notifyListeners();

    try {
      User? user = _authState.user;
      if (user == null) {
        throw Exception('User not logged in.');
      }
      await _repository.toggleFavorite(user, relatedId, isFav);
    } catch (e) {
      debugPrint("Error toggling favorite: $e");
      // Rollback on error for unexpected exceptions
      socialModel.setMetrics(oldMeta);
      notifyListeners();
    }
  }

  // --- Comment section related methods (integrating PagingMixin) ---

  bool get areCommentsEmpty =>
      (socialModel.value.comments.isEmpty) && !isLoading;

  List<Comment> get comments => socialModel.value.comments;

  @override
  Future<void> refreshData() async {
    await super.refreshData();
    socialModel.setComments(dataItems);
    notifyListeners();
  }

  @override
  Future<void> loadNextPage() async {
    await super.loadNextPage();
    socialModel.setComments(dataItems);
    notifyListeners();
  }

  @override
  Future<List<Comment>> loadData(int page, int pageSize) async {
    final result = await _repository.getCommentsByPage(
      relatedId,
      page: page,
      pageSize: pageSize,
    );
    return result;
  }

  void handleNewComment(Comment newComment) {
    socialModel.addComment(newComment);
    dataItems.insert(0, newComment);
    notifyListeners();
  }

  void requestFocus() {
    if (focusNode.canRequestFocus) {
      focusNode.requestFocus();
    }
  }

  void onCommentInputRequested() {
    requestFocus();
  }

  Future<void> submitComment(String commentText) async {
    commentText = commentText.trim();
    if (commentText.isEmpty || _isCommentSubmitting) return;

    try {
      _isCommentSubmitting = true;
      notifyListeners();
      User? user = _authState.user;
      if (user == null) {
        throw Exception('User not logged in.');
      }
      final result = await _repository.postComment(
        user,
        relatedId,
        commentText,
      );
      handleNewComment(result);
      focusNode.unfocus();
    } catch (e) {
      debugPrint("Submit Comment Error: $e");
    } finally {
      _isCommentSubmitting = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    socialModel.dispose();
    focusNode.dispose();
    super.dispose();
  }
}
