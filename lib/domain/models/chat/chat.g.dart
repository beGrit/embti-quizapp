// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Chat _$ChatFromJson(Map<String, dynamic> json) => _Chat(
  id: json['id'] as String,
  title: json['title'] as String?,
  created: DateTime.parse(json['created'] as String),
  updated: DateTime.parse(json['updated'] as String),
);

Map<String, dynamic> _$ChatToJson(_Chat instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'created': instance.created.toIso8601String(),
  'updated': instance.updated.toIso8601String(),
};

_Room _$RoomFromJson(Map<String, dynamic> json) => _Room(
  id: json['id'] as String,
  name: json['name'] as String?,
  createdBy: json['created_by'] as String?,
  chatId: json['chat_id'] as String?,
  created: DateTime.parse(json['created'] as String),
  updated: DateTime.parse(json['updated'] as String),
  lastMessage: json['last_message'] as String?,
  lastMessageAt: json['last_message_at'] == null
      ? null
      : DateTime.parse(json['last_message_at'] as String),
);

Map<String, dynamic> _$RoomToJson(_Room instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'created_by': instance.createdBy,
  'chat_id': instance.chatId,
  'created': instance.created.toIso8601String(),
  'updated': instance.updated.toIso8601String(),
  'last_message': instance.lastMessage,
  'last_message_at': instance.lastMessageAt?.toIso8601String(),
};

_RoomMember _$RoomMemberFromJson(Map<String, dynamic> json) => _RoomMember(
  id: json['id'] as String,
  roomId: json['room_id'] as String,
  userId: json['user_id'] as String,
  created: DateTime.parse(json['created'] as String),
  updated: DateTime.parse(json['updated'] as String),
);

Map<String, dynamic> _$RoomMemberToJson(_RoomMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'room_id': instance.roomId,
      'user_id': instance.userId,
      'created': instance.created.toIso8601String(),
      'updated': instance.updated.toIso8601String(),
    };

_Message _$MessageFromJson(Map<String, dynamic> json) => _Message(
  id: json['id'] as String,
  message: json['message'] as String?,
  sendBy: json['sendBy'] as String?,
  messageType: json['message_type'] as String?,
  voiceMessageDuration: (json['voice_message_duration'] as num?)?.toDouble(),
  replyBy: json['replyBy'] as String?,
  replyTo: json['replyTo'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  replyMessage: json['reply_message'] as String?,
  replyMessageType: json['reply_message_type'] as String?,
  replyId: json['reply_id'] as String?,
  roomId: json['room_id'] as String?,
  messageFile: json['message_file'] as String?,
  created: DateTime.parse(json['created'] as String),
  updated: DateTime.parse(json['updated'] as String),
);

Map<String, dynamic> _$MessageToJson(_Message instance) => <String, dynamic>{
  'id': instance.id,
  'message': instance.message,
  'sendBy': instance.sendBy,
  'message_type': instance.messageType,
  'voice_message_duration': instance.voiceMessageDuration,
  'replyBy': instance.replyBy,
  'replyTo': instance.replyTo,
  'createdAt': instance.createdAt?.toIso8601String(),
  'reply_message': instance.replyMessage,
  'reply_message_type': instance.replyMessageType,
  'reply_id': instance.replyId,
  'room_id': instance.roomId,
  'message_file': instance.messageFile,
  'created': instance.created.toIso8601String(),
  'updated': instance.updated.toIso8601String(),
};

_Robot _$RobotFromJson(Map<String, dynamic> json) =>
    _Robot(id: json['id'] as String?, key: json['key'] as String?);

Map<String, dynamic> _$RobotToJson(_Robot instance) => <String, dynamic>{
  'id': instance.id,
  'key': instance.key,
};
