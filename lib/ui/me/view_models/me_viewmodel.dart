import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/repositories/user/user_repository.dart';
import 'package:emombti/domain/models/user/user.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MeViewModel extends ChangeNotifier {
  MeViewModel(this._authRepository, this._userRepository);

  final AuthRepository _authRepository;
  final UserRepository _userRepository;
  final ImagePicker _picker = ImagePicker();

  bool _isUpdatingAvatar = false;
  bool get isUpdatingAvatar => _isUpdatingAvatar;

  User? get user => _authRepository.user;

  Future<Result<String>> pickAndUploadAvatar() async {
    // 1. Guard against concurrent taps or multiple selection attempts
    if (_isUpdatingAvatar) {
      return Result.error(Exception('An upload is already in progress.'));
    }

    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 75,
      );

      if (image == null) {
        return Result.error(Exception('No image selected'));
      }

      final bytes = await image.readAsBytes();
      return await updateAvatar(bytes, image.name);
    } catch (e) {
      return Result.error(Exception('Failed to process image: $e'));
    }
  }

  Future<Result<String>> updateAvatar(List<int> bytes, String filename) async {
    final currentUser = user;
    if (currentUser == null) {
      return Result.error(Exception('User not logged in'));
    }

    // 2. Set loading state before hitting the repository
    _isUpdatingAvatar = true;
    notifyListeners();

    try {
      final result = await _userRepository.updateAvatar(
        currentUser.id,
        bytes,
        filename,
      );

      return result;
    } finally {
      // 3. The 'finally' block guarantees this resets even if the network
      // throws an error or is cancelled by a low-level event.
      _isUpdatingAvatar = false;
      notifyListeners();
    }
  }

  void logout() {
    _authRepository.logout();
  }
}
