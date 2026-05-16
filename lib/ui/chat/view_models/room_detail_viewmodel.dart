import 'dart:async';

import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/repositories/chat/chat_repository.dart';
import 'package:emombti/domain/models/chat/chat.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';

class RoomDetailViewModel extends ChangeNotifier {
  RoomDetailViewModel({
    required this.room,
    required AuthRepository authRepository,
    required ChatRepository chatRepository,
  }) : _authRepository = authRepository,
       _chatRepository = chatRepository;

  final Room room;
  final AuthRepository _authRepository;
  final ChatRepository _chatRepository;

  List<Message> _messages = [];

  String? get currentUserId => _authRepository.user?.id;

  /// Stream that loads initial history and then listens for real-time updates.
  Stream<List<Message>> get messagesStream async* {
    // Load initial history if empty
    if (_messages.isEmpty) {
      final result = await _chatRepository.getMessages(room.id);
      if (result is Ok<List<Message>>) {
        _messages = result.value;
      }
    }
    yield _messages;

    // Subscribe to new messages
    await for (final newMessage in _chatRepository.subscribeToMessages(
      room.id,
    )) {
      // Avoid duplicates from optimistic UI or race conditions
      if (!_messages.any((m) => m.id == newMessage.id)) {
        _messages.add(newMessage);
        yield _messages;
      }
    }
  }

  /// Returns messages in reverse order for efficient rendering in a reversed ListView
  List<Message> get messages => _messages.reversed.toList();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadMessages() async {
    _isLoading = true;
    notifyListeners();

    final result = await _chatRepository.getMessages(room.id);

    if (result is Ok<List<Message>>) {
      _messages = result.value;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final user = _authRepository.user;
    if (user == null) return;

    final message = Message(
      id: '', // Temporary ID
      roomId: room.id,
      sendBy: user.id,
      message: text,
      messageType: 'text',
      createdAt: DateTime.now(),
      // Required by model but will be ignored/replaced by backend
      created: DateTime.now(),
      updated: DateTime.now(),
    );

    final result = await _chatRepository.sendMessage(message);

    if (result is Ok<Message>) {
      _messages.add(result.value);
      notifyListeners();
    }
  }
}
