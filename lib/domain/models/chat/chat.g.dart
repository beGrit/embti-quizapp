// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Chat _$ChatFromJson(Map<String, dynamic> json) => _Chat(
  id: json['id'] as String,
  name: json['name'] as String?,
  image: json['image'] as String?,
  isGroup: json['isGroup'] as bool? ?? false,
  created: DateTime.parse(json['created'] as String),
  updated: DateTime.parse(json['updated'] as String),
  lastMessage: json['lastMessage'] as String?,
  lastMessageAt: json['lastMessageAt'] == null
      ? null
      : DateTime.parse(json['lastMessageAt'] as String),
  roomMembers:
      (json['roomMembers'] as List<dynamic>?)
          ?.map((e) => ChatMember.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  messages:
      (json['messages'] as List<dynamic>?)
          ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$ChatToJson(_Chat instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'image': instance.image,
  'isGroup': instance.isGroup,
  'created': instance.created.toIso8601String(),
  'updated': instance.updated.toIso8601String(),
  'lastMessage': instance.lastMessage,
  'lastMessageAt': instance.lastMessageAt?.toIso8601String(),
  'roomMembers': instance.roomMembers,
  'messages': instance.messages,
};

_ChatMember _$ChatMemberFromJson(Map<String, dynamic> json) => _ChatMember(
  roomId: json['roomId'] as String,
  userId: json['userId'] as String,
);

Map<String, dynamic> _$ChatMemberToJson(_ChatMember instance) =>
    <String, dynamic>{'roomId': instance.roomId, 'userId': instance.userId};

_Message _$MessageFromJson(Map<String, dynamic> json) => _Message(
  id: json['id'] as String,
  message: json['message'] as String?,
  sendBy: json['sendBy'] as String?,
  messageType: json['messageType'] as String?,
  voiceMessageDuration: (json['voiceMessageDuration'] as num?)?.toDouble(),
  replyBy: json['replyBy'] as String?,
  replyTo: json['replyTo'] as String?,
  status: json['status'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  replyMessage: json['replyMessage'] as String?,
  replyMessageType: json['replyMessageType'] as String?,
  replyId: json['replyId'] as String?,
  chatId: json['chatId'] as String?,
  messageFile: json['messageFile'] as String?,
  created: DateTime.parse(json['created'] as String),
  updated: DateTime.parse(json['updated'] as String),
);

Map<String, dynamic> _$MessageToJson(_Message instance) => <String, dynamic>{
  'id': instance.id,
  'message': instance.message,
  'sendBy': instance.sendBy,
  'messageType': instance.messageType,
  'voiceMessageDuration': instance.voiceMessageDuration,
  'replyBy': instance.replyBy,
  'replyTo': instance.replyTo,
  'status': instance.status,
  'createdAt': instance.createdAt?.toIso8601String(),
  'replyMessage': instance.replyMessage,
  'replyMessageType': instance.replyMessageType,
  'replyId': instance.replyId,
  'chatId': instance.chatId,
  'messageFile': instance.messageFile,
  'created': instance.created.toIso8601String(),
  'updated': instance.updated.toIso8601String(),
};

_Robot _$RobotFromJson(Map<String, dynamic> json) =>
    _Robot(id: json['id'] as String?, key: json['key'] as String?);

Map<String, dynamic> _$RobotToJson(_Robot instance) => <String, dynamic>{
  'id': instance.id,
  'key': instance.key,
};
