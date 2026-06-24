// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Chat {

 String get id; String? get name; String? get image; bool get isGroup; DateTime get created; DateTime get updated; String? get lastMessage; DateTime? get lastMessageAt; List<ChatMember> get roomMembers; List<Message> get messages;
/// Create a copy of Chat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatCopyWith<Chat> get copyWith => _$ChatCopyWithImpl<Chat>(this as Chat, _$identity);

  /// Serializes this Chat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Chat&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&(identical(other.isGroup, isGroup) || other.isGroup == isGroup)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&const DeepCollectionEquality().equals(other.roomMembers, roomMembers)&&const DeepCollectionEquality().equals(other.messages, messages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,image,isGroup,created,updated,lastMessage,lastMessageAt,const DeepCollectionEquality().hash(roomMembers),const DeepCollectionEquality().hash(messages));

@override
String toString() {
  return 'Chat(id: $id, name: $name, image: $image, isGroup: $isGroup, created: $created, updated: $updated, lastMessage: $lastMessage, lastMessageAt: $lastMessageAt, roomMembers: $roomMembers, messages: $messages)';
}


}

/// @nodoc
abstract mixin class $ChatCopyWith<$Res>  {
  factory $ChatCopyWith(Chat value, $Res Function(Chat) _then) = _$ChatCopyWithImpl;
@useResult
$Res call({
 String id, String? name, String? image, bool isGroup, DateTime created, DateTime updated, String? lastMessage, DateTime? lastMessageAt, List<ChatMember> roomMembers, List<Message> messages
});




}
/// @nodoc
class _$ChatCopyWithImpl<$Res>
    implements $ChatCopyWith<$Res> {
  _$ChatCopyWithImpl(this._self, this._then);

  final Chat _self;
  final $Res Function(Chat) _then;

/// Create a copy of Chat
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? image = freezed,Object? isGroup = null,Object? created = null,Object? updated = null,Object? lastMessage = freezed,Object? lastMessageAt = freezed,Object? roomMembers = null,Object? messages = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,isGroup: null == isGroup ? _self.isGroup : isGroup // ignore: cast_nullable_to_non_nullable
as bool,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String?,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime?,roomMembers: null == roomMembers ? _self.roomMembers : roomMembers // ignore: cast_nullable_to_non_nullable
as List<ChatMember>,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<Message>,
  ));
}

}


