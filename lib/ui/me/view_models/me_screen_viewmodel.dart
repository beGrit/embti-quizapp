import 'package:emombti/app_state/auth.dart';
import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/repositories/user/user_repository.dart';
import 'package:emombti/domain/models/user/user.dart';
import 'package:emombti/domain/use_cases/user/user_avatar_update_use_case.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MeViewModel extends ChangeNotifier {
  MeViewModel(
    this._authRepository,
    this._authState,
    this._userAvatarUpdateUseCase,
    this._userRepository,
  ) {
    _authState.addListener(_onAuthStateChanged);
  }

  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final AuthState _authState;
  final UserAvatarUpdateUseCase _userAvatarUpdateUseCase;

  User? get user => _authState.user;
  bool get isUpdatingAvatar => _userAvatarUpdateUseCase.isUpdatingAvatar;

  Future<Result> pickAndUploadAvatar() async {
    Future<Result<User>> result = _userAvatarUpdateUseCase.pickAndUploadAvatar(
      user?.id ?? '',
      ImagePicker(),
    );
    result.then(
      (value) => {
        if (value is Ok<User>)
          {_authState.updateAuthenticatedUser(value.value), notifyListeners()},
      },
    );
    return result;
  }

  Future<void> logout() async {
    final result = await _authRepository.logout();
    if (result is Ok) {
      _authState.updateAuthenticatedUser(null);
    }
  }

  void _onAuthStateChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    _authState.removeListener(_onAuthStateChanged);
    super.dispose();
  }
}
