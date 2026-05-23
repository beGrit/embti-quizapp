import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/repositories/user/user_repository.dart';
import 'package:emombti/domain/models/user/user.dart';
import 'package:emombti/utils/result.dart';
import 'package:image_picker/image_picker.dart';

class UserAvatarUpdateUseCase {
  UserAvatarUpdateUseCase({
    required AuthRepository authRepository,
    required UserRepository userRepository,
  }) : _userRepository = userRepository,
       _authRepository = authRepository;

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  bool _isUpdatingAvatar = false;
  bool get isUpdatingAvatar => _isUpdatingAvatar;

  Future<Result<User>> pickAndUploadAvatar(ImagePicker picker) async {
    // 1. Guard against concurrent taps or multiple selection attempts
    if (_isUpdatingAvatar) {
      return Result.error(Exception('An upload is already in progress.'));
    }
    _isUpdatingAvatar = true;
    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 75,
      );

      if (image == null) {
        return Result.error(Exception('No image selected'));
      }

      final bytes = await image.readAsBytes();
      return await _userRepository.updateAvatar(
        _authRepository.user?.id ?? '',
        bytes,
        image.name,
      );
    } catch (e) {
      return Result.error(Exception('Failed to process image: $e'));
    } finally {
      _isUpdatingAvatar = false;
    }
  }
}
