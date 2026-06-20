import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:emombti/data/repositories/chat/chat_repository.dart';
import 'package:emombti/data/services/persistence/api/firestore_service.dart';
import 'package:emombti/data/services/persistence/api/model/chat/chat_api_model.dart';
import 'package:emombti/domain/models/chat/chat.dart';
import 'package:emombti/utils/result.dart';

class ChatRepositoryDevV2 implements ChatRepository {
  ChatRepositoryDevV2({required FirestoreService firestoreService})
    : _firestoreService = firestoreService {
    _initStatusMonitoring();
  }

  final FirestoreService _firestoreService;
  final Map<int, DocumentSnapshot> _roomPaginationCursors = {};

  final _connectionStatusController =
      StreamController<ChatSystemStatus>.broadcast();
  ChatSystemStatus _currentStatus = const ChatSystemStatus(
    isNetworkConnected: true,
    isFirestoreConnected: true,
  );
  StreamSubscription? _connectivitySubscription;
  Timer? _firestorePingTimer;

  @override
  Stream<ChatSystemStatus> get connectionStatusStream =>
      _connectionStatusController.stream;

  @override
  ChatSystemStatus get currentConnectionStatus => _currentStatus;

  @override
  Future<Result<List<Room>>> getRooms(String userId) async {
    try {
      final userChats = await _firestoreService.getUserChats(userId);
      if (userChats.isEmpty) {
        return const Result.ok([]);
      }

      final rooms = await _buildRooms(userChats);
      return Result.ok(rooms);
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<Room>> getRoomById(String id) async {
    try {
      final chat = await _firestoreService.getChat(id);
      if (chat == null) {
        return Result.error(Exception('Chat not found'));
      }

      return Result.ok(_mapChatToRoom(chat));
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<List<Room>>> getRoomsPaginated({
    required String userId,
    required int page,
    required int perPage,
  }) async {
    try {
      DocumentSnapshot? cursor;
      if (page > 1) {
        cursor = _roomPaginationCursors[page - 1];
        if (cursor == null) {
          return const Result.ok([]);
        }
      }

      final result = await _firestoreService.getUserChatsPaginated(
        userId: userId,
        limit: perPage,
        lastDocument: cursor,
      );

      if (result.lastDocument != null) {
        _roomPaginationCursors[page] = result.lastDocument!;
      }

      final rooms = await _buildRooms(result.chats);
      return Result.ok(rooms);
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<Message?>> getLatestMessageForRoom(String roomId) async {
    try {
      final latestMessage = await _firestoreService.getLatestChatMessage(
        roomId,
      );
      if (latestMessage == null) {
        return const Result.ok(null);
      }

      return Result.ok(_mapMessageToDomain(latestMessage, roomId));
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<List<RoomMember>>> getRoomMembers(String roomId) async {
    try {
      final chat = await _firestoreService.getChat(roomId);
      if (chat == null) {
        return Result.error(Exception('Chat not found'));
      }

      final members = chat.members
          .map((memberId) => _mapMemberToDomain(chat, memberId))
          .toList();
      return Result.ok(members);
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<List<Message>>> getMessages(String roomId) async {
    try {
      final messages = await _firestoreService.getChatMessages(roomId);
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
      final roomId = message.roomId;
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
      );

      final savedMessage = await _firestoreService.sendChatMessage(
        chatId: roomId,
        message: apiMessage,
      );

      return Result.ok(_mapMessageToDomain(savedMessage, roomId));
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Stream<Message> subscribeToMessages(String roomId) {
    return _firestoreService
        .subscribeToChatMessages(roomId)
        .map((message) => _mapMessageToDomain(message, roomId));
  }

  @override
  Stream<Message> subscribeToMessagesInUserScope(String userId) {
    return _firestoreService
        .subscribeToUserChatMessages(userId)
        .map((event) => _mapMessageToDomain(event.message, event.chatId));
  }

  @override
  Future<Result<Room>> createDirectChat({
    required String currentUserId,
    required String otherUserId,
    String? otherUserName,
  }) async {
    try {
      final existingChat = await _firestoreService.findDirectChat(
        userId1: currentUserId,
        userId2: otherUserId,
      );

      if (existingChat != null) {
        return Result.ok(_mapChatToRoom(existingChat));
      }

      final chat = await _firestoreService.createDirectChat(
        currentUserId: currentUserId,
        otherUserId: otherUserId,
        otherUserName: otherUserName,
      );

      return Result.ok(_mapChatToRoom(chat));
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

  Future<List<Room>> _buildRooms(
    List<UserChatFirestoreApiModel> userChats,
  ) async {
    final chatIds = userChats.map((chat) => chat.chatId).toList();
    final chats = await _firestoreService.getChatsByIds(chatIds);
    final chatsById = {for (final chat in chats) chat.chatId: chat};

    final rooms = <Room>[];
    for (final userChat in userChats) {
      final chat = chatsById[userChat.chatId];
      if (chat == null) {
        continue;
      }
      rooms.add(_mapChatToRoom(chat, userChat: userChat));
    }

    return rooms;
  }

  Room _mapChatToRoom(
    ChatFirestoreApiModel chat, {
    UserChatFirestoreApiModel? userChat,
  }) {
    final lastMessageAt =
        userChat?.lastMessageSentAt ??
        chat.lastMessage?.sentAt ??
        chat.createdAt;
    final lastMessageText = userChat?.lastMessageText ?? chat.lastMessage?.text;

    return Room(
      id: chat.chatId,
      name: chat.chatName,
      chatId: chat.chatId,
      created: chat.createdAt,
      updated: lastMessageAt,
      lastMessage: lastMessageText,
      lastMessageAt: lastMessageAt,
    );
  }

  RoomMember _mapMemberToDomain(ChatFirestoreApiModel chat, String memberId) {
    return RoomMember(
      id: '${chat.chatId}_$memberId',
      roomId: chat.chatId,
      userId: memberId,
      created: chat.createdAt,
      updated: chat.createdAt,
    );
  }

  Message _mapMessageToDomain(
    ChatMessageFirestoreApiModel message,
    String chatId,
  ) {
    final sentAt = message.sentAt;
    return Message(
      id: message.messageId,
      roomId: chatId,
      sendBy: message.senderId,
      message: message.content,
      messageType: message.type,
      createdAt: sentAt,
      created: sentAt,
      updated: sentAt,
    );
  }

  void _initStatusMonitoring() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      results,
    ) {
      final isNetworkConnected =
          results.isNotEmpty && !results.contains(ConnectivityResult.none);
      _updateNetworkStatus(isNetworkConnected);
    });

    Connectivity().checkConnectivity().then((results) {
      final isNetworkConnected =
          results.isNotEmpty && !results.contains(ConnectivityResult.none);
      _updateNetworkStatus(isNetworkConnected);
    });

    _firestorePingTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      _checkFirestoreStatus();
    });
    _checkFirestoreStatus();
  }

  void _updateNetworkStatus(bool isNetworkConnected) {
    if (_currentStatus.isNetworkConnected == isNetworkConnected) return;

    _currentStatus = ChatSystemStatus(
      isNetworkConnected: isNetworkConnected,
      isFirestoreConnected: isNetworkConnected
          ? _currentStatus.isFirestoreConnected
          : false,
    );
    _connectionStatusController.add(_currentStatus);

    if (isNetworkConnected) {
      _checkFirestoreStatus();
    }
  }

  Future<void> _checkFirestoreStatus() async {
    if (!_currentStatus.isNetworkConnected) {
      _updateFirestoreStatus(false);
      return;
    }

    try {
      await _firestoreService
          .getChat('non_existent_ping_id')
          .timeout(const Duration(seconds: 4));
      _updateFirestoreStatus(true);
    } catch (_) {
      _updateFirestoreStatus(false);
    }
  }

  void _updateFirestoreStatus(bool isFirestoreConnected) {
    if (_currentStatus.isFirestoreConnected == isFirestoreConnected) return;

    _currentStatus = ChatSystemStatus(
      isNetworkConnected: _currentStatus.isNetworkConnected,
      isFirestoreConnected: isFirestoreConnected,
    );
    _connectionStatusController.add(_currentStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    _firestorePingTimer?.cancel();
    _connectionStatusController.close();
  }

  @override
  Future<Result<Robot>> addRobot({
    required String userId,
    required String robotTemplate,
  }) {
    // TODO: implement addRobot
    throw UnimplementedError();
  }

  @override
  Future<Result<Room>> addRobotChatRoom({
    required String userId,
    required String robotId,
  }) {
    // TODO: implement addRobotChatRoom
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Robot>>> getRobots({required String userId}) {
    // TODO: implement getRobots
    throw UnimplementedError();
  }
}
