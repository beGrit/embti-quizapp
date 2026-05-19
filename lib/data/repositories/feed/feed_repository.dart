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

  /// Fetches a single post by its ID.
  Future<Result<Post>> getPostById(String id);

  /// Creates a new post.
  Future<Result<Post>> createPost(Post post);
}
