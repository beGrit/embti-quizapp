import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

/// Junction or container model mapping chats and users/participants
@freezed
sealed class Chat with _$Chat {
  const Chat._();

  const factory Chat({
    required String id,
    String? name,
    String? image,
    @Default(false) bool isGroup,
    required DateTime created,
    required DateTime updated,

    String? lastMessage,
    DateTime? lastMessageAt,

    @Default([]) List<ChatMember> roomMembers,
    @Default([]) List<Message> messages,
  }) = _Chat;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}

/// Model representing membership of a user in a room
@freezed
sealed class ChatMember with _$ChatMember {
  const ChatMember._();

  const factory ChatMember({required String roomId, required String userId}) =
      _ChatMember;

  factory ChatMember.fromJson(Map<String, dynamic> json) =>
      _$ChatMemberFromJson(json);
}

/// Model representing messages sent within a room
@freezed
sealed class Message with _$Message {
  const Message._();

  const factory Message({
    required String id,
    String? message,
    String? sendBy,
    String? messageType,
    double? voiceMessageDuration,
    String? replyBy,
    String? replyTo,
    String? status,
    DateTime? createdAt,
    String? replyMessage,
    String? replyMessageType,
    String? replyId,
    String? chatId,
    String? messageFile,

    required DateTime created,
    required DateTime updated,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}

enum MessageChangeType { added, modified, removed }

class MessageChange {
  final MessageChangeType type;
  final Message message;

  MessageChange({required this.type, required this.message});
}

@freezed
sealed class Robot with _$Robot {
  const Robot._();

  const factory Robot({String? id, String? key}) = _Robot;

  factory Robot.fromJson(Map<String, dynamic> json) => _$RobotFromJson(json);
}
