import 'package:emombti/domain/models/social/social.dart';
import 'package:emombti/domain/models/user/user.dart';

abstract class SocialRepository {
  Future<SocialMeta> getSocialMeta(String relatedId);
  Future<List<Comment>> getComments(String relatedId);
  Future<List<Comment>> getCommentsByPage(
    String relatedId, {
    int page = 1,
    int pageSize = 20,
  });
  Future<Comment> postComment(User user, String relatedId, String content);
  Future<void> toggleLike(User user, String relatedId, bool shouldLike);
  Future<void> toggleFavorite(User user, String relatedId, bool shouldFavorite);
}
