import 'package:emombti/utils/command.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

import '../../../data/repositories/auth/auth_repository.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/result.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({required this.repository, required this.userRepository}) {
    loginWithGoogle = Command0<void>(_loginWithGoogleAction);
    loginWithAccountAndPassword = Command1<void, (String, String)>(
      _loginWithAccountAndPassword,
    );
    register = Command1<void, (String, String)>(_registerAction);
  }
  final _log = Logger('LoginViewModel');

  final AuthRepository repository;
  final UserRepository userRepository;

  late Command0<void> loginWithGoogle;
  late Command1<void, (String, String)> loginWithAccountAndPassword;
  late Command1<void, (String, String)> register;

  Future<Result<void>> _loginWithAccountAndPassword(
    (String, String) credentials,
  ) async {
    final (email, password) = credentials;
    final result = await repository.login(email: email, password: password);

    if (result is Ok<void>) {
      _log.info('Successfully logged in');
    } else if (result is Error<void>) {
      _log.warning('Authentication failed! ${result.error}');
    }

    return result;
  }

  Future<Result<void>> _registerAction((String, String) credentials) async {
    final (email, password) = credentials;
    _log.info('Attempting to register user: $email');

    final createResult = await userRepository.createUser(email, password);

    if (createResult is Error<void>) {
      _log.severe('Failed to create user: ${createResult.error}');
    }

    // 2. Log in with the newly created credentials
    return createResult;
  }

  Future<Result<void>> _loginWithGoogleAction() async {
    final result = await repository.loginWithGoogle();
    if (result is Error<void>) {
      _log.warning('Login failed! ${result.error}');
    }
    return result;
  }

  @override
  void dispose() {
    super.dispose();
    loginWithGoogle.dispose();
    loginWithAccountAndPassword.dispose();
    register.dispose();
  }
}
