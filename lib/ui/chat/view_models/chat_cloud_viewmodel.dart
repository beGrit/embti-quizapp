import 'dart:async';

import 'package:emombti/app_state/auth.dart';
import 'package:emombti/app_state/chat.dart';
import 'package:emombti/data/repositories/chat/chat_repository.dart';
import 'package:emombti/domain/constants/db.dart';
import 'package:emombti/domain/constants/status.dart';
import 'package:emombti/domain/models/chat/chat.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart' as fcc;
import 'package:flutter_chat_core/flutter_chat_core.dart' hide Message;
import 'package:uuid/uuid.dart';

class ChatCloudViewModel extends ChangeNotifier {
  static final batchMessageLimit = 20;
  late final String chatId;
  late final Chat chat;
  late final Stream<ChatConnectionStatus> connectionStatusStream;
  StreamSubscription<List<MessageChange>>? messagesSubscription;
  late final InMemoryChatController chatController;
  late final AuthState authState;
  late final ChatState chatState;
  late final ChatRepository chatRepository;

  ChatCloudViewModel({
    required this.chatId,
    required this.authState,
    required this.chatState,
    required this.chatRepository,
  }) {
    chatController = InMemoryChatController();
    var stateChat = chatState.getChat(chatId);
    if (stateChat != null) {
      chat = stateChat;
      if (chat.roomMembers.isEmpty) {}
    } else {
      chat = Chat(id: '', created: DateTime.now(), updated: DateTime.now());
    }
  }

  PageStatus pageStatus = PageStatus.init;
  String get currentUserId => authState.userId ?? '';
  final Map<fcc.UserID, fcc.User> users = {};
  bool get onEndReachedAble => _hasMore;

  void connect() async {
    // old messages
    Result<List<Message>> result = await chatRepository.getMessagesLimit(
      chatId,
      direction: PaginationDirection.prev,
      limit: batchMessageLimit,
    );
    if (result is Ok) {
      List<Message> messages = (result as Ok).value;
      List<fcc.Message> fccMessages = messages
          .map((e) => convertToFccMessage(e))
          .toList();
      chatController.setMessages(fccMessages, animated: false);
      _lastMessageId = fccMessages.firstOrNull?.id;
    }

    messagesSubscription?.cancel();

    connectionStatusStream = chatRepository.subscribeChatConnectionStatus(
      chatId,
    );
    messagesSubscription = chatRepository.subscribeToChat(chatId).listen((
      changes,
    ) {
      for (final change in changes) {
        if (change.message.sendBy == authState.userId) return;
        switch (change.type) {
          case MessageChangeType.added:
            final isDuplicate = chatController.messages.any(
              (m) => m.id == change.message.id,
            );
            if (!isDuplicate) {
              chatController.insertMessage(convertToFccMessage(change.message));
              chatState.handleNewMessage(
                change.message,
                authState.userId ?? '',
              );
            }
            break;
          case MessageChangeType.modified:
            break;
          case MessageChangeType.removed:
            chatController.removeMessage(convertToFccMessage(change.message));
            break;
        }
      }
    }, onError: (error) {});

    pageStatus = PageStatus.completed;
    notifyListeners();
  }

  void sendMessage(String? text) async {
    final message = await createMessage(currentUserId, text: text);
    final originalMetadata = message.metadata;

    await chatController.insertMessage(
      message.copyWith(metadata: {...?originalMetadata, 'sending': true}),
    );

    try {
      Result<Message> result = await chatRepository.sendMessage(
        convertToDomainMessage(message).copyWith(chatId: chatId),
      );
      Message? domainMessage;
      if (result is Ok) {
        domainMessage = (result as Ok).value;
      }
      if (domainMessage != null) {
        // Make sure to get the updated message
        // (width and height might have been set by the image message widget)
        final currentMessage = chatController.messages.firstWhere(
          (element) => element.id == message.id,
          orElse: () => message,
        );
        final nextMessage = currentMessage.copyWith(
          id: domainMessage.id,
          createdAt: null,
          sentAt: domainMessage.createdAt,
          metadata: originalMetadata,
          status: domainMessage.status == 'error'
              ? fcc.MessageStatus.error
              : null,
        );
        await chatController.updateMessage(currentMessage, nextMessage);
        chatState.handleNewMessage(domainMessage, authState.userId ?? '');
      }
    } catch (error) {
      debugPrint('Error sending message: $error');
      rethrow;
    }
  }

