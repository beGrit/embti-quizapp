import 'package:emombti/data/services/persistence/api/model/user/user_api_model.dart';
import 'package:emombti/data/services/persistence/api/pocketbase_service.dart';
import 'package:emombti/domain/models/common/common.dart';
import 'package:emombti/domain/models/user/user.dart';
import 'package:emombti/utils/result.dart';
import 'package:http/http.dart' as http;
import 'package:pocketbase/pocketbase.dart';

import 'user_repository.dart';

/// [UserRepository] implementation using PocketBase.
class UserRepositoryDev implements UserRepository {
  UserRepositoryDev({required PocketBaseService pbService})
    : _pbService = pbService;

  final PocketBaseService _pbService;

  @override
  Future<Result<User>> getUser(String id) async {
    try {
      final record = await _pbService.client.collection('users').getOne(id);
      final apiModel = UserApiModel.fromJson(record.toJson());

      final avatarUri = _pbService.client.files.getURL(
        RecordModel({
          'id': apiModel.id,
          'collectionId': apiModel.collectionId,
          'collectionName': apiModel.collectionName,
        }),
        apiModel.avatar ?? '',
      );

      return Result.ok(
        User(
          id: apiModel.id,
          email: apiModel.email,
          name: apiModel.name,
          mbtiType: apiModel.mbtiType,
          introduce: apiModel.introduce,
          avatar: apiModel.avatar != null
              ? AppFile(uri: avatarUri, name: apiModel.avatar!)
              : null,
        ),
      );
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<User?>> getUserByEmail(String email) async {
    try {
      final record = await _pbService.client
          .collection('users')
          .getFirstListItem('email="$email"');

      final apiModel = UserApiModel.fromJson(record.toJson());

      final avatarUri = _pbService.client.files.getURL(
        RecordModel({
          'id': apiModel.id,
          'collectionId': apiModel.collectionId,
          'collectionName': apiModel.collectionName,
        }),
        apiModel.avatar ?? '',
      );

      return Result.ok(
        User(
          id: apiModel.id,
          email: apiModel.email,
          name: apiModel.name,
          mbtiType: apiModel.mbtiType,
          introduce: apiModel.introduce,
          avatar: apiModel.avatar != null
              ? AppFile(uri: avatarUri, name: apiModel.avatar!)
              : null,
        ),
      );
    } catch (e) {
      // PocketBase throws a 404 if no record matches the filter
      if (e is ClientException && e.statusCode == 404) {
        return const Result.ok(null);
      }
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<List<User>>> searchUsers(
    String keyword, {
    String? excludeUserId,
  }) async {
    try {
      final trimmed = keyword.trim();
      if (trimmed.isEmpty) {
        return const Result.ok([]);
      }

      final records = await _pbService.client
          .collection('users')
          .getFullList(filter: 'name ~ "$trimmed" || email ~ "$trimmed"');

      final users = records
          .where((record) => excludeUserId == null || record.id != excludeUserId)
          .map((record) {
            final apiModel = UserApiModel.fromJson(record.toJson());
            final avatarUri = _pbService.client.files.getURL(
              RecordModel({
                'id': apiModel.id,
                'collectionId': apiModel.collectionId,
                'collectionName': apiModel.collectionName,
              }),
              apiModel.avatar ?? '',
            );

            return User(
              id: apiModel.id,
              email: apiModel.email,
              name: apiModel.name,
              mbtiType: apiModel.mbtiType,
              introduce: apiModel.introduce,
              avatar: apiModel.avatar != null
                  ? AppFile(uri: avatarUri, name: apiModel.avatar!)
                  : null,
            );
          })
          .toList();

      return Result.ok(users);
    } catch (e) {
      if (e is ClientException && e.statusCode == 404) {
        return const Result.ok([]);
      }
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<void>> createUserUsingEmailPassword({
    required String email,
    required String password,
    String? id,
  }) async {
    try {
      await _pbService.client
          .collection('users')
          .create(
            body: {
              'email': email,
              'password': password,
              'passwordConfirm': password,
            },
          );
      return const Result.ok(null);
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<void>> saveUser(User user) async {
    try {
      await _pbService.client
          .collection('users')
          .update(
            user.id ?? '',
            body: {
              'name': user.name,
              'introduce': user.introduce,
              'mbtiType': user.mbtiType,
            },
          );
      return const Result.ok(null);
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<User>> updateAvatar(
    String id,
    List<int> bytes,
    String filename,
  ) async {
    try {
      final record = await _pbService.client
          .collection('users')
          .update(
            id,
            files: [
              http.MultipartFile.fromBytes('avatar', bytes, filename: filename),
            ],
          );

      final apiModel = UserApiModel.fromJson(record.toJson());

      final avatarUri = _pbService.client.files.getURL(
        RecordModel({
          'id': apiModel.id,
          'collectionId': apiModel.collectionId,
          'collectionName': apiModel.collectionName,
        }),
        apiModel.avatar ?? '',
      );

      return Result.ok(
        User(
          id: apiModel.id,
          email: apiModel.email,
          name: apiModel.name,
          mbtiType: apiModel.mbtiType,
          introduce: apiModel.introduce,
          avatar: AppFile(uri: avatarUri, name: filename),
        ),
      );
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }
}
