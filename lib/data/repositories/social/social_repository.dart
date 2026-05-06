import 'package:emombti/domain/models/social/social.dart';

abstract class SocialRepository {
  Future<List<Comment>> getComments(String relatedId);
  Future<void> postComment(String relatedId, String content);
}
