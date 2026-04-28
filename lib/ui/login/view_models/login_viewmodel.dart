import 'package:flutter/material.dart';

import '../../../data/repositories/auth/auth_repository.dart';
import '../../../utils/result.dart';

class LoginFormViewModel extends ChangeNotifier {
  LoginFormViewModel(this._repository);

  final AuthRepository _repository;

  Future<Result<void>> loginWithAccountAndPassword({
    required String email,
    required String password,
  }) async {
    return await _repository.login(email: email, password: password);
  }

  @override
  void dispose() {
    _repository.dispose();
    super.dispose();
  }
}