/// Adds pattern-matching-related methods to [Chat].
extension ChatPatterns on Chat {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Chat value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Chat() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Chat value)  $default,){
final _that = this;
switch (_that) {
case _Chat():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Chat value)?  $default,){
final _that = this;
switch (_that) {
case _Chat() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? name,  String? image,  bool isGroup,  DateTime created,  DateTime updated,  String? lastMessage,  DateTime? lastMessageAt,  List<ChatMember> roomMembers,  List<Message> messages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Chat() when $default != null:
return $default(_that.id,_that.name,_that.image,_that.isGroup,_that.created,_that.updated,_that.lastMessage,_that.lastMessageAt,_that.roomMembers,_that.messages);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? name,  String? image,  bool isGroup,  DateTime created,  DateTime updated,  String? lastMessage,  DateTime? lastMessageAt,  List<ChatMember> roomMembers,  List<Message> messages)  $default,) {final _that = this;
switch (_that) {
case _Chat():
return $default(_that.id,_that.name,_that.image,_that.isGroup,_that.created,_that.updated,_that.lastMessage,_that.lastMessageAt,_that.roomMembers,_that.messages);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? name,  String? image,  bool isGroup,  DateTime created,  DateTime updated,  String? lastMessage,  DateTime? lastMessageAt,  List<ChatMember> roomMembers,  List<Message> messages)?  $default,) {final _that = this;
switch (_that) {
case _Chat() when $default != null:
return $default(_that.id,_that.name,_that.image,_that.isGroup,_that.created,_that.updated,_that.lastMessage,_that.lastMessageAt,_that.roomMembers,_that.messages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Chat extends Chat {
  const _Chat({required this.id, this.name, this.image, this.isGroup = false, required this.created, required this.updated, this.lastMessage, this.lastMessageAt, final  List<ChatMember> roomMembers = const [], final  List<Message> messages = const []}): _roomMembers = roomMembers,_messages = messages,super._();
  factory _Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

@override final  String id;
@override final  String? name;
@override final  String? image;
@override@JsonKey() final  bool isGroup;
@override final  DateTime created;
@override final  DateTime updated;
@override final  String? lastMessage;
@override final  DateTime? lastMessageAt;
 final  List<ChatMember> _roomMembers;
@override@JsonKey() List<ChatMember> get roomMembers {
  if (_roomMembers is EqualUnmodifiableListView) return _roomMembers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roomMembers);
}

 final  List<Message> _messages;
@override@JsonKey() List<Message> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}


/// Create a copy of Chat
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatCopyWith<_Chat> get copyWith => __$ChatCopyWithImpl<_Chat>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Chat&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&(identical(other.isGroup, isGroup) || other.isGroup == isGroup)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt)&&const DeepCollectionEquality().equals(other._roomMembers, _roomMembers)&&const DeepCollectionEquality().equals(other._messages, _messages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,image,isGroup,created,updated,lastMessage,lastMessageAt,const DeepCollectionEquality().hash(_roomMembers),const DeepCollectionEquality().hash(_messages));

@override
String toString() {
  return 'Chat(id: $id, name: $name, image: $image, isGroup: $isGroup, created: $created, updated: $updated, lastMessage: $lastMessage, lastMessageAt: $lastMessageAt, roomMembers: $roomMembers, messages: $messages)';
}


}

/// @nodoc
abstract mixin class _$ChatCopyWith<$Res> implements $ChatCopyWith<$Res> {
  factory _$ChatCopyWith(_Chat value, $Res Function(_Chat) _then) = __$ChatCopyWithImpl;
@override @useResult
$Res call({
 String id, String? name, String? image, bool isGroup, DateTime created, DateTime updated, String? lastMessage, DateTime? lastMessageAt, List<ChatMember> roomMembers, List<Message> messages
});




}
/// @nodoc
class __$ChatCopyWithImpl<$Res>
    implements _$ChatCopyWith<$Res> {
  __$ChatCopyWithImpl(this._self, this._then);

  final _Chat _self;
  final $Res Function(_Chat) _then;

/// Create a copy of Chat
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? image = freezed,Object? isGroup = null,Object? created = null,Object? updated = null,Object? lastMessage = freezed,Object? lastMessageAt = freezed,Object? roomMembers = null,Object? messages = null,}) {
  return _then(_Chat(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,isGroup: null == isGroup ? _self.isGroup : isGroup // ignore: cast_nullable_to_non_nullable
as bool,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String?,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime?,roomMembers: null == roomMembers ? _self._roomMembers : roomMembers // ignore: cast_nullable_to_non_nullable
as List<ChatMember>,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<Message>,
  ));
}


}


/// @nodoc
mixin _$ChatMember {

 String get roomId; String get userId;
/// Create a copy of ChatMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMemberCopyWith<ChatMember> get copyWith => _$ChatMemberCopyWithImpl<ChatMember>(this as ChatMember, _$identity);

  /// Serializes this ChatMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMember&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,roomId,userId);

@override
String toString() {
  return 'ChatMember(roomId: $roomId, userId: $userId)';
}


}

