import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/domain/models/user/user.dart';
import 'package:emombti/domain/use_cases/user/user_avatar_update_use_case.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MeViewModel extends ChangeNotifier {
  MeViewModel(this._authRepository, this._userAvatarUpdateUseCase) {
    _authRepository.addListener(_onAuthRepositoryChanged);
  }

  final AuthRepository _authRepository;
  final UserAvatarUpdateUseCase _userAvatarUpdateUseCase;

  User? get user => _authRepository.user;
  bool get isUpdatingAvatar => _userAvatarUpdateUseCase.isUpdatingAvatar;

  Future<Result<String>> pickAndUploadAvatar() async {
    Future<Result<String>> result = _userAvatarUpdateUseCase
        .pickAndUploadAvatar(ImagePicker());
    return result;
  }

  void logout() {
    _authRepository.logout();
  }

  void _onAuthRepositoryChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    _authRepository.removeListener(_onAuthRepositoryChanged);
    super.dispose();
  }
}
