import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

/// Model representing a chat session
/// Based on PocketBase chats collection schema
@freezed
sealed class Chat with _$Chat {
  const Chat._();

  const factory Chat({
    required String id,
    String? title,
    required DateTime created,
    required DateTime updated,
  }) = _Chat;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}

/// Junction or container model mapping chats and users/participants
/// Based on PocketBase rooms collection schema
@freezed
sealed class Room with _$Room {
  const Room._();

  const factory Room({
    required String id,
    String? name,
    @JsonKey(name: 'created_by') String? createdBy,
    @JsonKey(name: 'chat_id') String? chatId,
    required DateTime created,
    required DateTime updated,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}

/// Model representing membership of a user in a room
/// Based on PocketBase room_members collection schema
@freezed
sealed class RoomMember with _$RoomMember {
  const RoomMember._();

  const factory RoomMember({
    required String id,
    @JsonKey(name: 'room_id') required String roomId,
    @JsonKey(name: 'user_id') required String userId,
    required DateTime created,
    required DateTime updated,
  }) = _RoomMember;

  factory RoomMember.fromJson(Map<String, dynamic> json) =>
      _$RoomMemberFromJson(json);
}

/// Model representing messages sent within a room
/// Based on PocketBase messages collection schema
@freezed
sealed class Message with _$Message {
  const Message._();

  const factory Message({
    required String id,
    String? message,
    String? sendBy,
    @JsonKey(name: 'message_type') String? messageType,
    @JsonKey(name: 'voice_message_duration') double? voiceMessageDuration,
    String? replyBy,
    String? replyTo,
    DateTime? createdAt,
    @JsonKey(name: 'reply_message') String? replyMessage,
    @JsonKey(name: 'reply_message_type') String? replyMessageType,
    @JsonKey(name: 'reply_id') String? replyId,
    @JsonKey(name: 'room_id') String? roomId,
    @JsonKey(name: 'message_file') String? messageFile,

    required DateTime created,
    required DateTime updated,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}
