import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/ui/core/themes/theme_util.dart';
import 'package:flutter/material.dart';

enum ThemeModeOption { system, light, dark }

class SettingsViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final ThemeController _themeController;

  bool _isNotificationsEnabled = true;
  bool get isNotificationsEnabled => _isNotificationsEnabled;

  ThemeModeOption _currentThemeMode = ThemeModeOption.system;
  ThemeModeOption get currentThemeMode => _currentThemeMode;

  final String version = 'v0.1.0';

  SettingsViewModel({
    required AuthRepository authRepository,
    required ThemeController themeController,
  })  : _authRepository = authRepository,
        _themeController = themeController;

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
        _themeController.overrideGlobalTheme(_themeController.materialTheme.light());
        break;
      case ThemeModeOption.dark:
        _themeController.overrideGlobalTheme(_themeController.materialTheme.dark());
        break;
    }
    notifyListeners();
  }

  Future<void> logout() async {
    await _authRepository.logout();
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
