import 'package:flutter/material.dart';

class MeViewModel extends ChangeNotifier {
  // Replace with your actual user model later
  String userName = "MBTI Explorer";
  String userEmail = "explorer@emombti.com";
  String mbtiType = "INFP";

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void updateProfile() {
    // Logic to update user data
    notifyListeners();
  }

  void logout() {
    // Call your AuthRepository logout logic here
    debugPrint("User logging out...");
  }
}
