import 'package:emombti/app_state/auth.dart';
import 'package:emombti/data/repositories/chat/chat_repository.dart';
import 'package:emombti/data/repositories/user/user_repository.dart';
import 'package:emombti/domain/constants/status.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart' as fcc;
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:uuid/uuid.dart';

class ChatAiViewModel extends ChangeNotifier {
  late final ChatSession? _chat;
  late final GenerativeModel? _model;

  late final AuthState authState;

  late final InMemoryChatController chatController;

  late final ChatRepository chatRepository;
  late final UserRepository userRepository;

  ChatAiViewModel({
    required this.authState,
    required this.chatRepository,
    required this.userRepository,
  }) {
    chatController = InMemoryChatController();
    final generationConfig = GenerationConfig(thinkingConfig: null);
    _model = FirebaseAI.googleAI().generativeModel(
      model: 'gemini-3.1-flash-lite',
      generationConfig: generationConfig,
    );
    _chat = _model?.startChat();
    users[currentRobotId] = fcc.User(
      id: currentRobotId,
      name: 'AI Robot',
      imageSource:
          'https://embti-storage-dev.grit-soft.com/avatars/logo_v4.png',
    );
  }

  PageStatus pageStatus = PageStatus.init;

  String get currentUserId => authState.userId ?? '';
  String get currentRobotId => 'robot-gemini';

  final Map<fcc.UserID, fcc.User> users = {};
  final List<Message> messages = [];

  void sendMessage(String? text) async {
    if (text == null || text.isEmpty) return;
    try {
      addTextItem(currentUserId, text);
      var response = await _chat?.sendMessage(Content.text(text));
      addTextItem(currentRobotId, response?.text ?? '');
    } catch (e) {
      rethrow;
    }
  }

  void addTextItem(String authorId, String? text) {
    if (text == null || text.isEmpty) return;
    var message = Message.text(
      id: Uuid().v4(),
      authorId: authorId,
      replyToMessageId: null,
      createdAt: DateTime.now(),
      sentAt: DateTime.now(),
      updatedAt: DateTime.now(),
      text: text,
      status: MessageStatus.sent,
    );
    messages.add(message);
    chatController.insertMessage(message);
  }
}
