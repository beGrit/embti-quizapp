import 'package:flutter/foundation.dart';

enum BotState { idle, thinking, speaking, clicked }

class ChatBotViewModel extends ChangeNotifier {
  BotState _currentState = BotState.idle;
  BotState get currentState => _currentState;

  void switchToState(BotState newState) {
    if (_currentState == newState) return;
    _currentState = newState;
    notifyListeners();
  }
}
