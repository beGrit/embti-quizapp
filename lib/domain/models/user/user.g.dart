// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: json['id'] as String,
  email: json['email'] as String,
  emailVisibility: json['emailVisibility'] as bool,
  verified: json['verified'] as bool,
  name: json['name'] as String?,
  avatar: json['avatar'] as String?,
  created: DateTime.parse(json['created'] as String),
  updated: DateTime.parse(json['updated'] as String),
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'emailVisibility': instance.emailVisibility,
  'verified': instance.verified,
  'name': instance.name,
  'avatar': instance.avatar,
  'created': instance.created.toIso8601String(),
  'updated': instance.updated.toIso8601String(),
};
