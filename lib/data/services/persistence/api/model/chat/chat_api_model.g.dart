// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserChatFirestoreApiModel _$UserChatFirestoreApiModelFromJson(
  Map<String, dynamic> json,
) => _UserChatFirestoreApiModel(
  chatId: json['chatId'] as String,
  unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
  isPinned: json['isPinned'] as bool? ?? false,
  createdAt: const FirestoreTimestampConverter().fromJson(json['createdAt']),
  lastMessageSentAt: const FirestoreTimestampConverter().fromJson(
    json['lastMessageSentAt'],
  ),
  lastMessageText: json['lastMessageText'] as String?,
  lastMessageSenderId: json['lastMessageSenderId'] as String?,
  name: json['name'] as String?,
  image: json['image'] as String?,
);

Map<String, dynamic> _$UserChatFirestoreApiModelToJson(
  _UserChatFirestoreApiModel instance,
) => <String, dynamic>{
  'chatId': instance.chatId,
  'unreadCount': instance.unreadCount,
  'isPinned': instance.isPinned,
  'createdAt': const FirestoreTimestampConverter().toJson(instance.createdAt),
  'lastMessageSentAt': _$JsonConverterToJson<dynamic, DateTime>(
    instance.lastMessageSentAt,
    const FirestoreTimestampConverter().toJson,
  ),
  'lastMessageText': instance.lastMessageText,
  'lastMessageSenderId': instance.lastMessageSenderId,
  'name': instance.name,
  'image': instance.image,
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

_ChatLastMessageApiModel _$ChatLastMessageApiModelFromJson(
  Map<String, dynamic> json,
) => _ChatLastMessageApiModel(
  text: json['text'] as String,
  senderId: json['senderId'] as String,
  sentAt: const FirestoreTimestampConverter().fromJson(json['sentAt']),
);

Map<String, dynamic> _$ChatLastMessageApiModelToJson(
  _ChatLastMessageApiModel instance,
) => <String, dynamic>{
  'text': instance.text,
  'senderId': instance.senderId,
  'sentAt': const FirestoreTimestampConverter().toJson(instance.sentAt),
};

_ChatFirestoreApiModel _$ChatFirestoreApiModelFromJson(
  Map<String, dynamic> json,
) => _ChatFirestoreApiModel(
  chatId: json['chatId'] as String,
  isGroup: json['isGroup'] as bool? ?? false,
  chatName: json['chatName'] as String?,
  chatImage: json['chatImage'] as String?,
  createdAt: const FirestoreTimestampConverter().fromJson(json['createdAt']),
  members:
      (json['members'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  lastMessage: json['lastMessage'] == null
      ? null
      : ChatLastMessageApiModel.fromJson(
          json['lastMessage'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ChatFirestoreApiModelToJson(
  _ChatFirestoreApiModel instance,
) => <String, dynamic>{
  'chatId': instance.chatId,
  'isGroup': instance.isGroup,
  'chatName': instance.chatName,
  'chatImage': instance.chatImage,
  'createdAt': const FirestoreTimestampConverter().toJson(instance.createdAt),
  'members': instance.members,
  'lastMessage': instance.lastMessage,
};

_ChatMessageFirestoreApiModel _$ChatMessageFirestoreApiModelFromJson(
  Map<String, dynamic> json,
) => _ChatMessageFirestoreApiModel(
  messageId: json['messageId'] as String,
  senderId: json['senderId'] as String,
  type: json['type'] as String? ?? 'text',
  content: json['content'] as String,
  sentAt: const FirestoreTimestampConverter().fromJson(json['sentAt']),
  status: json['status'] as String?,
);

Map<String, dynamic> _$ChatMessageFirestoreApiModelToJson(
  _ChatMessageFirestoreApiModel instance,
) => <String, dynamic>{
  'messageId': instance.messageId,
  'senderId': instance.senderId,
  'type': instance.type,
  'content': instance.content,
  'sentAt': const FirestoreTimestampConverter().toJson(instance.sentAt),
  'status': instance.status,
};

_RobotFirestoreApiModel _$RobotFirestoreApiModelFromJson(
  Map<String, dynamic> json,
) => _RobotFirestoreApiModel(id: json['id'] as String);

Map<String, dynamic> _$RobotFirestoreApiModelToJson(
  _RobotFirestoreApiModel instance,
) => <String, dynamic>{'id': instance.id};
