import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/repositories/user/user_repository.dart';
import 'package:emombti/domain/models/user/user.dart';
import 'package:emombti/domain/use_cases/user/user_avatar_update_use_case.dart';
import 'package:emombti/utils/command.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class UserInfoScreenViewModel extends ChangeNotifier {
  UserInfoScreenViewModel({
    required AuthRepository authRepository,
    required UserRepository userRepository,
    required UserAvatarUpdateUseCase userAvatarUpdateUseCase,
  }) : _authRepository = authRepository,
       _userRepository = userRepository,
       _userAvatarUpdateUseCase = userAvatarUpdateUseCase;

  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final UserAvatarUpdateUseCase _userAvatarUpdateUseCase;

  User? get user => _authRepository.user;

  late final Command0<void> updateNameCommand = Command0(_updateName);
  late final Command0<void> updateIntroduceCommand = Command0(_updateIntroduce);
  late final Command0<void> updateMbtiTypeCommand = Command0(_updateMbtiType);
  late final Command0<void> updateAvatarCommand = Command0(_updateAvatar);

  String _tempName = '';
  String get tempName => _tempName;
  set tempName(String value) {
    _tempName = value;
    notifyListeners();
  }

  String _tempIntroduce = '';
  String get tempIntroduce => _tempIntroduce;
  set tempIntroduce(String value) {
    _tempIntroduce = value;
    notifyListeners();
  }

  String _tempMbtiType = '';
  String get tempMbtiType => _tempMbtiType;
  set tempMbtiType(String value) {
    _tempMbtiType = value;
    notifyListeners();
  }

  Future<Result<void>> _updateName() async {
    return _updateUserProperty((user) => user.copyWith(name: _tempName));
  }

  Future<Result<void>> _updateIntroduce() async {
    return _updateUserProperty(
      (user) => user.copyWith(introduce: _tempIntroduce),
    );
  }

  Future<Result<void>> _updateMbtiType() async {
    return _updateUserProperty(
      (user) => user.copyWith(mbtiType: _tempMbtiType),
    );
  }

  Future<Result<void>> _updateUserProperty(User Function(User) updateFn) async {
    if (user == null) return Result.error(Exception('User not logged in'));

    final updatedUser = updateFn(user!);
    final result = await _userRepository.saveUser(updatedUser);

    if (result is Ok<void>) {
      _authRepository.updateAuthenticatedUser(updatedUser);
      notifyListeners();
    }
    return result;
  }

  Future<Result<void>> _updateAvatar() async {
    Future<Result<User>> result = _userAvatarUpdateUseCase.pickAndUploadAvatar(
      ImagePicker(),
    );
    result.then(
      (value) => {
        if (value is Ok)
          {
            _authRepository.updateAuthenticatedUser((value as Ok).value),
            notifyListeners(),
          },
      },
    );
    return result;
  }

  final List<String> mbtiTypes = [
    'INTJ',
    'INTP',
    'ENTJ',
    'ENTP',
    'INFJ',
    'INFP',
    'ENFJ',
    'ENFP',
    'ISTJ',
    'ISFJ',
    'ESTJ',
    'ESFJ',
    'ISTP',
    'ISFP',
    'ESTP',
    'ESFP',
  ];
}
