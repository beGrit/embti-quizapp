import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/app_state/theme.dart';
import 'package:emombti/app_state/auth.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';

enum ThemeModeOption { system, light, dark }

class SettingsViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final ThemeState _themeController;
  final AuthState _authState;

  bool _isNotificationsEnabled = true;
  bool get isNotificationsEnabled => _isNotificationsEnabled;

  ThemeModeOption _currentThemeMode = ThemeModeOption.system;
  ThemeModeOption get currentThemeMode => _currentThemeMode;

  final String version = 'v0.1.0';

  SettingsViewModel({
    required AuthRepository authRepository,
    required ThemeState themeController,
    required AuthState authState,
  }) : _authRepository = authRepository,
       _themeController = themeController,
       _authState = authState;

  void toggleNotifications(bool value) {
    _isNotificationsEnabled = value;
    // Here you would typically call a service to enable/disable notifications
    notifyListeners();
  }

  void setThemeMode(ThemeModeOption option) {
    _currentThemeMode = option;
    switch (option) {
      case ThemeModeOption.system:
        _themeController.resetToSystemTheme();
        break;
      case ThemeModeOption.light:
        _themeController.overrideGlobalTheme(
          _themeController.materialTheme.light(),
        );
        break;
      case ThemeModeOption.dark:
        _themeController.overrideGlobalTheme(
          _themeController.materialTheme.dark(),
        );
        break;
    }
    notifyListeners();
  }

  Future<void> logout() async {
    final result = await _authRepository.logout();
    if (result is Ok) {
      _authState.updateAuthenticatedUser(null);
    }
  }

  void shareApp() {
    // Mock share logic
    debugPrint('Sharing app...');
  }

  void rateApp() {
    // Mock rate logic
    debugPrint('Rating app...');
  }
}
