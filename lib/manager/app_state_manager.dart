import 'package:emombti/app_state/app_config.dart';
import 'package:emombti/app_state/app_nav_bar.dart';
import 'package:emombti/app_state/auth.dart';
import 'package:emombti/app_state/chat.dart'; // 补全你现有的其他全局状态
import 'package:emombti/app_state/quiz.dart';
import 'package:emombti/app_state/theme.dart';
import 'package:emombti/domain/models/user/user.dart';
import 'package:emombti/manager/repository_manager.dart';
import 'package:emombti/manager/storage_manager.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';

class AppStateManager extends ChangeNotifier {
  late final AppConfig appConfig;
  late final AppNavBarState appNavBarState;
  late final AuthState authState;
  late final QuizState surveyFlowState;
  late final ChatState chatState;
  late final ThemeState themeState;

  AppStateManager();

  Future<void> buildAppState({
    required AppConfig appConfig,
    required AuthState authState,
    required ThemeState themeState,
    required StorageManager storageManager,
    required RepositoryManager repositoryManager,
  }) async {
    this.appConfig = appConfig;
    this.authState = authState;
    this.themeState = themeState;

    appNavBarState = AppNavBarState();

    // Auto-login check
    final userResult = await repositoryManager.authRepository
        .fetchAuthenticatedUser();
    if (userResult is Ok<User>) {
      authState.updateAuthenticatedUser(userResult.value);
    }

    surveyFlowState = QuizState(repository: repositoryManager.quizRepository);
    chatState = ChatState();
    notifyListeners();
  }
}
