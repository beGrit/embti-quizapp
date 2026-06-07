// lib/manager/app_state_manager.dart
import 'package:emombti/app_state/app_nav_bar.dart';
import 'package:emombti/app_state/chat.dart'; // 补全你现有的其他全局状态
import 'package:emombti/app_state/quiz.dart';
import 'package:emombti/manager/repository_manager.dart';
import 'package:emombti/manager/storage_manager.dart';
import 'package:flutter/material.dart';

class AppStateManager extends ChangeNotifier {
  late final AppNavBarState appNavBarState;
  late final QuizState surveyFlowState;
  late final ChatState chatState;

  Future<void> buildAppState({
    required StorageManager storageManager,
    required RepositoryManager repositoryManager,
  }) async {
    appNavBarState = AppNavBarState();
    surveyFlowState = QuizState(repository: repositoryManager.quizRepository);
    await surveyFlowState.load();
    chatState = ChatState();
    notifyListeners();
  }
}
