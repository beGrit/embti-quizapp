import 'package:emombti/utils/command.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import '../../../data/repositories/auth/auth_repository.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/result.dart';

class LoginViewModel extends ChangeNotifier {
  LoginViewModel({required this.repository, required this.userRepository}) {
    loginWithGoogle = Command0<void>(_loginWithGoogleAction);
    loginWithAppleId = Command0<void>(_loginWithAppleIdAction);
    loginWithAccountAndPassword = Command1<void, (String, String)>(
      _loginWithAccountAndPassword,
    );
    register = Command1<void, (String, String)>(_registerAction);
    _log = Logger('LoginViewModel');
  }

  late final Logger _log;
  final AuthRepository repository;
  final UserRepository userRepository;

  bool isSigning = false;

  late Command0<void> loginWithGoogle;
  late Command0<void> loginWithAppleId;
  late Command1<void, (String, String)> loginWithAccountAndPassword;
  late Command1<void, (String, String)> register;

  Future<Result<void>> _loginWithAccountAndPassword(
    (String, String) credentials,
  ) async {
    isSigning = true;
    notifyListeners();
    final (email, password) = credentials;
    final result = await repository.login(email: email, password: password);

    if (result is Ok<void>) {
      _log.info('Successfully logged in');
    } else if (result is Error<void>) {
      _log.warning('Authentication failed! ${result.error}');
    }

    isSigning = false;
    notifyListeners();
    return result;
  }

  Future<Result<void>> _registerAction((String, String) credentials) async {
    final (email, password) = credentials;
    _log.info('Attempting to register user: $email');

    final createResult = await userRepository.createUserUsingEmailPassword(
      email: email,
      password: password,
    );

    if (createResult is Error<void>) {
      _log.severe('Failed to create user: ${createResult.error}');
    }

    // 2. Log in with the newly created credentials
    return createResult;
  }

  Future<Result<void>> _loginWithAppleIdAction() async {
    isSigning = true;
    notifyListeners();
    Result<void> result = await repository.loginWithAppleId();
    isSigning = false;
    notifyListeners();
    return result;
  }

  Future<Result<void>> _loginWithGoogleAction() async {
    isSigning = true;
    notifyListeners();
    final result = await repository.loginWithGoogle();
    if (result is Error<void>) {
      _log.warning('Login failed! ${result.error}');
    }
    isSigning = false;
    notifyListeners();
    return result;
  }

  @override
  void dispose() {
    super.dispose();
    loginWithGoogle.dispose();
    loginWithAccountAndPassword.dispose();
    loginWithAppleId.dispose();
    register.dispose();
  }
}
