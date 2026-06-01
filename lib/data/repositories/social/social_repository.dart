import 'package:emombti/domain/models/social/social.dart';

abstract class SocialRepository {
  Future<SocialMeta> getSocialMeta(String relatedId);
  Future<List<Comment>> getComments(String relatedId);
  Future<List<Comment>> getCommentsByPage(
    String relatedId, {
    int page = 1,
    int pageSize = 20,
  });
  Future<void> postComment(String relatedId, String content);
  Future<void> toggleLike(String relatedId, bool shouldLike);
  Future<void> toggleFavorite(String relatedId, bool shouldFavorite);
}
