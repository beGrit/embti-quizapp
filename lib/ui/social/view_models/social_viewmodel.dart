import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/repositories/social/social_repository.dart';
import 'package:emombti/domain/models/social/social.dart';
import 'package:emombti/ui/core/ui/view_models/paging.dart';
import 'package:emombti/ui/social/models/social_model.dart';
import 'package:flutter/widgets.dart';

class SocialViewModel extends ChangeNotifier {
  final SocialRepository _repository;
  final AuthRepository _authRepository;
  final String relatedId;

  final SocialModel socialModel = SocialModel(
    SocialMeta(
      likesCount: 0,
      commentsCount: 0,
      favoritesCount: 0,
      isLiked: false,
      isFavorited: false,
      comments: [],
      id: '',
      relatedId: '',
    ),
  );

  late final InteractionViewModel interactionVM;
  late final CommentSectionViewModel commentSectionVM;
  late final StickyInputViewModel stickyInputVM;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  SocialViewModel({
    required SocialRepository repository,
    required AuthRepository authRepository,
    required this.relatedId,
  }) : _repository = repository,
       _authRepository = authRepository {
    _init();
  }

  Future<void> _init() async {
    try {
      _isLoading = true;
      interactionVM = InteractionViewModel(
        repository: _repository,
        relatedId: relatedId,
        socialModel: socialModel,
        onCommentRequest: () => stickyInputVM.requestFocus(),
      );

      commentSectionVM = CommentSectionViewModel(
        repository: _repository,
        relatedId: relatedId,
        socialModel: socialModel,
      );

      stickyInputVM = StickyInputViewModel(
        repository: _repository,
        authRepository: _authRepository,
        relatedId: relatedId,
        socialModel: socialModel,
        commentSectionVM: commentSectionVM,
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
    socialModel.dispose();
    super.dispose();
  }
}

class InteractionViewModel extends ChangeNotifier {
  final SocialRepository _repository;
  final String relatedId;
  final SocialModel socialModel;
  final VoidCallback? onCommentRequest;

  bool _isLoading = false;

  InteractionViewModel({
    required SocialRepository repository,
    required this.relatedId,
    required this.socialModel,
    this.onCommentRequest,
  }) : _repository = repository;

  SocialMeta? get meta => socialModel.value;
  bool get isLoading => _isLoading;

  Future<void> init() async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    try {
      final meta = await _repository.getSocialMeta(relatedId);
      socialModel.setMetrics(meta);
    } catch (e) {
      debugPrint("Error initializing InteractionViewModel: $e");
      // Handle error state if necessary
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleLike() async {
    final currentMeta = socialModel.value;

    final isLiked = !currentMeta.isLiked;
    final oldMeta = currentMeta;

    // Optimistic UI update
    socialModel.toggleLike(isLiked);

    try {
      await _repository.toggleLike(relatedId, isLiked);
    } catch (e) {
      debugPrint("Error toggling like: $e");
      // Rollback on error
      socialModel.setMetrics(oldMeta);
    }
  }

  Future<void> toggleFavorite() async {
    final currentMeta = socialModel.value;

    final isFav = !currentMeta.isFavorited;
    final oldMeta = currentMeta;

    // Optimistic UI update
    socialModel.toggleFavorite(isFav);

    try {
      await _repository.toggleFavorite(relatedId, isFav);
    } catch (e) {
      debugPrint("Error toggling favorite: $e");
      // Rollback on error
      socialModel.setMetrics(oldMeta);
    }
  }
}

class CommentSectionViewModel extends ChangeNotifier with PagingMixin<Comment> {
  final SocialRepository _repository;
  final String relatedId;
  final SocialModel socialModel;

  CommentSectionViewModel({
    required SocialRepository repository,
    required this.relatedId,
    required this.socialModel,
  }) : _repository = repository;

  bool get isEmpty => (socialModel.value.comments.isEmpty) && !isLoading;

  List<Comment> get comments => socialModel.value.comments;

  Future<void> init() async {
    await refreshData();
  }

  @override
  Future<void> refreshData() async {
    await super.refreshData();
    socialModel.setComments(dataItems);
  }

  @override
  Future<void> loadNextPage() async {
    await super.loadNextPage();
    socialModel.setComments(dataItems);
  }

  @override
  Future<List<Comment>> loadData(int page, int pageSize) {
    return _repository.getCommentsByPage(
      relatedId,
      page: page,
      pageSize: pageSize,
    );
  }

  void handleNewComment(Comment newComment) {
    socialModel.addComment(newComment);
    notifyListeners();
  }

  Future<void> toggleLike(String commentId) async {
    // Note: Local update for comment like can also be moved to SocialModel if needed
    try {
      final currentComments = List<Comment>.from(comments);
      final index = currentComments.indexWhere((c) => c.id == commentId);
      if (index != -1) {
        final comment = currentComments[index];
        final isLiked = !comment.isLiked;

        currentComments[index] = comment.copyWith(
          isLiked: isLiked,
          likesCount: isLiked ? comment.likesCount + 1 : comment.likesCount - 1,
        );
        socialModel.setComments(currentComments);

        // Note: You would usually call the repository here to persist the like
      }
    } catch (e) {
      debugPrint("Toggle Like Error: $e");
    }
  }
}

class StickyInputViewModel extends ChangeNotifier {
  final SocialRepository _repository;
  final AuthRepository _authRepository;
  final String relatedId;
  final SocialModel socialModel;
  final CommentSectionViewModel commentSectionVM;

  final FocusNode focusNode = FocusNode();

  bool _isSubmitting = false;

  StickyInputViewModel({
    required SocialRepository repository,
    required AuthRepository authRepository,
    required this.relatedId,
    required this.socialModel,
    required this.commentSectionVM,
  }) : _repository = repository,
       _authRepository = authRepository;

  bool get isSubmitting => _isSubmitting;

  void requestFocus() {
    if (focusNode.canRequestFocus) {
      focusNode.requestFocus();
    }
  }

  Future<void> submitComment(String commentText) async {
    commentText = commentText.trim();
    if (commentText.isEmpty || _isSubmitting) return;

    try {
      _isSubmitting = true;
      notifyListeners();

      // Uses the internal relatedId
      await _repository.postComment(relatedId, commentText);

      // Create a local comment object and update socialModel
      final user = _authRepository.user;
      final newComment = Comment(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // Temporary ID
        userId: user?.id ?? 'guest',
        authorName: user?.name ?? 'Anonymous',
        authorMbti: user?.mbtiType ?? 'XXXX',
        authorAvatarUrl: user?.avatar?.uri.toString(),
        content: commentText,
        createdAt: DateTime.now(),
      );

      commentSectionVM.handleNewComment(newComment);
    } catch (e) {
      debugPrint("Submit Comment Error: $e");
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }
}