  void removeMessage() {}

  void handleAttachmentTap() async {}

  fcc.Message convertToFccMessage(Message message) {
    final messageId = message.id;
    final authorId = message.sendBy ?? '';
    final timestamp = message.createdAt ?? message.created;

    switch (message.messageType) {
      case 'text':
      case null:
        return fcc.Message.text(
          id: messageId,
          authorId: authorId,
          replyToMessageId: message.replyId,
          createdAt: timestamp,
          sentAt: timestamp,
          updatedAt: message.updated,
          text: message.message ?? '',
          status: message.status != null && message.status == 'error'
              ? fcc.MessageStatus.error
              : null,
        );

      case 'image':
        return fcc.Message.image(
          id: messageId,
          authorId: authorId,
          replyToMessageId: message.replyId,
          createdAt: timestamp,
          sentAt: timestamp,
          updatedAt: message.updated,
          source: message.messageFile ?? message.message ?? '',
          text: message.message,
          status: message.status != null && message.status == 'error'
              ? fcc.MessageStatus.error
              : null,
        );

      case 'file':
        return fcc.Message.file(
          id: messageId,
          authorId: authorId,
          replyToMessageId: message.replyId,
          createdAt: timestamp,
          sentAt: timestamp,
          updatedAt: message.updated,
          source: message.messageFile ?? '',
          name: message.message ?? 'File',
          status: message.status != null && message.status == 'error'
              ? fcc.MessageStatus.error
              : null,
        );

      case 'audio':
      case 'voice':
        return fcc.Message.audio(
          id: messageId,
          authorId: authorId,
          replyToMessageId: message.replyId,
          createdAt: timestamp,
          sentAt: timestamp,
          updatedAt: message.updated,
          source: message.messageFile ?? '',
          duration: Duration(
            milliseconds: ((message.voiceMessageDuration ?? 0) * 1000).toInt(),
          ),
          text: message.message,
          status: message.status != null && message.status == 'error'
              ? fcc.MessageStatus.error
              : null,
        );

      default:
        return fcc.Message.unsupported(
          id: messageId,
          authorId: authorId,
          replyToMessageId: message.replyId,
          createdAt: timestamp,
          sentAt: timestamp,
          updatedAt: message.updated,
          status: message.status != null && message.status == 'error'
              ? fcc.MessageStatus.error
              : null,
        );
    }
  }

