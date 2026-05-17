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
       _chatRepository = chatRepository {
    _initMessagePipeline();
  }

  final Room room;
  final AuthRepository _authRepository;
  final ChatRepository _chatRepository;

  final List<Message> _messages = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  String? get currentUserId => _authRepository.user?.id;

  final StreamController<List<Message>> _messagesStreamController =
      StreamController<List<Message>>.broadcast();
  StreamSubscription<Message>? _realtimeSubscription;

  Stream<List<Message>> get messagesStream => _messagesStreamController.stream;
  List<Message> get messages => _messages.reversed.toList();

  void _initMessagePipeline() async {
    _isLoading = true;
    notifyListeners();

    final result = await _chatRepository.getMessages(room.id);
    if (result is Ok<List<Message>>) {
      _messages.clear();
      _messages.addAll(result.value);
      _messagesStreamController.add(List.from(_messages));
    }

    _isLoading = false;
    notifyListeners();

    _startRealtimeSubscription();
  }

  void _startRealtimeSubscription() {
    _realtimeSubscription?.cancel();

    _realtimeSubscription = _chatRepository
        .subscribeToMessages(room.id)
        .listen(
          (newMessage) {
            if (!_messages.any((m) => m.id == newMessage.id)) {
              _messages.insert(0, newMessage);
              _messagesStreamController.add(List.from(_messages));
            }
          },
          onError: (error) {
            _messagesStreamController.addError(error);
          },
        );
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

    final result = await _chatRepository.sendMessage(message);

    if (result is Ok<Message>) {
      if (!_messages.any((m) => m.id == result.value.id)) {
        return;
      }
    }
  }

  @override
  void dispose() {
    _realtimeSubscription?.cancel();
    _messagesStreamController.close();
    super.dispose();
  }

  Future<void> loadMessages() async {}
}
