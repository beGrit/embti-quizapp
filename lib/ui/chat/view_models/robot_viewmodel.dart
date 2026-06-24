import 'package:emombti/app_state/auth.dart';
import 'package:emombti/data/repositories/chat/chat_repository.dart';
import 'package:emombti/domain/constants/status.dart';
import 'package:emombti/domain/models/chat/chat.dart';
import 'package:emombti/utils/command.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/foundation.dart';

class ChatBotViewModel extends ChangeNotifier {
  BotStatus _currentState = BotStatus.idle;
  BotStatus get currentState => _currentState;

  late final AuthState authState;

  final ChatRepository chatRepository;
  late final Command0<void> chatWithAiCommand;

  ChatBotViewModel({required this.chatRepository, required this.authState}) {
    chatWithAiCommand = Command0<Chat>(_chatWithAi);
  }

  void switchToState(BotStatus newState) {
    if (_currentState == newState) return;
    _currentState = newState;
    notifyListeners();
  }

  Future<Result<Chat>> _chatWithAi() async {
    String? userId = authState.userId;
    if (userId != null) {
      Result<List<Robot>> getListResult = await chatRepository.getRobots(
        userId: userId,
      );
      if (getListResult is Ok) {
        List<Robot> robots = (getListResult as Ok).value;
        if (robots.isEmpty) {
          Result<Robot> addRobotResult = await chatRepository.addRobot(
            userId: userId,
            robotTemplate: 'ai_mbti',
          );
          if (addRobotResult is Ok) {
            Robot robot = (addRobotResult as Ok).value;
            return await chatRepository.addRobotChat(
              userId: userId,
              robotId: robot.id ?? '',
            );
          }
        }
      }
    }
    return Result.error(Exception('Create AI Chat Failed.'));
  }
}
