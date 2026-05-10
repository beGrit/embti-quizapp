import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/result.dart';
import 'auth_repository.dart';

class AuthRepositoryDev extends AuthRepository {
  // A key to identify our data in the storage
  static const _authKey = 'is_logged_in';

  bool _isLoggedIn = false;

  // 1. You'll need to call this when the app starts (e.g., in main.dart)
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool(_authKey) ?? false;
    notifyListeners();
  }

  @override
  Future<bool> get isAuthenticated => Future.value(_isLoggedIn);

  @override
  Future<Result<void>> login({
    required String email,
    required String password,
  }) async {
    // 2. Save to disk
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_authKey, true);

    // 3. Update local state and notify
    _isLoggedIn = true;
    notifyListeners();

    return const Result.ok(null);
  }

  @override
  Future<Result<void>> logout() async {
    // 4. Clear from disk
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authKey);

    _isLoggedIn = false;
    notifyListeners();

    return const Result.ok(null);
  }

  @override
  Future<Result<void>> loginWithWechat() async {
    // Save to disk to persist login state
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_authKey, true);

    _isLoggedIn = true;
    notifyListeners();

    return const Result.ok(null);
  }
}
