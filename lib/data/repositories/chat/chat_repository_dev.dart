import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emombti/data/repositories/chat/chat_repository.dart';
import 'package:emombti/data/services/persistence/api/firestore_service.dart';
import 'package:emombti/data/services/persistence/api/model/chat/chat_api_model.dart';
import 'package:emombti/domain/constants/db.dart';
import 'package:emombti/domain/constants/status.dart';
import 'package:emombti/domain/models/chat/chat.dart';
import 'package:emombti/utils/result.dart';
import 'package:uuid/uuid.dart';

class ChatRepositoryDevV2 implements ChatRepository {
  ChatRepositoryDevV2({required FirestoreService firestoreService})
    : _firestoreService = firestoreService;

  final FirestoreService _firestoreService;
  final Map<String, DocumentSnapshot> _messageSnapshotCache = {};

  @override
  Future<Result<List<Chat>>> getChats(String userId) async {
    try {
      final userChats = await _firestoreService.getUserChats(userId);
      if (userChats.isEmpty) {
        return const Result.ok([]);
      }

      final rooms = await _buildChats(userChats);
      return Result.ok(rooms);
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<List<Message>>> getMessagesLimit(
    String roomId, {
    PaginationDirection direction = PaginationDirection.next,
    int? limit,
    String? messageId,
  }) async {
    try {
      DocumentSnapshot? lastDocument;
      if (messageId != null) {
        // if (!_messageSnapshotCache.containsKey(messageId)) {
        _messageSnapshotCache[messageId] = await _firestoreService
            .getChatMessageSnapshot(roomId, messageId);
        // }
        lastDocument = _messageSnapshotCache[messageId];
      }
      var messages = await _firestoreService.getChatMessages(
        roomId,
        limit: limit,
        lastDocument: lastDocument,
        desc: direction == PaginationDirection.next ? false : true,
      );
      if (direction == PaginationDirection.prev) {
        messages = messages.reversed.toList();
      }
      final domainMessages = messages
          .map((message) => _mapMessageToDomain(message, roomId))
          .toList();
      return Result.ok(domainMessages);
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<Message>> sendMessage(Message message) async {
    try {
      final roomId = message.chatId;
      final senderId = message.sendBy;
      final content = message.message;

      if (roomId == null || roomId.isEmpty) {
        return Result.error(Exception('Message roomId is required'));
      }
      if (senderId == null || senderId.isEmpty) {
        return Result.error(Exception('Message sender is required'));
      }
      if (content == null || content.trim().isEmpty) {
        return Result.error(Exception('Message content is required'));
      }

      final sentAt = message.createdAt ?? DateTime.now();
      final apiMessage = ChatMessageFirestoreApiModel(
        messageId: message.id,
        senderId: senderId,
        type: message.messageType ?? 'text',
        content: content,
        sentAt: sentAt,
        status: 'sent',
      );

      final savedMessage = await _firestoreService.sendChatMessage(
        chatId: roomId,
        message: apiMessage,
      );

      if (savedMessage.status != null && savedMessage.status == 'error') {
        return Result.ok(_mapMessageToDomain(savedMessage, roomId));
      } else {
        await _firestoreService.updateChatMetaAndUserChats(
          chatId: roomId,
          message: apiMessage,
        );
        return Result.ok(_mapMessageToDomain(savedMessage, roomId));
      }
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Stream<Message> subscribeToMessagesInUserScope(String userId) {
    throw UnimplementedError();
  }

  @override
  Future<Result<Chat>> createDirectChat({
    required String currentUserId,
    required String otherUserId,
    String? otherUserName,
  }) async {
    try {
      final room = await _firestoreService.findDirectChat(
        currentUserId: currentUserId,
        otherUserId: otherUserId,
      );

      if (room != null) {
        final userChat = await _firestoreService.getUserChatByChatId(
          currentUserId,
          room.chatId,
        );
        return Result.ok(_mapApiChatToChat(room, userChat: userChat));
      }

      final ChatFirestoreApiModel chatApiModel = await _firestoreService
          .createChat(
            ChatFirestoreApiModel(
              chatId: Uuid().v4(),
              createdAt: DateTime.now(),
              isGroup: false,
              members: [currentUserId, otherUserId],
            ),
          );
      var userChatMap = await _firestoreService.addChatToUsers(chatApiModel);

      return Result.ok(
        _mapApiChatToChat(chatApiModel, userChat: userChatMap[currentUserId]),
      );
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<void>> deleteRoom({
    required String userId,
    required String roomId,
  }) async {
    try {
      final chat = await _firestoreService.getChat(roomId);
      if (chat == null) {
        return Result.error(Exception('Chat not found'));
      }

      if (!chat.isGroup) {
        await _firestoreService.deleteChat(
          chatId: roomId,
          members: chat.members,
        );
      } else {
        await _firestoreService.deleteUserChat(userId: userId, chatId: roomId);
      }
      return const Result.ok(null);
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  Future<List<Chat>> _buildChats(
    List<UserChatFirestoreApiModel> userChats,
  ) async {
    final chatIds = userChats.map((chat) => chat.chatId).toList();
    final chats = await _firestoreService.getChatsByIds(chatIds);
    final chatsById = {for (final chat in chats) chat.chatId: chat};

    final rooms = <Chat>[];
    for (final userChat in userChats) {
      final chat = chatsById[userChat.chatId];
      if (chat == null) {
        continue;
      }
      rooms.add(_mapApiChatToChat(chat, userChat: userChat));
    }

    return rooms;
  }

  Chat _mapApiChatToChat(
    ChatFirestoreApiModel chat, {
    UserChatFirestoreApiModel? userChat,
  }) {
    final lastMessageAt =
        userChat?.lastMessageSentAt ??
        chat.lastMessage?.sentAt ??
        chat.createdAt;
    final lastMessageText = userChat?.lastMessageText ?? chat.lastMessage?.text;

    return Chat(
      id: chat.chatId,
      name: userChat?.name != null ? userChat!.name : chat.chatName,
      image: userChat?.image != null ? userChat!.image : chat.chatImage,
      created: chat.createdAt,
      updated: lastMessageAt,
      isGroup: chat.isGroup,
      lastMessage: lastMessageText,
      lastMessageAt: lastMessageAt,
    );
  }

  Message _mapMessageToDomain(
    ChatMessageFirestoreApiModel message,
    String chatId,
  ) {
    final sentAt = message.sentAt;
    return Message(
      id: message.messageId,
      chatId: chatId,
      sendBy: message.senderId,
      message: message.content,
      messageType: message.type,
      createdAt: sentAt,
      created: sentAt,
      updated: sentAt,
      status: message.status,
    );
  }

  @override
  Future<Result<Robot>> addRobot({
    required String userId,
    required String robotTemplate,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Result<Chat>> addRobotChat({
    required String userId,
    required String robotId,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Robot>>> getRobots({required String userId}) {
    throw UnimplementedError();
  }

  @override
  Stream<List<MessageChange>> subscribeToChat(String roomId) {
    return _firestoreService.subscribeToChatMessages(roomId).map((apiChanges) {
      return apiChanges.map((apiChange) {
        MessageChangeType domainChangeType;
        switch (apiChange.type) {
          case MessageChangeApiType.added:
            domainChangeType = MessageChangeType.added;
            break;
          case MessageChangeApiType.modified:
            domainChangeType = MessageChangeType.modified;
            break;
          case MessageChangeApiType.removed:
            domainChangeType = MessageChangeType.removed;
            break;
        }

        final apiMessage = apiChange.message;
        final domainMessage = Message(
          id: apiMessage.id ?? apiMessage.messageId,
          message: apiMessage.content,
          sendBy: apiMessage.senderId,
          messageType: apiMessage.type,
          chatId: roomId,
          createdAt: apiMessage.sentAt,
          created: apiMessage.sentAt,
          updated: apiMessage.sentAt,
        );

        return MessageChange(type: domainChangeType, message: domainMessage);
      }).toList();
    });
  }

  @override
  Stream<ChatConnectionStatus> subscribeChatConnectionStatus(String roomId) {
    final controller = StreamController<ChatConnectionStatus>();
    _firestoreService
        .monitorChatConnection(roomId)
        .listen(
          (item) {
            if (!controller.isClosed) {
              if (item.isConnected) {
                controller.add(ChatConnectionStatus.connected);
              } else {
                controller.add(ChatConnectionStatus.disconnected);
              }
            }
          },
          onError: (error) {
            if (!controller.isClosed) {
              controller.addError(error);
            }
          },
        );
    return controller.stream;
  }
}
