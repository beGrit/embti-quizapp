import 'package:emombti/data/services/persistence/api/firestore_service.dart';
import 'package:emombti/data/services/persistence/api/model/user/user_api_model.dart';
import 'package:emombti/domain/models/common/common.dart';
import 'package:emombti/domain/models/user/user.dart';
import 'package:emombti/utils/result.dart';

import 'user_repository.dart';

/// [UserRepository] implementation using PocketBase.
class UserRepositoryDev implements UserRepository {
  UserRepositoryDev({required FirestoreService apiStorage})
    : _apiStorage = apiStorage;

  final FirestoreService _apiStorage;

  @override
  Future<Result<void>> createUserUsingEmailPassword({
    required String email,
    required String password,
    String? id,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> getUser(String id) async {
    try {
      UserFirestoreApiModel? apiModel = await _apiStorage.getUser(id);
      if (apiModel == null) {
        throw Exception('User not found');
      }
      User user = User(
        id: apiModel.id,
        email: apiModel.email,
        name: apiModel.name,
        mbtiType: apiModel.mbtiType,
        introduce: apiModel.introduce,
        avatar: apiModel.avatar != null
            ? AppFile(uri: Uri.parse(apiModel.avatar ?? ''), name: '')
            : null,
      );
      return Result.ok(user);
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<User?>> getUserByEmail(String email) {
    throw UnimplementedError();
  }

  @override
  Future<Result<List<User>>> searchUsers(
    String keyword, {
    String? excludeUserId,
  }) async {
    try {
      final apiModels = await _apiStorage.searchUsers(
        keyword,
        excludeUserId: excludeUserId,
      );

      final users = apiModels
          .map(
            (apiModel) => User(
              id: apiModel.id,
              email: apiModel.email,
              name: apiModel.name,
              mbtiType: apiModel.mbtiType,
              introduce: apiModel.introduce,
              avatar: apiModel.avatar != null
                  ? AppFile(uri: Uri.parse(apiModel.avatar ?? ''), name: '')
                  : null,
            ),
          )
          .toList();

      return Result.ok(users);
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<void>> saveUser(User user) async {
    try {
      UserFirestoreApiModel apiModel = UserFirestoreApiModel(
        id: user.id ?? '',
        email: user.email,
        name: user.name,
        mbtiType: user.mbtiType,
        introduce: user.introduce,
        updated: DateTime.now(),
      );
      await _apiStorage.saveUser(apiModel);
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
  ) {
    throw UnimplementedError();
  }
}
