import 'package:emombti/utils/command.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../data/repositories/auth/auth_repository.dart';
import '../../../utils/result.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({required this.repository}) {
    loginWithWechat = Command0<void>(_loginWithWechatAction);
    loginWithAccountAndPassword = Command1<void, (String, String)>(
      _loginWithAccountAndPassword,
    );
  }
  final _log = Logger('LoginViewModel');

  final AuthRepository repository;

  late Command0<void> loginWithWechat;
  late Command1<void, (String, String)> loginWithAccountAndPassword;

  Future<Result<void>> _loginWithAccountAndPassword(
    (String, String) credentials,
  ) async {
    final (email, password) = credentials;
    final result = await repository.login(email: email, password: password);
    if (result is Error<void>) {
      _log.warning('Login failed! ${result.error}');
    }
    return result;
  }

  Future<Result<void>> _loginWithWechatAction() async {
    final result = await repository.loginWithWechat();
    if (result is Error<void>) {
      _log.warning('Login failed! ${result.error}');
    }
    return result;
  }

  @override
  void dispose() {
    super.dispose();
    loginWithWechat.dispose();
    loginWithAccountAndPassword.dispose();
  }
}
