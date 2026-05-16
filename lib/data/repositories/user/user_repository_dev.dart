import 'package:emombti/data/services/pocketbase/pocketbase_service.dart';

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
}
