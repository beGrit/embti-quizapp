import 'package:emombti/app_state/auth.dart';
import 'package:emombti/data/repositories/user/user_repository.dart';
import 'package:emombti/domain/models/user/user.dart';
import 'package:emombti/domain/use_cases/user/user_avatar_update_use_case.dart';
import 'package:emombti/utils/command.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class UserInfoScreenViewModel extends ChangeNotifier {
  UserInfoScreenViewModel({
    required UserRepository userRepository,
    required UserAvatarUpdateUseCase userAvatarUpdateUseCase,
    required AuthState authState,
  }) : _authState = authState,
       _userRepository = userRepository,
       _userAvatarUpdateUseCase = userAvatarUpdateUseCase;

  final UserRepository _userRepository;
  final UserAvatarUpdateUseCase _userAvatarUpdateUseCase;
  final AuthState _authState;

  User? get user => _authState.user;

  late final Command0<void> updateNameCommand = Command0(_updateName);
  late final Command0<void> updateIntroduceCommand = Command0(_updateIntroduce);
  late final Command0<void> updateMbtiTypeCommand = Command0(_updateMbtiType);
  late final Command0<void> updateAvatarCommand = Command0(_updateAvatar);

  String tempName = '';

  String tempIntroduce = '';

  final ValueNotifier<String?> _tempMbtiType = ValueNotifier<String?>('');
  ValueNotifier<String?> get tempMbtiType => _tempMbtiType;
  set tempMbtiType(String value) {
    _tempMbtiType.value = value;
  }

  Future<Result<void>> _updateName() async {
    return _updateUserProperty((user) => user.copyWith(name: tempName));
  }

  Future<Result<void>> _updateIntroduce() async {
    return _updateUserProperty(
      (user) => user.copyWith(introduce: tempIntroduce),
    );
  }

  Future<Result<void>> _updateMbtiType() async {
    return _updateUserProperty(
      (user) => user.copyWith(mbtiType: _tempMbtiType.value),
    );
  }

  Future<Result<void>> _updateUserProperty(User Function(User) updateFn) async {
    if (user == null) return Result.error(Exception('User not logged in'));

    final updatedUser = updateFn(user!);
    final result = await _userRepository.saveUser(updatedUser);

    if (result is Ok<void>) {
      _authState.updateAuthenticatedUser(updatedUser);
    }
    return result;
  }

  Future<Result<void>> _updateAvatar() async {
    Future<Result<User>> result = _userAvatarUpdateUseCase.pickAndUploadAvatar(
      user?.id ?? '',
      ImagePicker(),
    );
    result.then(
      (value) => {
        if (value is Ok)
          {_authState.updateAuthenticatedUser((value as Ok).value)},
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
