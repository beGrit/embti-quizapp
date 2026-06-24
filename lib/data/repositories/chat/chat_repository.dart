import 'package:emombti/domain/constants/db.dart';
import 'package:emombti/domain/constants/status.dart';
import 'package:emombti/domain/models/chat/chat.dart';
import 'package:emombti/utils/result.dart';

abstract class ChatRepository {
  /// Fetches a non-paginated list of all rooms.
  Future<Result<List<Chat>>> getChats(String userId);

  Future<Result<List<Message>>> getMessagesLimit(
    String roomId, {
    PaginationDirection direction = PaginationDirection.next,
    int? limit,
    String? messageId,
  });

  /// Sends a message to a specific room.
  Future<Result<Message>> sendMessage(Message message);

  /// Subscribes to real-time message updates for a specific room.
  Stream<List<MessageChange>> subscribeToChat(String roomId);

  /// Subscribes to real-time message updates for user.
  Stream<Message> subscribeToMessagesInUserScope(String userId);

  Stream<ChatConnectionStatus> subscribeChatConnectionStatus(String roomId);

  /// Creates or returns an existing direct chat with another user.
  Future<Result<Chat>> createDirectChat({
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

  Future<Result<Chat>> addRobotChat({
    required String userId,
    required String robotId,
  });
}
