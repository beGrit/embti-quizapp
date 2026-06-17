import 'package:emombti/domain/models/user/user.dart';
import 'package:flutter/material.dart';

class AuthState extends ChangeNotifier {
  User? user;
  String? get userId => user?.id;
  bool get isAuthenticated => user != null;

  void updateAuthenticatedUser(User? newUser) {
    if (newUser == null && user != null) {
      user = null;
      notifyListeners();
    } else if (newUser != null && user == null) {
      user = newUser;
      notifyListeners();
    } else if (newUser != null && user != null && newUser.id != user!.id) {
      user = newUser;
      notifyListeners();
    }
  }
}
