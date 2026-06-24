import 'package:emombti/utils/converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_api_model.freezed.dart';
part 'chat_api_model.g.dart';

@freezed
abstract class UserChatFirestoreApiModel with _$UserChatFirestoreApiModel {
  const factory UserChatFirestoreApiModel({
    required String chatId,
    @Default(0) int unreadCount,
    @Default(false) bool isPinned,
    @FirestoreTimestampConverter() required DateTime createdAt,
    @FirestoreTimestampConverter() DateTime? lastMessageSentAt,
    String? lastMessageText,
    String? lastMessageSenderId,
    String? name,
    String? image,
  }) = _UserChatFirestoreApiModel;

  factory UserChatFirestoreApiModel.fromJson(Map<String, dynamic> json) =>
      _$UserChatFirestoreApiModelFromJson(json);
}

@freezed
abstract class ChatLastMessageApiModel with _$ChatLastMessageApiModel {
  const factory ChatLastMessageApiModel({
    required String text,
    required String senderId,
    @FirestoreTimestampConverter() required DateTime sentAt,
  }) = _ChatLastMessageApiModel;

  factory ChatLastMessageApiModel.fromJson(Map<String, dynamic> json) =>
      _$ChatLastMessageApiModelFromJson(json);
}

@freezed
abstract class ChatFirestoreApiModel with _$ChatFirestoreApiModel {
  const factory ChatFirestoreApiModel({
    required String chatId,
    @Default(false) bool isGroup,
    String? chatName,
    String? chatImage,
    @FirestoreTimestampConverter() required DateTime createdAt,
    @Default([]) List<String> members,
    ChatLastMessageApiModel? lastMessage,
  }) = _ChatFirestoreApiModel;

  factory ChatFirestoreApiModel.fromJson(Map<String, dynamic> json) =>
      _$ChatFirestoreApiModelFromJson(json);
}

@freezed
abstract class ChatMessageFirestoreApiModel
    with _$ChatMessageFirestoreApiModel {
  const factory ChatMessageFirestoreApiModel({
    @JsonKey(includeFromJson: false, includeToJson: false) String? id,
    required String messageId,
    required String senderId,
    @Default('text') String type,
    required String content,
    @FirestoreTimestampConverter() required DateTime sentAt,
    String? status,
  }) = _ChatMessageFirestoreApiModel;

  factory ChatMessageFirestoreApiModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFirestoreApiModelFromJson(json);
}

enum MessageChangeApiType { added, modified, removed }

@freezed
sealed class MessageChangeApiModel with _$MessageChangeApiModel {
  const factory MessageChangeApiModel({
    required MessageChangeApiType type,
    required ChatMessageFirestoreApiModel message,
  }) = _MessageChangeApiModel;
}

@freezed
sealed class ChatConnectionApiModel with _$ChatConnectionApiModel {
  const factory ChatConnectionApiModel({required bool isConnected}) =
      _ChatConnectionApiModel;
}

@freezed
abstract class RobotFirestoreApiModel with _$RobotFirestoreApiModel {
  const factory RobotFirestoreApiModel({required String id}) =
      _RobotFirestoreApiModel;

  factory RobotFirestoreApiModel.fromJson(Map<String, dynamic> json) =>
      _$RobotFirestoreApiModelFromJson(json);
}
