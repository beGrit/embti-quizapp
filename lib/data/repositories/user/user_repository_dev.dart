import 'package:emombti/data/services/pocketbase/pocketbase_service.dart';
import 'package:http/http.dart' as http;

import '../../../domain/models/user/user.dart';
import '../../../utils/result.dart';
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
      return Result.ok(User.fromJson(record.toJson()));
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<void>> saveUser(User user) async {
    try {
      await _pbService.client.collection('users').update(
        user.id,
        body: {
          'name': user.name,
          'emailVisibility': user.emailVisibility,
        },
      );
      return const Result.ok(null);
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<String>> updateAvatar(
    String id,
    List<int> bytes,
    String filename,
  ) async {
    try {
      final record = await _pbService.client.collection('users').update(
        id,
        files: [http.MultipartFile.fromBytes('avatar', bytes, filename: filename)],
      );
      final newUser = User.fromJson(record.toJson());
      return Result.ok(newUser.avatar ?? '');
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }
}
