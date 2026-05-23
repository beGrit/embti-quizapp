// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  id: json['id'] as String?,
  email: json['email'] as String?,
  name: json['name'] as String?,
  mbtiType: json['mbtiType'] as String?,
  introduce: json['introduce'] as String?,
  avatar: json['avatar'] == null
      ? null
      : AppFile.fromJson(json['avatar'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'name': instance.name,
  'mbtiType': instance.mbtiType,
  'introduce': instance.introduce,
  'avatar': instance.avatar,
};
