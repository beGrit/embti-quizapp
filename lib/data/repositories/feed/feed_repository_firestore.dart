import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emombti/data/repositories/feed/feed_repository.dart';
import 'package:emombti/data/services/persistence/api/file_service.dart';
import 'package:emombti/data/services/persistence/api/firestore_service.dart';
import 'package:emombti/data/services/persistence/api/model/feed/feed_api_model.dart';
import 'package:emombti/domain/models/common/common.dart';
import 'package:emombti/domain/models/feed/feed.dart';
import 'package:emombti/domain/models/user/user.dart';
import 'package:emombti/utils/result.dart';
import 'package:uuid/uuid.dart';

class FeedRepositoryFirestore extends FeedRepository {
  final FirestoreService firestoreService;
  final FileService fileService;
  final Map<String, DocumentSnapshot> _snapshotCache = {};

  FeedRepositoryFirestore({
    required this.firestoreService,
    required this.fileService,
  });

  @override
  Future<Result<Post>> createPost(Post post) async {
    DateTime now = DateTime.now();
    post = post.copyWith(id: Uuid().v4(), created: now, updated: now);
    await firestoreService.savePost(_mapPostDomainToApiModel(post));
    return Result.ok(post);
  }

  @override
  Future<Result<Post>> getPostById(String id) {
    // TODO: implement getPostById
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Post>>> getPostsLimit(
    int? limit,
    String? postId,
    String? userId,
  ) async {
    DocumentSnapshot? lastDocument;
    if (postId != null) {
      if (!_snapshotCache.containsKey(postId)) {
        _snapshotCache[postId] = await firestoreService.getPostSnapshot(postId);
      }
      lastDocument = _snapshotCache[postId];
    }
    List<PostApiModel> apiModels = await firestoreService.getPosts(
      limit: limit,
      lastDocument: lastDocument,
      desc: true,
    );
    return Result.ok(
      apiModels.map((e) => _mapPostApiModelToDomain(e)).toList(),
    );
  }

  @override
  Future<Result<List<Post>>> getPostsPaginated({
    required int page,
    required int perPage,
    String? filter,
    String? sort = '-created',
  }) {
    // TODO: implement getPostsPaginated
    throw UnimplementedError();
  }

  @override
  Future<Result<Reel>> getReelById(String id) {
    // TODO: implement getReelById
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Reel>>> getReelsLimit(
    int? limit,
    String? reelId,
    String? userId,
  ) {
    // TODO: implement getReelsLimit
    throw UnimplementedError();
  }

  PostApiModel _mapPostDomainToApiModel(Post post) {
    return PostApiModel(
      id: post.id ?? '',
      author: post.author.id ?? '',
      feedType: post.feedType.name,
      title: post.title ?? '',
      body: post.body,
      photos: post.photos.map((e) => e.toJson()).toList(),
      created: post.created,
      updated: post.updated,
    );
  }

  Post _mapPostApiModelToDomain(PostApiModel apiModel) {
    return Post(
      id: apiModel.id,
      feedType: FeedType.post,
      title: apiModel.title,
      body: apiModel.body,
      photos: apiModel.photos.map((e) => AppFile.fromJson(e)).toList(),
      author: User(name: 'Unknown'),
      created: apiModel.created,
      updated: apiModel.updated,
    );
  }

  @override
  Future<Result<AppFile>> uploadImageForPost(
    String name,
    List<int> bytes,
  ) async {
    try {
      String objectName = 'feed/posts/$name';
      await fileService.saveFile(objectName, bytes, name);
      Uri uri = fileService.getUri(objectName);
      return Result.ok(AppFile(uri: uri, name: name));
    } catch (e) {
      return Result.error(Exception('Upload failed.'));
    }
  }

  @override
  Future<Result<AppFile>> uploadVideoForReel(String name, List<int> bytes) {
    throw UnimplementedError();
  }
}
