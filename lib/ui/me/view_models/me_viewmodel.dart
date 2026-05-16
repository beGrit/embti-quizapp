import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/services/remote_file_service.dart';
import 'package:emombti/domain/models/user/user.dart';
import 'package:flutter/material.dart';

class MeViewModel extends ChangeNotifier {
  MeViewModel(this._authRepository, this._fileService) {
    _authRepository.addListener(notifyListeners);
  }

  final AuthRepository _authRepository;
  final RemoteFileService _fileService;

  User? get user => _authRepository.user;

  RemoteFileService get remoteFileService => _fileService;

  void logout() {
    _authRepository.logout();
  }

  @override
  void dispose() {
    _authRepository.removeListener(notifyListeners);
    super.dispose();
  }
}
