import 'package:emombti/data/services/persistence/api/firestore_service.dart';
import 'package:emombti/data/services/persistence/api/model/social/social_meta_api_model.dart';
import 'package:emombti/domain/models/social/social.dart';
import 'package:emombti/domain/models/user/user.dart';

import 'social_repository.dart';

class SocialRepositoryFirestore implements SocialRepository {
  final FirestoreService _firestoreService;

  SocialRepositoryFirestore({required FirestoreService firestoreService})
    : _firestoreService = firestoreService;

  @override
  Future<SocialMeta> getSocialMeta(String relatedId) async {
    var apiModel = await _firestoreService.getSocialMetaByRelatedId(relatedId);
    apiModel ??= await _firestoreService.createSocialMeta(relatedId);

    Map<String, bool> status = {'isLiked': false, 'isFavorited': false};

    return SocialMeta(
      id: apiModel.id ?? '',
      relatedId: apiModel.relatedId,
      likesCount: apiModel.metrics.likes,
      isLiked: status['isLiked'] ?? false,
      favoritesCount: apiModel.metrics.favorites,
      isFavorited: status['isFavorited'] ?? false,
      sharesCount: apiModel.metrics.shares,
      commentsCount: apiModel.metrics.comments,
    );
  }

  @override
  Future<List<Comment>> getComments(String relatedId) async {
    final apiModel = await _firestoreService.getSocialMetaByRelatedId(
      relatedId,
    );
    if (apiModel == null || apiModel.id == null) return [];

    final commentApiModels = await _firestoreService.getComments(apiModel.id!);
    return commentApiModels.map(_mapComment).toList();
  }

  @override
  Future<List<Comment>> getCommentsByPage(
    String relatedId, {
    int page = 1,
    int pageSize = 20,
  }) async {
    // For now, call getComments and slice.
    // Optimization: Add pagination to FirestoreService later if needed.
    final comments = await getComments(relatedId);
    int start = (page - 1) * pageSize;
    if (start >= comments.length) return [];
    int end = start + pageSize;
    if (end > comments.length) end = comments.length;
    return comments.sublist(start, end);
  }

  @override
  Future<Comment> postComment(
    User user,
    String relatedId,
    String content,
  ) async {
    if (user.id == null) throw Exception('User must be logged.');

    var apiModel = await _firestoreService.getSocialMetaByRelatedId(relatedId);
    apiModel ??= await _firestoreService.createSocialMeta(relatedId);

    if (apiModel.id == null) throw Exception('Failed to get social meta ID');

    final commentApiModel = CommentApiModel(
      userId: 'cloud_pb_users_${user.id!}',
      authorName: user.name ?? 'Anonymous',
      authorMbti: user.mbtiType ?? 'XXXX',
      authorAvatarUrl: user.avatar?.uri.toString(),
      content: content,
      createdAt: DateTime.now(),
    );

    await _firestoreService.addComment(
      socialMetaId: apiModel.id!,
      comment: commentApiModel,
    );

    return _mapComment(commentApiModel);
  }

  @override
  Future<void> toggleLike(User user, String relatedId, bool shouldLike) async {
    if (user.id == null) throw Exception('User must be logged.');

    final apiModel = await _firestoreService.getSocialMetaByRelatedId(
      relatedId,
    );
    if (apiModel == null || apiModel.id == null) {
      throw Exception('Social meta not found');
    }

    await _firestoreService.toggleLike(
      socialMetaId: apiModel.id!,
      userId: user.id ?? '',
      shouldLike: shouldLike,
    );
  }

  @override
  Future<void> toggleFavorite(
    User user,
    String relatedId,
    bool shouldFavorite,
  ) async {
    if (user.id == null) throw Exception('User must be logged.');

    final apiModel = await _firestoreService.getSocialMetaByRelatedId(
      relatedId,
    );
    if (apiModel == null || apiModel.id == null) {
      throw Exception('Social meta not found');
    }

    await _firestoreService.toggleFavorite(
      socialMetaId: apiModel.id!,
      userId: user.id ?? '',
      shouldFavorite: shouldFavorite,
    );
  }

  Comment _mapComment(CommentApiModel apiModel) {
    return Comment(
      id: apiModel.id ?? '',
      userId: apiModel.userId,
      authorName: apiModel.authorName,
      authorMbti: apiModel.authorMbti,
      authorAvatarUrl: apiModel.authorAvatarUrl,
      content: apiModel.content,
      createdAt: apiModel.createdAt,
      likesCount: apiModel.likesCount,
      isLiked:
          false, // Individual comment likes not yet implemented in FirestoreService
    );
  }
}
