import 'dart:async';

import 'package:emombti/app_state/auth.dart';
import 'package:emombti/app_state/chat.dart';
import 'package:emombti/data/repositories/chat/chat_repository.dart';
import 'package:emombti/domain/models/chat/chat.dart';

class ChatService {
  ChatService({
    required ChatRepository chatRepository,
    required ChatState chatState,
    required AuthState authState,
  }) : _chatRepository = chatRepository,
       _chatState = chatState,
       _authState = authState {
    _authState.addListener(_onAuthChanged);
    _onAuthChanged();
  }

  final ChatRepository _chatRepository;
  final ChatState _chatState;
  final AuthState _authState;

  StreamSubscription<Message>? _globalSubscription;
  String? _subscribedUserId;

  void _onAuthChanged() async {
    // customer logined in with different account, need to resubscribe to new user's messages
    final user = _authState.user;
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
    _authState.removeListener(_onAuthChanged);
    _globalSubscription?.cancel();
  }
}
