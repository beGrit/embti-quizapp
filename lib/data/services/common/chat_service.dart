import 'dart:async';

import 'package:emombti/app_state/chat.dart';
import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/repositories/chat/chat_repository.dart';
import 'package:emombti/domain/models/chat/chat.dart';

class ChatService {
  ChatService({
    required AuthRepository authRepository,
    required ChatRepository chatRepository,
    required ChatState chatState,
  }) : _authRepository = authRepository,
       _chatRepository = chatRepository,
       _chatState = chatState {
    _authRepository.addListener(_onAuthChanged);
    _onAuthChanged();
  }

  final AuthRepository _authRepository;
  final ChatRepository _chatRepository;
  final ChatState _chatState;

  StreamSubscription<Message>? _globalSubscription;
  String? _subscribedUserId;

  void _onAuthChanged() async {
    // customer logined in with different account, need to resubscribe to new user's messages
    final user = _authRepository.user;
    final userId = user?.id;

    if (userId == _subscribedUserId) return;

    _globalSubscription?.cancel();
    _subscribedUserId = null;
    _chatState.setCurrentUserId(userId);

    if (userId != null) {
      _subscribedUserId = userId;
      _globalSubscription = _chatRepository
          .subscribeToMessagesInUserScope(userId)
          .listen((message) {
            _chatState.handleNewMessage(message);
          });
    }
  }

  void dispose() {
    _authRepository.removeListener(_onAuthChanged);
    _globalSubscription?.cancel();
  }
}