/// @nodoc
abstract mixin class $ChatMemberCopyWith<$Res>  {
  factory $ChatMemberCopyWith(ChatMember value, $Res Function(ChatMember) _then) = _$ChatMemberCopyWithImpl;
@useResult
$Res call({
 String roomId, String userId
});




}
/// @nodoc
class _$ChatMemberCopyWithImpl<$Res>
    implements $ChatMemberCopyWith<$Res> {
  _$ChatMemberCopyWithImpl(this._self, this._then);

  final ChatMember _self;
  final $Res Function(ChatMember) _then;

/// Create a copy of ChatMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? roomId = null,Object? userId = null,}) {
  return _then(_self.copyWith(
roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMember].
extension ChatMemberPatterns on ChatMember {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMember() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMember value)  $default,){
final _that = this;
switch (_that) {
case _ChatMember():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMember value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMember() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String roomId,  String userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMember() when $default != null:
return $default(_that.roomId,_that.userId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String roomId,  String userId)  $default,) {final _that = this;
switch (_that) {
case _ChatMember():
return $default(_that.roomId,_that.userId);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String roomId,  String userId)?  $default,) {final _that = this;
switch (_that) {
case _ChatMember() when $default != null:
return $default(_that.roomId,_that.userId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatMember extends ChatMember {
  const _ChatMember({required this.roomId, required this.userId}): super._();
  factory _ChatMember.fromJson(Map<String, dynamic> json) => _$ChatMemberFromJson(json);

@override final  String roomId;
@override final  String userId;

/// Create a copy of ChatMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMemberCopyWith<_ChatMember> get copyWith => __$ChatMemberCopyWithImpl<_ChatMember>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMemberToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMember&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,roomId,userId);

@override
String toString() {
  return 'ChatMember(roomId: $roomId, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$ChatMemberCopyWith<$Res> implements $ChatMemberCopyWith<$Res> {
  factory _$ChatMemberCopyWith(_ChatMember value, $Res Function(_ChatMember) _then) = __$ChatMemberCopyWithImpl;
@override @useResult
$Res call({
 String roomId, String userId
});




}
/// @nodoc
class __$ChatMemberCopyWithImpl<$Res>
    implements _$ChatMemberCopyWith<$Res> {
  __$ChatMemberCopyWithImpl(this._self, this._then);

  final _ChatMember _self;
  final $Res Function(_ChatMember) _then;

/// Create a copy of ChatMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? roomId = null,Object? userId = null,}) {
  return _then(_ChatMember(
roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$Message {

 String get id; String? get message; String? get sendBy; String? get messageType; double? get voiceMessageDuration; String? get replyBy; String? get replyTo; String? get status; DateTime? get createdAt; String? get replyMessage; String? get replyMessageType; String? get replyId; String? get chatId; String? get messageFile; DateTime get created; DateTime get updated;
/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageCopyWith<Message> get copyWith => _$MessageCopyWithImpl<Message>(this as Message, _$identity);

  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Message&&(identical(other.id, id) || other.id == id)&&(identical(other.message, message) || other.message == message)&&(identical(other.sendBy, sendBy) || other.sendBy == sendBy)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.voiceMessageDuration, voiceMessageDuration) || other.voiceMessageDuration == voiceMessageDuration)&&(identical(other.replyBy, replyBy) || other.replyBy == replyBy)&&(identical(other.replyTo, replyTo) || other.replyTo == replyTo)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.replyMessage, replyMessage) || other.replyMessage == replyMessage)&&(identical(other.replyMessageType, replyMessageType) || other.replyMessageType == replyMessageType)&&(identical(other.replyId, replyId) || other.replyId == replyId)&&(identical(other.chatId, chatId) || other.chatId == chatId)&&(identical(other.messageFile, messageFile) || other.messageFile == messageFile)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,message,sendBy,messageType,voiceMessageDuration,replyBy,replyTo,status,createdAt,replyMessage,replyMessageType,replyId,chatId,messageFile,created,updated);

@override
String toString() {
  return 'Message(id: $id, message: $message, sendBy: $sendBy, messageType: $messageType, voiceMessageDuration: $voiceMessageDuration, replyBy: $replyBy, replyTo: $replyTo, status: $status, createdAt: $createdAt, replyMessage: $replyMessage, replyMessageType: $replyMessageType, replyId: $replyId, chatId: $chatId, messageFile: $messageFile, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class $MessageCopyWith<$Res>  {
  factory $MessageCopyWith(Message value, $Res Function(Message) _then) = _$MessageCopyWithImpl;
@useResult
$Res call({
 String id, String? message, String? sendBy, String? messageType, double? voiceMessageDuration, String? replyBy, String? replyTo, String? status, DateTime? createdAt, String? replyMessage, String? replyMessageType, String? replyId, String? chatId, String? messageFile, DateTime created, DateTime updated
});




}
/// @nodoc
class _$MessageCopyWithImpl<$Res>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._self, this._then);

  final Message _self;
  final $Res Function(Message) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? message = freezed,Object? sendBy = freezed,Object? messageType = freezed,Object? voiceMessageDuration = freezed,Object? replyBy = freezed,Object? replyTo = freezed,Object? status = freezed,Object? createdAt = freezed,Object? replyMessage = freezed,Object? replyMessageType = freezed,Object? replyId = freezed,Object? chatId = freezed,Object? messageFile = freezed,Object? created = null,Object? updated = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,sendBy: freezed == sendBy ? _self.sendBy : sendBy // ignore: cast_nullable_to_non_nullable
as String?,messageType: freezed == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as String?,voiceMessageDuration: freezed == voiceMessageDuration ? _self.voiceMessageDuration : voiceMessageDuration // ignore: cast_nullable_to_non_nullable
as double?,replyBy: freezed == replyBy ? _self.replyBy : replyBy // ignore: cast_nullable_to_non_nullable
as String?,replyTo: freezed == replyTo ? _self.replyTo : replyTo // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,replyMessage: freezed == replyMessage ? _self.replyMessage : replyMessage // ignore: cast_nullable_to_non_nullable
as String?,replyMessageType: freezed == replyMessageType ? _self.replyMessageType : replyMessageType // ignore: cast_nullable_to_non_nullable
as String?,replyId: freezed == replyId ? _self.replyId : replyId // ignore: cast_nullable_to_non_nullable
as String?,chatId: freezed == chatId ? _self.chatId : chatId // ignore: cast_nullable_to_non_nullable
as String?,messageFile: freezed == messageFile ? _self.messageFile : messageFile // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [Message].
extension MessagePatterns on Message {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Message value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Message() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Message value)  $default,){
final _that = this;
switch (_that) {
case _Message():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Message value)?  $default,){
final _that = this;
switch (_that) {
case _Message() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? message,  String? sendBy,  String? messageType,  double? voiceMessageDuration,  String? replyBy,  String? replyTo,  String? status,  DateTime? createdAt,  String? replyMessage,  String? replyMessageType,  String? replyId,  String? chatId,  String? messageFile,  DateTime created,  DateTime updated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Message() when $default != null:
return $default(_that.id,_that.message,_that.sendBy,_that.messageType,_that.voiceMessageDuration,_that.replyBy,_that.replyTo,_that.status,_that.createdAt,_that.replyMessage,_that.replyMessageType,_that.replyId,_that.chatId,_that.messageFile,_that.created,_that.updated);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? message,  String? sendBy,  String? messageType,  double? voiceMessageDuration,  String? replyBy,  String? replyTo,  String? status,  DateTime? createdAt,  String? replyMessage,  String? replyMessageType,  String? replyId,  String? chatId,  String? messageFile,  DateTime created,  DateTime updated)  $default,) {final _that = this;
switch (_that) {
case _Message():
return $default(_that.id,_that.message,_that.sendBy,_that.messageType,_that.voiceMessageDuration,_that.replyBy,_that.replyTo,_that.status,_that.createdAt,_that.replyMessage,_that.replyMessageType,_that.replyId,_that.chatId,_that.messageFile,_that.created,_that.updated);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? message,  String? sendBy,  String? messageType,  double? voiceMessageDuration,  String? replyBy,  String? replyTo,  String? status,  DateTime? createdAt,  String? replyMessage,  String? replyMessageType,  String? replyId,  String? chatId,  String? messageFile,  DateTime created,  DateTime updated)?  $default,) {final _that = this;
switch (_that) {
case _Message() when $default != null:
return $default(_that.id,_that.message,_that.sendBy,_that.messageType,_that.voiceMessageDuration,_that.replyBy,_that.replyTo,_that.status,_that.createdAt,_that.replyMessage,_that.replyMessageType,_that.replyId,_that.chatId,_that.messageFile,_that.created,_that.updated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Message extends Message {
  const _Message({required this.id, this.message, this.sendBy, this.messageType, this.voiceMessageDuration, this.replyBy, this.replyTo, this.status, this.createdAt, this.replyMessage, this.replyMessageType, this.replyId, this.chatId, this.messageFile, required this.created, required this.updated}): super._();
  factory _Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

@override final  String id;
@override final  String? message;
@override final  String? sendBy;
@override final  String? messageType;
@override final  double? voiceMessageDuration;
@override final  String? replyBy;
@override final  String? replyTo;
@override final  String? status;
@override final  DateTime? createdAt;
@override final  String? replyMessage;
@override final  String? replyMessageType;
@override final  String? replyId;
@override final  String? chatId;
@override final  String? messageFile;
@override final  DateTime created;
@override final  DateTime updated;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageCopyWith<_Message> get copyWith => __$MessageCopyWithImpl<_Message>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Message&&(identical(other.id, id) || other.id == id)&&(identical(other.message, message) || other.message == message)&&(identical(other.sendBy, sendBy) || other.sendBy == sendBy)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.voiceMessageDuration, voiceMessageDuration) || other.voiceMessageDuration == voiceMessageDuration)&&(identical(other.replyBy, replyBy) || other.replyBy == replyBy)&&(identical(other.replyTo, replyTo) || other.replyTo == replyTo)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.replyMessage, replyMessage) || other.replyMessage == replyMessage)&&(identical(other.replyMessageType, replyMessageType) || other.replyMessageType == replyMessageType)&&(identical(other.replyId, replyId) || other.replyId == replyId)&&(identical(other.chatId, chatId) || other.chatId == chatId)&&(identical(other.messageFile, messageFile) || other.messageFile == messageFile)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,message,sendBy,messageType,voiceMessageDuration,replyBy,replyTo,status,createdAt,replyMessage,replyMessageType,replyId,chatId,messageFile,created,updated);

@override
String toString() {
  return 'Message(id: $id, message: $message, sendBy: $sendBy, messageType: $messageType, voiceMessageDuration: $voiceMessageDuration, replyBy: $replyBy, replyTo: $replyTo, status: $status, createdAt: $createdAt, replyMessage: $replyMessage, replyMessageType: $replyMessageType, replyId: $replyId, chatId: $chatId, messageFile: $messageFile, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class _$MessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$MessageCopyWith(_Message value, $Res Function(_Message) _then) = __$MessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String? message, String? sendBy, String? messageType, double? voiceMessageDuration, String? replyBy, String? replyTo, String? status, DateTime? createdAt, String? replyMessage, String? replyMessageType, String? replyId, String? chatId, String? messageFile, DateTime created, DateTime updated
});




}
/// @nodoc
class __$MessageCopyWithImpl<$Res>
    implements _$MessageCopyWith<$Res> {
  __$MessageCopyWithImpl(this._self, this._then);

  final _Message _self;
  final $Res Function(_Message) _then;

/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? message = freezed,Object? sendBy = freezed,Object? messageType = freezed,Object? voiceMessageDuration = freezed,Object? replyBy = freezed,Object? replyTo = freezed,Object? status = freezed,Object? createdAt = freezed,Object? replyMessage = freezed,Object? replyMessageType = freezed,Object? replyId = freezed,Object? chatId = freezed,Object? messageFile = freezed,Object? created = null,Object? updated = null,}) {
  return _then(_Message(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,sendBy: freezed == sendBy ? _self.sendBy : sendBy // ignore: cast_nullable_to_non_nullable
as String?,messageType: freezed == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as String?,voiceMessageDuration: freezed == voiceMessageDuration ? _self.voiceMessageDuration : voiceMessageDuration // ignore: cast_nullable_to_non_nullable
as double?,replyBy: freezed == replyBy ? _self.replyBy : replyBy // ignore: cast_nullable_to_non_nullable
as String?,replyTo: freezed == replyTo ? _self.replyTo : replyTo // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,replyMessage: freezed == replyMessage ? _self.replyMessage : replyMessage // ignore: cast_nullable_to_non_nullable
as String?,replyMessageType: freezed == replyMessageType ? _self.replyMessageType : replyMessageType // ignore: cast_nullable_to_non_nullable
as String?,replyId: freezed == replyId ? _self.replyId : replyId // ignore: cast_nullable_to_non_nullable
as String?,chatId: freezed == chatId ? _self.chatId : chatId // ignore: cast_nullable_to_non_nullable
as String?,messageFile: freezed == messageFile ? _self.messageFile : messageFile // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$Robot {

 String? get id; String? get key;
/// Create a copy of Robot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RobotCopyWith<Robot> get copyWith => _$RobotCopyWithImpl<Robot>(this as Robot, _$identity);

  /// Serializes this Robot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Robot&&(identical(other.id, id) || other.id == id)&&(identical(other.key, key) || other.key == key));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,key);

@override
String toString() {
  return 'Robot(id: $id, key: $key)';
}


}

/// @nodoc
abstract mixin class $RobotCopyWith<$Res>  {
  factory $RobotCopyWith(Robot value, $Res Function(Robot) _then) = _$RobotCopyWithImpl;
@useResult
$Res call({
 String? id, String? key
});




}
/// @nodoc
class _$RobotCopyWithImpl<$Res>
    implements $RobotCopyWith<$Res> {
  _$RobotCopyWithImpl(this._self, this._then);

  final Robot _self;
  final $Res Function(Robot) _then;

/// Create a copy of Robot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? key = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,key: freezed == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Robot].
extension RobotPatterns on Robot {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Robot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Robot() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Robot value)  $default,){
final _that = this;
switch (_that) {
case _Robot():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Robot value)?  $default,){
final _that = this;
switch (_that) {
case _Robot() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? key)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Robot() when $default != null:
return $default(_that.id,_that.key);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? key)  $default,) {final _that = this;
switch (_that) {
case _Robot():
return $default(_that.id,_that.key);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? key)?  $default,) {final _that = this;
switch (_that) {
case _Robot() when $default != null:
return $default(_that.id,_that.key);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Robot extends Robot {
  const _Robot({this.id, this.key}): super._();
  factory _Robot.fromJson(Map<String, dynamic> json) => _$RobotFromJson(json);

@override final  String? id;
@override final  String? key;

/// Create a copy of Robot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RobotCopyWith<_Robot> get copyWith => __$RobotCopyWithImpl<_Robot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RobotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Robot&&(identical(other.id, id) || other.id == id)&&(identical(other.key, key) || other.key == key));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,key);

@override
String toString() {
  return 'Robot(id: $id, key: $key)';
}


}

/// @nodoc
abstract mixin class _$RobotCopyWith<$Res> implements $RobotCopyWith<$Res> {
  factory _$RobotCopyWith(_Robot value, $Res Function(_Robot) _then) = __$RobotCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? key
});




}
/// @nodoc
class __$RobotCopyWithImpl<$Res>
    implements _$RobotCopyWith<$Res> {
  __$RobotCopyWithImpl(this._self, this._then);

  final _Robot _self;
  final $Res Function(_Robot) _then;

/// Create a copy of Robot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? key = freezed,}) {
  return _then(_Robot(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,key: freezed == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
