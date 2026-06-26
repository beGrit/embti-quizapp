import 'package:emombti/domain/models/common/common.dart';
import 'package:emombti/domain/models/feed/feed.dart';
import 'package:emombti/utils/result.dart';

abstract class FeedRepository {
  /// Fetches a paginated list of posts.
  /// Implementations should use 'expand' to fetch author and tag details if needed.
  Future<Result<List<Post>>> getPostsPaginated({
    required int page,
    required int perPage,
    String? filter,
    String? sort = '-created',
  });

  Future<Result<List<Post>>> getPostsLimit(
    int? limit,
    String? postId,
    String? userId,
  );

  Future<Result<Post>> getPostById(String id);

  Future<Result<List<Reel>>> getReelsLimit(
    int? limit,
    String? reelId,
    String? userId,
  );

  Future<Result<Reel>> getReelById(String id);

  /// Creates a new post.
  Future<Result<Post>> createPost(Post post);

  Future<Result<AppFile>> uploadImageForPost(String name, List<int> bytes);

  Future<Result<AppFile>> uploadVideoForReel(String name, List<int> bytes);
}
