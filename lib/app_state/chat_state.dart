import 'package:flutter/foundation.dart';

class ChatState extends ChangeNotifier {
  /// Map of roomId to unread message count.
  final Map<String, int> _unreadCounts = {};

  /// Map of messageId to read status.
  final Map<String, bool> _messageReadStatus = {};

  /// The ID of the currently active chat room, if any.
  String? _activeRoomId;

  /// Returns the unread count for a specific room.
  int getUnreadCount(String roomId) => _unreadCounts[roomId] ?? 0;

  /// Returns the total unread count across all rooms.
  int get totalUnreadCount =>
      _unreadCounts.values.fold(0, (sum, count) => sum + count);

  /// Returns whether a specific message has been read.
  bool isMessageRead(String messageId) => _messageReadStatus[messageId] ?? false;

  /// Sets the unread count for a specific room.
  void setUnreadCount(String roomId, int count) {
    _unreadCounts[roomId] = count;
    notifyListeners();
  }

  /// Increments the unread count for a specific room.
  void incrementUnreadCount(String roomId) {
    _unreadCounts[roomId] = (_unreadCounts[roomId] ?? 0) + 1;
    notifyListeners();
  }

  /// Marks all messages in a room as read (locally).
  void markRoomAsRead(String roomId) {
    if (_unreadCounts[roomId] != 0) {
      _unreadCounts[roomId] = 0;
      notifyListeners();
    }
  }

  /// Sets the currently active room.
  void setActiveRoom(String? roomId) {
    _activeRoomId = roomId;
    if (roomId != null) {
      markRoomAsRead(roomId);
    }
  }

  /// Handles a newly received message.
  void handleNewMessage(String roomId) {
    if (roomId != _activeRoomId) {
      incrementUnreadCount(roomId);
    }
  }

  /// Sets the read status for a specific message.
  void setMessageReadStatus(String messageId, bool isRead) {
    if (_messageReadStatus[messageId] != isRead) {
      _messageReadStatus[messageId] = isRead;
      notifyListeners();
    }
  }
}
