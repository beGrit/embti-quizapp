import 'package:emombti/data/repositories/feed/feed_repository_dev.dart';
import 'package:emombti/data/services/persistence/api/pocketbase_service.dart';
import 'package:emombti/domain/models/feed/feed.dart';
import 'package:emombti/domain/models/user/user.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pocketbase/pocketbase.dart';

class MockPocketBaseService extends Mock implements PocketBaseService {}

class MockPocketBase extends Mock implements PocketBase {}

class MockRecordService extends Mock implements RecordService {}

class MockFileService extends Mock implements FileService {}

class FakeRecordModel extends Fake implements RecordModel {}

void main() {
  late FeedRepositoryDev repository;
  late MockPocketBaseService mockPbService;
  late MockPocketBase mockPbClient;
  late MockRecordService mockRecordService;
  late MockFileService mockFileService;

  setUpAll(() {
    // Register fallback for Mocktail to handle RecordModel types in matchers
    registerFallbackValue(FakeRecordModel());
  });

  setUp(() {
    mockPbService = MockPocketBaseService();
    mockPbClient = MockPocketBase();
    mockRecordService = MockRecordService();
    mockFileService = MockFileService();

    when(() => mockPbService.client).thenReturn(mockPbClient);
    when(() => mockPbClient.collection(any())).thenReturn(mockRecordService);
    when(() => mockPbClient.files).thenReturn(mockFileService);

    repository = FeedRepositoryDev(pbService: mockPbService);
  });

  final authorData = {
    'id': 'user123',
    'collectionId': 'users_coll',
    'collectionName': 'users',
    'name': 'Tester',
    'avatar': 'avatar.png',
    'created': '2023-10-27T10:00:00.000Z',
    'updated': '2023-10-27T10:00:00.000Z',
  };

  final postData = {
    'id': 'post123',
    'collectionId': 'posts_coll',
    'collectionName': 'posts',
    'title': 'Test Post',
    'body': 'Hello World',
    'photos': ['photo1.jpg'],
    'created': '2023-10-27T12:00:00.000Z',
    'updated': '2023-10-27T12:00:00.000Z',
    'expand': {'author': authorData},
  };

  group('FeedRepositoryDev', () {
    test(
      'getPostsPaginated returns successful result mapping DTO to Domain',
      () async {
        // Arrange
        final record = RecordModel(postData);
        final resultList = ResultList<RecordModel>(
          page: 1,
          perPage: 20,
          totalItems: 1,
          totalPages: 1,
          items: [record],
        );

        when(
          () => mockRecordService.getList(
            page: any(named: 'page'),
            perPage: any(named: 'perPage'),
            filter: any(named: 'filter'),
            sort: any(named: 'sort'),
            expand: any(named: 'expand'),
          ),
        ).thenAnswer((_) async => resultList);

        when(
          () => mockFileService.getURL(any(), any()),
        ).thenReturn(Uri.parse('https://pb.com/file.jpg'));

        // Act
        final result = await repository.getPostsPaginated(page: 1, perPage: 20);

        // Assert
        expect(result, isA<Ok<List<Post>>>());
        final posts = (result as Ok<List<Post>>).value;
        expect(posts.length, 1);
        expect(posts.first.title, 'Test Post');
        expect(posts.first.author.name, 'Tester');
        expect(
          posts.first.photos.first.uri.toString(),
          'https://pb.com/file.jpg',
        );
      },
    );

    test('getPostById returns successful result', () async {
      // Arrange
      final record = RecordModel(postData);
      when(
        () => mockRecordService.getOne(any(), expand: any(named: 'expand')),
      ).thenAnswer((_) async => record);
      when(
        () => mockFileService.getURL(any(), any()),
      ).thenReturn(Uri.parse('https://pb.com/file.jpg'));

      // Act
      final result = await repository.getPostById('post123');

      // Assert
      expect(result, isA<Ok<Post>>());
      final post = (result as Ok<Post>).value;
      expect(post.id, 'post123');
      verify(
        () => mockRecordService.getOne('post123', expand: 'author,tags'),
      ).called(1);
    });

    test('createPost returns successful result after mapping', () async {
      // Arrange
      final domainAuthor = User(id: 'user123', name: 'Tester');
      final newPost = Post(
        id: '',
        title: 'New Post',
        author: domainAuthor,
        created: DateTime.now(),
      );

      final record = RecordModel(postData);
      when(
        () => mockRecordService.create(
          body: any(named: 'body'),
          expand: any(named: 'expand'),
        ),
      ).thenAnswer((_) async => record);
      when(
        () => mockFileService.getURL(any(), any()),
      ).thenReturn(Uri.parse('https://pb.com/file.jpg'));

      // Act
      final result = await repository.createPost(newPost);

      // Assert
      expect(result, isA<Ok<Post>>());
      final post = (result as Ok<Post>).value;
      expect(post.id, 'post123');
      verify(
        () => mockRecordService.create(
          body: any(named: 'body'),
          expand: 'author',
        ),
      ).called(1);
    });

    test('failure returns Error result', () async {
      // Arrange
      when(
        () => mockRecordService.getList(
          page: any(named: 'page'),
          perPage: any(named: 'perPage'),
          expand: any(named: 'expand'),
        ),
      ).thenThrow(ClientException());

      // Act
      final result = await repository.getPostsPaginated(page: 1, perPage: 20);

      // Assert
      expect(result, isA<Error<List<Post>>>());
    });
  });
}
