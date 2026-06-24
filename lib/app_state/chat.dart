import 'package:emombti/domain/models/chat/chat.dart';
import 'package:flutter/foundation.dart';

class ChatState extends ChangeNotifier {
  List<Chat> _chats = [];
  List<Chat> get chats => _chats;

  final Map<String, int> _unreadCounts = {};

  Chat? getChat(String roomId) {
    try {
      return _chats.firstWhere((room) => room.id == roomId);
    } catch (e) {
      return null;
    }
  }

  void setChats(List<Chat> chats) {
    _chats = [...chats];
    notifyListeners();
  }

  void addChat(Chat chat) {
    _chats = [..._chats, chat];
    notifyListeners();
  }

  void removeChat(String chatId) {
    _chats.removeWhere((r) => r.id == chatId);
    _unreadCounts.remove(chatId);
    notifyListeners();
  }

  /// Returns the unread count for a specific room.
  int getUnreadCount(String chatId) => _unreadCounts[chatId] ?? 0;

  /// Returns the total unread count across all rooms.
  int get totalUnreadCount =>
      _unreadCounts.values.fold(0, (sum, count) => sum + count);

  void setUnreadCount(Map<String, int> unreadCounts) {
    _unreadCounts.clear();
    _unreadCounts.addAll(unreadCounts);
    notifyListeners();
  }

  void updateUnreadCount(String roomId, int count) {
    _unreadCounts[roomId] = count;
    notifyListeners();
  }

  /// Increments the unread count for a specific room.
  void incrementUnreadCount(String chatId) {
    _unreadCounts[chatId] = (_unreadCounts[chatId] ?? 0) + 1;
    notifyListeners();
  }

  /// Marks all messages in a room as read (locally).
  void markRoomAsRead(String chatId) {
    if (_unreadCounts[chatId] != 0) {
      _unreadCounts[chatId] = 0;
      notifyListeners();
    }
  }

  /// Handles a newly received message.
  void handleNewMessage(
    Message message,
    String currentUserId, {
    bool unread = false,
  }) {
    if (message.chatId == null) return;
    String chatId = message.chatId ?? '';
    int index = _chats.indexWhere((room) => room.id == chatId);
    if (index == -1) return;
    _chats[index] = _chats[index].copyWith(
      lastMessage: message.message,
      lastMessageAt: message.createdAt,
    );
    if (message.sendBy != currentUserId && unread) {
      _unreadCounts[chatId] = (_unreadCounts[chatId] ?? 0) + 1;
    }

    notifyListeners();
  }
}
