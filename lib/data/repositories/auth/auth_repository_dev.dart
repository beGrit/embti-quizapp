import 'package:emombti/data/services/pocketbase/pocketbase_service.dart';
import 'package:pocketbase/pocketbase.dart';

import '../../../domain/models/user/user.dart';
import '../../../utils/result.dart';
import 'auth_repository.dart';

class AuthRepositoryDev extends AuthRepository {
  AuthRepositoryDev({required PocketBaseService pbService})
    : _pbService = pbService {
    _pbService.client.authStore.onChange.listen((event) {
      notifyListeners();
    });
  }

  final PocketBaseService _pbService;

  @override
  User? get user {
    final recordModel = _pbService.client.authStore.record;
    if (recordModel is RecordModel) {
      return User.fromJson(recordModel.toJson());
    }
    return null;
  }

  @override
  Future<bool> get isAuthenticated =>
      Future.value(_pbService.client.authStore.isValid);

  @override
  Future<Result<void>> login({
    required String email,
    required String password,
  }) async {
    try {
      await _pbService.client
          .collection('users')
          .authWithPassword(email, password);
      return const Result.ok(null);
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<void>> logout() async {
    _pbService.client.authStore.clear();
    return const Result.ok(null);
  }

  @override
  Future<Result<void>> loginWithWechat() async {
    return Result.error(
      Exception('Wechat login not implemented with PocketBase'),
    );
  }
}
