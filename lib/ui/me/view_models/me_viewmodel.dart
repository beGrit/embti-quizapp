import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:flutter/material.dart';

class MeViewModel extends ChangeNotifier {
  // Replace with your actual user model later
  String userName = "MBTI Explorer";
  String userEmail = "explorer@emombti.com";
  String mbtiType = "INFP";

  MeViewModel(this._repository);

  final AuthRepository _repository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void updateProfile() {
    notifyListeners();
  }

  void logout() {
    _repository.logout();
    notifyListeners();
  }
}
