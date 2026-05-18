import 'package:emombti/data/services/persistence/api/pocketbase_service.dart';
import 'package:emombti/domain/models/feed/feed.dart';
import 'package:emombti/utils/pocketbase_util.dart';
import 'package:emombti/utils/result.dart';

import 'feed_repository.dart';

class FeedRepositoryDev implements FeedRepository {
  FeedRepositoryDev({required PocketBaseService pbService})
    : _pbService = pbService;

  final PocketBaseService _pbService;

  @override
  Future<Result<List<Post>>> getPostsPaginated({
    required int page,
    required int perPage,
    String? filter,
    String? sort = '-created',
  }) async {
    try {
      final result = await _pbService.client
          .collection('posts')
          .getList(
            page: page,
            perPage: perPage,
            filter: filter,
            sort: sort,
            expand: 'author',
          );

      final posts = PocketBaseUtils.flattenList(
        result.items,
      ).map((record) => Post.fromJson(record)).toList();

      return Result.ok(posts);
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<Post>> getPostById(String id) async {
    try {
      final record = await _pbService.client
          .collection('posts')
          .getOne(id, expand: 'author,tags');
      return Result.ok(
        Post.fromJson(PocketBaseUtils.flattenExpand(record.toJson())),
      );
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<Post>> createPost(Post post) async {
    try {
      final Map<String, dynamic> body = post.toJson();

      body.remove('id');
      body.remove('created');
      body.remove('updated');

      body['author'] = post.author.id;

      final record = await _pbService.client
          .collection('posts')
          .create(body: body, files: []);

      final json = record.toJson();

      return Result.ok(Post.fromJson(json));
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<List<Tag>>> getAllTags() async {
    try {
      final records = await _pbService.client
          .collection('tags')
          .getFullList(sort: 'name');
      final tags = records
          .map((record) => Tag.fromJson(record.toJson()))
          .toList();
      return Result.ok(tags);
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }
}
