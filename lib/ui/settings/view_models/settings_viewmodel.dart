import 'package:emombti/app_state/app_config.dart';
import 'package:emombti/app_state/auth.dart';
import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';

enum ThemeModeOption {
  system,
  light,
  dark;

  static ThemeModeOption fromString(
    String? value, {
    ThemeModeOption defaultValue = ThemeModeOption.system,
  }) {
    if (value == null) return defaultValue;

    return ThemeModeOption.values.firstWhere(
      (e) => e.name.toLowerCase() == value.toLowerCase(),
      orElse: () => defaultValue,
    );
  }

  @override
  String toString() => name;
}

class SettingsViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  final AuthState _authState;
  final AppConfig _appConfig;
  final String version = 'v0.1.0';

  SettingsViewModel({
    required AuthRepository authRepository,
    required AuthState authState,
    required AppConfig appConfig,
  }) : _appConfig = appConfig,
       _authRepository = authRepository,
       _authState = authState;

  void toggleNotifications(bool value) {
    _appConfig.enableNotification = value;
    _appConfig.save();
    notifyListeners();
  }

  void setThemeMode(ThemeModeOption option) {
    _appConfig.themeModeVal = option.toString();
    _appConfig.save();
    notifyListeners();
  }

  Future<void> logout() async {
    final result = await _authRepository.logout();
    if (result is Ok) {
      _appConfig.firstBoot = true;
      await _appConfig.save();
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
