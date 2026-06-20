import 'package:emombti/domain/models/chat/chat.dart';
import 'package:flutter/foundation.dart';

class ChatState extends ChangeNotifier {
  /// List of chat rooms.
  List<Room> _rooms = [];
  List<Room> get rooms => _rooms;

  /// Map of roomId to unread message count.
  final Map<String, int> _unreadCounts = {};

  /// The ID of the current user to filter own messages.
  String? _currentUserId;

  /// The ID of the currently active chat room, if any.
  String? _activeRoomId;

  /// Messages for the currently active room.
  List<Message> _activeRoomMessages = [];
  List<Message> get activeRoomMessages => _activeRoomMessages;

  void setRooms(List<Room> rooms) {
    _rooms = [...rooms];
    notifyListeners();
  }

  void addRoom(Room room) {
    _rooms = [..._rooms, room];
    notifyListeners();
  }

  void removeRoom(String roomId) {
    _rooms.removeWhere((r) => r.id == roomId);
    _unreadCounts.remove(roomId);
    notifyListeners();
  }

  /// Returns the unread count for a specific room.
  int getUnreadCount(String roomId) => _unreadCounts[roomId] ?? 0;

  /// Returns the total unread count across all rooms.
  int get totalUnreadCount =>
      _unreadCounts.values.fold(0, (sum, count) => sum + count);

  /// Sets the current user ID.
  void setCurrentUserId(String? userId) {
    _currentUserId = userId;
  }

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
    } else {
      _activeRoomMessages = [];
    }
    notifyListeners();
  }

  /// Sets the messages for the active room.
  void setActiveRoomMessages(List<Message> messages) {
    _activeRoomMessages = messages;
    notifyListeners();
  }

  /// Adds a single message to the active room's list.
  void addMessageToActiveRoom(Message message) {
    if (!_activeRoomMessages.any((m) => m.id == message.id)) {
      _activeRoomMessages.insert(0, message);
      notifyListeners();
    }
  }

  /// Handles a newly received message.
  void handleNewMessage(Message message) {
    if (message.sendBy == _currentUserId) return;
    final roomId = message.roomId;
    if (roomId == null) return;

    // Ignore messages from rooms that are not in the current list.
    if (!_rooms.any((room) => room.id == roomId)) return;

    if (roomId == _activeRoomId) {
      addMessageToActiveRoom(message);
    } else {
      incrementUnreadCount(roomId);
    }
  }
}
