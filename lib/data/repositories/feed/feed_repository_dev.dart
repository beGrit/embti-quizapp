import 'package:emombti/data/services/persistence/api/model/feed/feed_api_model.dart';
import 'package:emombti/data/services/persistence/api/model/user/user_api_model.dart';
import 'package:emombti/data/services/persistence/api/pocketbase_service.dart';
import 'package:emombti/domain/models/common/common.dart';
import 'package:emombti/domain/models/feed/feed.dart';
import 'package:emombti/domain/models/user/user.dart';
import 'package:emombti/utils/result.dart';
import 'package:http/http.dart' as http;
import 'package:pocketbase/pocketbase.dart';

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

      final posts = result.items
          .map((model) => PostApiModel.fromJson(model.toJson()))
          .map(_mapPostToDomain)
          .toList();

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
      final apiModel = PostApiModel.fromJson(record.toJson());

      return Result.ok(_mapPostToDomain(apiModel));
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
      body.remove('photos');

      body['author'] = post.author.id;

      final List<http.MultipartFile> files = [];
      for (final photo in post.photos) {
        if (photo.uri.isScheme('file')) {
          files.add(
            await http.MultipartFile.fromPath('photos', photo.uri.toFilePath()),
          );
        }
      }

      final record = await _pbService.client
          .collection('posts')
          .create(body: body, files: files, expand: 'author');

      final apiModel = PostApiModel.fromJson(record.toJson());

      return Result.ok(_mapPostToDomain(apiModel));
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  /// Maps a [PostApiModel] (DTO) to a domain [Post].
  Post _mapPostToDomain(PostApiModel apiModel) {
    // 1. Map Author (Nested UserApiModel)
    final authorApiModel = UserApiModel.fromJson(
      apiModel.expand['author'] as Map<String, dynamic>,
    );
    final authorAvatarUri = _pbService.client.files.getURL(
      RecordModel({
        'id': authorApiModel.id,
        'collectionId': authorApiModel.collectionId,
        'collectionName': authorApiModel.collectionName,
      }),
      authorApiModel.avatar ?? '',
    );

    final author = User(
      id: authorApiModel.id,
      email: authorApiModel.email,
      name: authorApiModel.name,
      avatar: authorApiModel.avatar != null
          ? AppFile(uri: authorAvatarUri, name: authorApiModel.avatar!)
          : null,
    );

    // 2. Map Photos to AppFile value objects with proper URIs
    final photos = apiModel.photos.map((filename) {
      final uri = _pbService.client.files.getURL(
        RecordModel({
          'id': apiModel.id,
          'collectionId': apiModel.collectionId,
          'collectionName': apiModel.collectionName,
        }),
        filename,
      );
      return AppFile(uri: uri, name: filename);
    }).toList();

    return Post(
      id: apiModel.id,
      title: apiModel.title,
      body: apiModel.body,
      author: author,
      photos: photos,
      created: apiModel.created,
    );
  }
}