  Message convertToDomainMessage(fcc.Message message) {
    final baseMetadata = message.metadata ?? {};
    final timestamp = message.resolvedTime ?? DateTime.now();

    return message.map(
      text: (m) => Message(
        id: m.id,
        message: m.text,
        sendBy: m.authorId,
        messageType: 'text',
        replyId: m.replyToMessageId,
        createdAt: m.createdAt,
        created: m.createdAt ?? timestamp,
        updated: m.updatedAt ?? timestamp,
        chatId: baseMetadata['room_id'] as String?,
        replyBy: baseMetadata['reply_by'] as String?,
        replyTo: baseMetadata['reply_to'] as String?,
        replyMessage: baseMetadata['reply_message'] as String?,
        replyMessageType: baseMetadata['reply_message_type'] as String?,
      ),
      textStream: (m) => Message(
        id: m.id,
        message: '',
        sendBy: m.authorId,
        messageType: 'text_stream',
        replyId: m.replyToMessageId,
        createdAt: m.createdAt,
        created: m.createdAt ?? timestamp,
        updated: m.updatedAt ?? timestamp,
        chatId: baseMetadata['room_id'] as String?,
      ),
      image: (m) => Message(
        id: m.id,
        message: m.text,
        sendBy: m.authorId,
        messageType: 'image',
        messageFile: m.source,
        replyId: m.replyToMessageId,
        createdAt: m.createdAt,
        created: m.createdAt ?? timestamp,
        updated: m.updatedAt ?? timestamp,
        chatId: baseMetadata['room_id'] as String?,
      ),
      file: (m) => Message(
        id: m.id,
        message: m.name,
        sendBy: m.authorId,
        messageType: 'file',
        messageFile: m.source,
        replyId: m.replyToMessageId,
        createdAt: m.createdAt,
        created: m.createdAt ?? timestamp,
        updated: m.updatedAt ?? timestamp,
        chatId: baseMetadata['room_id'] as String?,
      ),
      video: (m) => Message(
        id: m.id,
        message: m.text ?? m.name,
        sendBy: m.authorId,
        messageType: 'video',
        messageFile: m.source,
        replyId: m.replyToMessageId,
        createdAt: m.createdAt,
        created: m.createdAt ?? timestamp,
        updated: m.updatedAt ?? timestamp,
        chatId: baseMetadata['room_id'] as String?,
      ),
      audio: (m) => Message(
        id: m.id,
        message: m.text,
        sendBy: m.authorId,
        messageType: 'audio',
        messageFile: m.source,
        voiceMessageDuration: m.duration.inMilliseconds / 1000.0,
        replyId: m.replyToMessageId,
        createdAt: m.createdAt,
        created: m.createdAt ?? timestamp,
        updated: m.updatedAt ?? timestamp,
        chatId: baseMetadata['room_id'] as String?,
      ),
      system: (m) => Message(
        id: m.id,
        message: m.text,
        sendBy: m.authorId,
        messageType: 'system',
        replyId: m.replyToMessageId,
        createdAt: m.createdAt,
        created: m.createdAt ?? timestamp,
        updated: m.updatedAt ?? timestamp,
        chatId: baseMetadata['room_id'] as String?,
      ),
      custom: (m) => Message(
        id: m.id,
        sendBy: m.authorId,
        messageType: 'custom',
        replyId: m.replyToMessageId,
        createdAt: m.createdAt,
        created: m.createdAt ?? timestamp,
        updated: m.updatedAt ?? timestamp,
        chatId: baseMetadata['room_id'] as String?,
      ),
      unsupported: (m) => Message(
        id: m.id,
        message: baseMetadata['fallback_message'] as String?,
        sendBy: m.authorId,
        messageType:
            (baseMetadata['original_type'] as String?) ?? 'unsupported',
        replyId: m.replyToMessageId,
        createdAt: m.createdAt,
        created: m.createdAt ?? timestamp,
        updated: m.updatedAt ?? timestamp,
        chatId: baseMetadata['room_id'] as String?,
      ),
    );
  }

  Future<fcc.Message> createMessage(UserID authorId, {String? text}) async {
    const uuid = Uuid();
    fcc.Message message;
    message = TextMessage(
      id: uuid.v4(),
      authorId: authorId,
      createdAt: DateTime.now().toUtc(),
      sentAt: DateTime.now().toUtc(),
      text: text ?? '',
      metadata: isOnlyEmoji(text ?? '') ? {'isOnlyEmoji': true} : null,
    );
    return message;
  }

  MessageID? _lastMessageId;
  bool _hasMore = true;
  bool _isLoading = false;

  Future<void> loadOlderMessages() async {
    if (!_hasMore || _isLoading) return;

    _isLoading = true;

    List<fcc.Message> fccMessages = [];
    var result = await chatRepository.getMessagesLimit(
      chatId,
      direction: PaginationDirection.prev,
      limit: batchMessageLimit,
      messageId: _lastMessageId,
    );

    if (result is Ok) {
      List<Message> messages = (result as Ok).value;
      fccMessages = messages.map((e) => convertToFccMessage(e)).toList();
    }

    if (fccMessages.isEmpty) {
      _hasMore = false;
      _isLoading = false;
      notifyListeners();
      return;
    }

    await chatController.insertAllMessages(
      fccMessages,
      index: 0,
      animated: false,
    );
    _lastMessageId = fccMessages.first.id;
    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    messagesSubscription?.cancel();
    chatController.dispose();
    super.dispose();
  }
}
