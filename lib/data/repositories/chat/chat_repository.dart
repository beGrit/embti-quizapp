import 'package:emombti/domain/models/chat/chat.dart';
import 'package:emombti/utils/result.dart';

abstract class ChatRepository {
  /// Fetches a non-paginated list of all rooms.
  Future<Result<List<Room>>> getRooms(String userId);

  /// Fetches a single room record by its unique ID.
  Future<Result<Room>> getRoomById(String id);

  /// Fetches a paginated list of rooms for the infinite-scroll ListView.
  ///
  /// Implementations should use PocketBase's `expand` query to fetch:
  /// 1. Member avatars (`room_members_via_room_id.user_id`)
  /// 2. The latest message (`messages_via_room_id`) sorted by creation date descending.
  Future<Result<List<Room>>> getRoomsPaginated({
    required String userId,
    required int page,
    required int perPage,
  });

  /// Explicitly fetches the single latest message for a specific room.
  ///
  /// Use this if you prefer to lazy-load or update the last message
  /// independently via a separate network request or WebSocket subscription.
  Future<Result<Message?>> getLatestMessageForRoom(String roomId);

  /// Fetches the members (including user profiles) for a specific room.
  Future<Result<List<RoomMember>>> getRoomMembers(String roomId);

  /// Fetches all messages for a specific room.
  Future<Result<List<Message>>> getMessages(String roomId);

  /// Sends a message to a specific room.
  Future<Result<Message>> sendMessage(Message message);

  /// Subscribes to real-time message updates for a specific room.
  Stream<Message> subscribeToMessages(String roomId);

  /// Subscribes to real-time message updates for user.
  Stream<Message> subscribeToMessagesInUserScope(String userId);

  /// Creates or returns an existing direct chat with another user.
  Future<Result<Room>> createDirectChat({
    required String currentUserId,
    required String otherUserId,
    String? otherUserName,
  });

  /// Deletes a room for a user.
  Future<Result<void>> deleteRoom({
    required String userId,
    required String roomId,
  });

  Future<Result<List<Robot>>> getRobots({required String userId});

  Future<Result<Robot>> addRobot({
    required String userId,
    required String robotTemplate,
  });

  Future<Result<Room>> addRobotChatRoom({
    required String userId,
    required String robotId,
  });

  /// Stream of connection status changes (both network and Firestore).
  Stream<ChatSystemStatus> get connectionStatusStream;

  /// Retrieves the current connection status.
  ChatSystemStatus get currentConnectionStatus;

  /// Cleans up repository subscriptions.
  void dispose();
}

class ChatSystemStatus {
  const ChatSystemStatus({
    required this.isNetworkConnected,
    required this.isFirestoreConnected,
  });

  final bool isNetworkConnected;
  final bool isFirestoreConnected;

  bool get isConnected => isNetworkConnected && isFirestoreConnected;

  @override
  String toString() =>
      'ChatSystemStatus(network: $isNetworkConnected, firestore: $isFirestoreConnected)';
}
