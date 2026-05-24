import 'dart:async';

import 'package:emombti/app_state/chat_state.dart';
import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/repositories/chat/chat_repository.dart';
import 'package:emombti/domain/models/chat/chat.dart';
import 'package:emombti/utils/command.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';

class RoomDetailViewModel extends ChangeNotifier {
  RoomDetailViewModel({
    required this.room,
    required AuthRepository authRepository,
    required ChatRepository chatRepository,
    required ChatState chatState,
  }) : _authRepository = authRepository,
       _chatRepository = chatRepository,
       _chatState = chatState {
        loadMessagesCommand = Command0(_loadMessages);
    }

  final Room room;
  final AuthRepository _authRepository;
  final ChatRepository _chatRepository;
  final ChatState _chatState;

  late final Command0<void> loadMessagesCommand;

  String? get currentUserId => _authRepository.user?.id;

  void init() async {
    _chatState.setActiveRoom(room.id);
    loadMessagesCommand.execute();
  }

  Future<Result<void>> _loadMessages() async {
    final result = await _chatRepository.getMessages(room.id);
    if (result is Ok<List<Message>>) {
      _chatState.setActiveRoomMessages(result.value);
    }
    return Result.ok(null);
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final user = _authRepository.user;
    if (user == null) return;

    final message = Message(
      id: '',
      roomId: room.id,
      sendBy: user.id,
      message: text,
      messageType: 'text',
      createdAt: DateTime.now(),
      created: DateTime.now(),
      updated: DateTime.now(),
    );

    // server state
    Result<Message> result = await _chatRepository.sendMessage(message);

    if (result is Ok<Message>) {
      // The message will be handled by the global subscription and updated in ChatState.
      // But we can also manually add it to the active room messages for immediate feedback.
      _chatState.addMessageToActiveRoom(result.value);
    }
  }
}
