import 'package:flutter/material.dart';

import '../../../data/repositories/auth/auth_repository.dart';
import '../../../utils/result.dart';

class LoginFormViewModel extends ChangeNotifier {
  LoginFormViewModel(this._repository);

  final AuthRepository _repository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<Result<void>> loginWithAccountAndPassword({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();
    Result result = await _repository.login(email: email, password: password);
    _isLoading = false;
    notifyListeners();
    return result;
  }

  @override
  void dispose() {
    _repository.dispose();
    super.dispose();
  }
}
