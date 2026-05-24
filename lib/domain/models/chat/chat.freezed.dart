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

 String get id; String? get title; DateTime get created; DateTime get updated;
/// Create a copy of Chat
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatCopyWith<Chat> get copyWith => _$ChatCopyWithImpl<Chat>(this as Chat, _$identity);

  /// Serializes this Chat to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Chat&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,created,updated);

@override
String toString() {
  return 'Chat(id: $id, title: $title, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class $ChatCopyWith<$Res>  {
  factory $ChatCopyWith(Chat value, $Res Function(Chat) _then) = _$ChatCopyWithImpl;
@useResult
$Res call({
 String id, String? title, DateTime created, DateTime updated
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = freezed,Object? created = null,Object? updated = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? title,  DateTime created,  DateTime updated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Chat() when $default != null:
return $default(_that.id,_that.title,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? title,  DateTime created,  DateTime updated)  $default,) {final _that = this;
switch (_that) {
case _Chat():
return $default(_that.id,_that.title,_that.created,_that.updated);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? title,  DateTime created,  DateTime updated)?  $default,) {final _that = this;
switch (_that) {
case _Chat() when $default != null:
return $default(_that.id,_that.title,_that.created,_that.updated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Chat extends Chat {
  const _Chat({required this.id, this.title, required this.created, required this.updated}): super._();
  factory _Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

@override final  String id;
@override final  String? title;
@override final  DateTime created;
@override final  DateTime updated;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Chat&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,created,updated);

@override
String toString() {
  return 'Chat(id: $id, title: $title, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class _$ChatCopyWith<$Res> implements $ChatCopyWith<$Res> {
  factory _$ChatCopyWith(_Chat value, $Res Function(_Chat) _then) = __$ChatCopyWithImpl;
@override @useResult
$Res call({
 String id, String? title, DateTime created, DateTime updated
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = freezed,Object? created = null,Object? updated = null,}) {
  return _then(_Chat(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$Room {

 String get id; String? get name;@JsonKey(name: 'created_by') String? get createdBy;@JsonKey(name: 'chat_id') String? get chatId; DateTime get created; DateTime get updated;@JsonKey(name: 'last_message') String? get lastMessage;@JsonKey(name: 'last_message_at') DateTime? get lastMessageAt;
/// Create a copy of Room
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoomCopyWith<Room> get copyWith => _$RoomCopyWithImpl<Room>(this as Room, _$identity);

  /// Serializes this Room to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Room&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.chatId, chatId) || other.chatId == chatId)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,createdBy,chatId,created,updated,lastMessage,lastMessageAt);

@override
String toString() {
  return 'Room(id: $id, name: $name, createdBy: $createdBy, chatId: $chatId, created: $created, updated: $updated, lastMessage: $lastMessage, lastMessageAt: $lastMessageAt)';
}


}

/// @nodoc
abstract mixin class $RoomCopyWith<$Res>  {
  factory $RoomCopyWith(Room value, $Res Function(Room) _then) = _$RoomCopyWithImpl;
@useResult
$Res call({
 String id, String? name,@JsonKey(name: 'created_by') String? createdBy,@JsonKey(name: 'chat_id') String? chatId, DateTime created, DateTime updated,@JsonKey(name: 'last_message') String? lastMessage,@JsonKey(name: 'last_message_at') DateTime? lastMessageAt
});




}
/// @nodoc
class _$RoomCopyWithImpl<$Res>
    implements $RoomCopyWith<$Res> {
  _$RoomCopyWithImpl(this._self, this._then);

  final Room _self;
  final $Res Function(Room) _then;

/// Create a copy of Room
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? createdBy = freezed,Object? chatId = freezed,Object? created = null,Object? updated = null,Object? lastMessage = freezed,Object? lastMessageAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,chatId: freezed == chatId ? _self.chatId : chatId // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String?,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Room].
extension RoomPatterns on Room {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Room value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Room() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Room value)  $default,){
final _that = this;
switch (_that) {
case _Room():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Room value)?  $default,){
final _that = this;
switch (_that) {
case _Room() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? name, @JsonKey(name: 'created_by')  String? createdBy, @JsonKey(name: 'chat_id')  String? chatId,  DateTime created,  DateTime updated, @JsonKey(name: 'last_message')  String? lastMessage, @JsonKey(name: 'last_message_at')  DateTime? lastMessageAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Room() when $default != null:
return $default(_that.id,_that.name,_that.createdBy,_that.chatId,_that.created,_that.updated,_that.lastMessage,_that.lastMessageAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? name, @JsonKey(name: 'created_by')  String? createdBy, @JsonKey(name: 'chat_id')  String? chatId,  DateTime created,  DateTime updated, @JsonKey(name: 'last_message')  String? lastMessage, @JsonKey(name: 'last_message_at')  DateTime? lastMessageAt)  $default,) {final _that = this;
switch (_that) {
case _Room():
return $default(_that.id,_that.name,_that.createdBy,_that.chatId,_that.created,_that.updated,_that.lastMessage,_that.lastMessageAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? name, @JsonKey(name: 'created_by')  String? createdBy, @JsonKey(name: 'chat_id')  String? chatId,  DateTime created,  DateTime updated, @JsonKey(name: 'last_message')  String? lastMessage, @JsonKey(name: 'last_message_at')  DateTime? lastMessageAt)?  $default,) {final _that = this;
switch (_that) {
case _Room() when $default != null:
return $default(_that.id,_that.name,_that.createdBy,_that.chatId,_that.created,_that.updated,_that.lastMessage,_that.lastMessageAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Room extends Room {
  const _Room({required this.id, this.name, @JsonKey(name: 'created_by') this.createdBy, @JsonKey(name: 'chat_id') this.chatId, required this.created, required this.updated, @JsonKey(name: 'last_message') this.lastMessage, @JsonKey(name: 'last_message_at') this.lastMessageAt}): super._();
  factory _Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

@override final  String id;
@override final  String? name;
@override@JsonKey(name: 'created_by') final  String? createdBy;
@override@JsonKey(name: 'chat_id') final  String? chatId;
@override final  DateTime created;
@override final  DateTime updated;
@override@JsonKey(name: 'last_message') final  String? lastMessage;
@override@JsonKey(name: 'last_message_at') final  DateTime? lastMessageAt;

/// Create a copy of Room
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoomCopyWith<_Room> get copyWith => __$RoomCopyWithImpl<_Room>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoomToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Room&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.chatId, chatId) || other.chatId == chatId)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage)&&(identical(other.lastMessageAt, lastMessageAt) || other.lastMessageAt == lastMessageAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,createdBy,chatId,created,updated,lastMessage,lastMessageAt);

@override
String toString() {
  return 'Room(id: $id, name: $name, createdBy: $createdBy, chatId: $chatId, created: $created, updated: $updated, lastMessage: $lastMessage, lastMessageAt: $lastMessageAt)';
}


}

/// @nodoc
abstract mixin class _$RoomCopyWith<$Res> implements $RoomCopyWith<$Res> {
  factory _$RoomCopyWith(_Room value, $Res Function(_Room) _then) = __$RoomCopyWithImpl;
@override @useResult
$Res call({
 String id, String? name,@JsonKey(name: 'created_by') String? createdBy,@JsonKey(name: 'chat_id') String? chatId, DateTime created, DateTime updated,@JsonKey(name: 'last_message') String? lastMessage,@JsonKey(name: 'last_message_at') DateTime? lastMessageAt
});




}
/// @nodoc
class __$RoomCopyWithImpl<$Res>
    implements _$RoomCopyWith<$Res> {
  __$RoomCopyWithImpl(this._self, this._then);

  final _Room _self;
  final $Res Function(_Room) _then;

/// Create a copy of Room
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? createdBy = freezed,Object? chatId = freezed,Object? created = null,Object? updated = null,Object? lastMessage = freezed,Object? lastMessageAt = freezed,}) {
  return _then(_Room(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,chatId: freezed == chatId ? _self.chatId : chatId // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as String?,lastMessageAt: freezed == lastMessageAt ? _self.lastMessageAt : lastMessageAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$RoomMember {

 String get id;@JsonKey(name: 'room_id') String get roomId;@JsonKey(name: 'user_id') String get userId; DateTime get created; DateTime get updated;
/// Create a copy of RoomMember
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoomMemberCopyWith<RoomMember> get copyWith => _$RoomMemberCopyWithImpl<RoomMember>(this as RoomMember, _$identity);

  /// Serializes this RoomMember to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoomMember&&(identical(other.id, id) || other.id == id)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,roomId,userId,created,updated);

@override
String toString() {
  return 'RoomMember(id: $id, roomId: $roomId, userId: $userId, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class $RoomMemberCopyWith<$Res>  {
  factory $RoomMemberCopyWith(RoomMember value, $Res Function(RoomMember) _then) = _$RoomMemberCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'room_id') String roomId,@JsonKey(name: 'user_id') String userId, DateTime created, DateTime updated
});




}
/// @nodoc
class _$RoomMemberCopyWithImpl<$Res>
    implements $RoomMemberCopyWith<$Res> {
  _$RoomMemberCopyWithImpl(this._self, this._then);

  final RoomMember _self;
  final $Res Function(RoomMember) _then;

/// Create a copy of RoomMember
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? roomId = null,Object? userId = null,Object? created = null,Object? updated = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [RoomMember].
extension RoomMemberPatterns on RoomMember {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoomMember value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoomMember() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoomMember value)  $default,){
final _that = this;
switch (_that) {
case _RoomMember():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoomMember value)?  $default,){
final _that = this;
switch (_that) {
case _RoomMember() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'room_id')  String roomId, @JsonKey(name: 'user_id')  String userId,  DateTime created,  DateTime updated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoomMember() when $default != null:
return $default(_that.id,_that.roomId,_that.userId,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'room_id')  String roomId, @JsonKey(name: 'user_id')  String userId,  DateTime created,  DateTime updated)  $default,) {final _that = this;
switch (_that) {
case _RoomMember():
return $default(_that.id,_that.roomId,_that.userId,_that.created,_that.updated);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'room_id')  String roomId, @JsonKey(name: 'user_id')  String userId,  DateTime created,  DateTime updated)?  $default,) {final _that = this;
switch (_that) {
case _RoomMember() when $default != null:
return $default(_that.id,_that.roomId,_that.userId,_that.created,_that.updated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoomMember extends RoomMember {
  const _RoomMember({required this.id, @JsonKey(name: 'room_id') required this.roomId, @JsonKey(name: 'user_id') required this.userId, required this.created, required this.updated}): super._();
  factory _RoomMember.fromJson(Map<String, dynamic> json) => _$RoomMemberFromJson(json);

@override final  String id;
@override@JsonKey(name: 'room_id') final  String roomId;
@override@JsonKey(name: 'user_id') final  String userId;
@override final  DateTime created;
@override final  DateTime updated;

/// Create a copy of RoomMember
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoomMemberCopyWith<_RoomMember> get copyWith => __$RoomMemberCopyWithImpl<_RoomMember>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoomMemberToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoomMember&&(identical(other.id, id) || other.id == id)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,roomId,userId,created,updated);

@override
String toString() {
  return 'RoomMember(id: $id, roomId: $roomId, userId: $userId, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class _$RoomMemberCopyWith<$Res> implements $RoomMemberCopyWith<$Res> {
  factory _$RoomMemberCopyWith(_RoomMember value, $Res Function(_RoomMember) _then) = __$RoomMemberCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'room_id') String roomId,@JsonKey(name: 'user_id') String userId, DateTime created, DateTime updated
});




}
/// @nodoc
class __$RoomMemberCopyWithImpl<$Res>
    implements _$RoomMemberCopyWith<$Res> {
  __$RoomMemberCopyWithImpl(this._self, this._then);

  final _RoomMember _self;
  final $Res Function(_RoomMember) _then;

/// Create a copy of RoomMember
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? roomId = null,Object? userId = null,Object? created = null,Object? updated = null,}) {
  return _then(_RoomMember(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$Message {

 String get id; String? get message; String? get sendBy;@JsonKey(name: 'message_type') String? get messageType;@JsonKey(name: 'voice_message_duration') double? get voiceMessageDuration; String? get replyBy; String? get replyTo; DateTime? get createdAt;@JsonKey(name: 'reply_message') String? get replyMessage;@JsonKey(name: 'reply_message_type') String? get replyMessageType;@JsonKey(name: 'reply_id') String? get replyId;@JsonKey(name: 'room_id') String? get roomId;@JsonKey(name: 'message_file') String? get messageFile; DateTime get created; DateTime get updated;
/// Create a copy of Message
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageCopyWith<Message> get copyWith => _$MessageCopyWithImpl<Message>(this as Message, _$identity);

  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Message&&(identical(other.id, id) || other.id == id)&&(identical(other.message, message) || other.message == message)&&(identical(other.sendBy, sendBy) || other.sendBy == sendBy)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.voiceMessageDuration, voiceMessageDuration) || other.voiceMessageDuration == voiceMessageDuration)&&(identical(other.replyBy, replyBy) || other.replyBy == replyBy)&&(identical(other.replyTo, replyTo) || other.replyTo == replyTo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.replyMessage, replyMessage) || other.replyMessage == replyMessage)&&(identical(other.replyMessageType, replyMessageType) || other.replyMessageType == replyMessageType)&&(identical(other.replyId, replyId) || other.replyId == replyId)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.messageFile, messageFile) || other.messageFile == messageFile)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,message,sendBy,messageType,voiceMessageDuration,replyBy,replyTo,createdAt,replyMessage,replyMessageType,replyId,roomId,messageFile,created,updated);

@override
String toString() {
  return 'Message(id: $id, message: $message, sendBy: $sendBy, messageType: $messageType, voiceMessageDuration: $voiceMessageDuration, replyBy: $replyBy, replyTo: $replyTo, createdAt: $createdAt, replyMessage: $replyMessage, replyMessageType: $replyMessageType, replyId: $replyId, roomId: $roomId, messageFile: $messageFile, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class $MessageCopyWith<$Res>  {
  factory $MessageCopyWith(Message value, $Res Function(Message) _then) = _$MessageCopyWithImpl;
@useResult
$Res call({
 String id, String? message, String? sendBy,@JsonKey(name: 'message_type') String? messageType,@JsonKey(name: 'voice_message_duration') double? voiceMessageDuration, String? replyBy, String? replyTo, DateTime? createdAt,@JsonKey(name: 'reply_message') String? replyMessage,@JsonKey(name: 'reply_message_type') String? replyMessageType,@JsonKey(name: 'reply_id') String? replyId,@JsonKey(name: 'room_id') String? roomId,@JsonKey(name: 'message_file') String? messageFile, DateTime created, DateTime updated
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? message = freezed,Object? sendBy = freezed,Object? messageType = freezed,Object? voiceMessageDuration = freezed,Object? replyBy = freezed,Object? replyTo = freezed,Object? createdAt = freezed,Object? replyMessage = freezed,Object? replyMessageType = freezed,Object? replyId = freezed,Object? roomId = freezed,Object? messageFile = freezed,Object? created = null,Object? updated = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,sendBy: freezed == sendBy ? _self.sendBy : sendBy // ignore: cast_nullable_to_non_nullable
as String?,messageType: freezed == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as String?,voiceMessageDuration: freezed == voiceMessageDuration ? _self.voiceMessageDuration : voiceMessageDuration // ignore: cast_nullable_to_non_nullable
as double?,replyBy: freezed == replyBy ? _self.replyBy : replyBy // ignore: cast_nullable_to_non_nullable
as String?,replyTo: freezed == replyTo ? _self.replyTo : replyTo // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,replyMessage: freezed == replyMessage ? _self.replyMessage : replyMessage // ignore: cast_nullable_to_non_nullable
as String?,replyMessageType: freezed == replyMessageType ? _self.replyMessageType : replyMessageType // ignore: cast_nullable_to_non_nullable
as String?,replyId: freezed == replyId ? _self.replyId : replyId // ignore: cast_nullable_to_non_nullable
as String?,roomId: freezed == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? message,  String? sendBy, @JsonKey(name: 'message_type')  String? messageType, @JsonKey(name: 'voice_message_duration')  double? voiceMessageDuration,  String? replyBy,  String? replyTo,  DateTime? createdAt, @JsonKey(name: 'reply_message')  String? replyMessage, @JsonKey(name: 'reply_message_type')  String? replyMessageType, @JsonKey(name: 'reply_id')  String? replyId, @JsonKey(name: 'room_id')  String? roomId, @JsonKey(name: 'message_file')  String? messageFile,  DateTime created,  DateTime updated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Message() when $default != null:
return $default(_that.id,_that.message,_that.sendBy,_that.messageType,_that.voiceMessageDuration,_that.replyBy,_that.replyTo,_that.createdAt,_that.replyMessage,_that.replyMessageType,_that.replyId,_that.roomId,_that.messageFile,_that.created,_that.updated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? message,  String? sendBy, @JsonKey(name: 'message_type')  String? messageType, @JsonKey(name: 'voice_message_duration')  double? voiceMessageDuration,  String? replyBy,  String? replyTo,  DateTime? createdAt, @JsonKey(name: 'reply_message')  String? replyMessage, @JsonKey(name: 'reply_message_type')  String? replyMessageType, @JsonKey(name: 'reply_id')  String? replyId, @JsonKey(name: 'room_id')  String? roomId, @JsonKey(name: 'message_file')  String? messageFile,  DateTime created,  DateTime updated)  $default,) {final _that = this;
switch (_that) {
case _Message():
return $default(_that.id,_that.message,_that.sendBy,_that.messageType,_that.voiceMessageDuration,_that.replyBy,_that.replyTo,_that.createdAt,_that.replyMessage,_that.replyMessageType,_that.replyId,_that.roomId,_that.messageFile,_that.created,_that.updated);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? message,  String? sendBy, @JsonKey(name: 'message_type')  String? messageType, @JsonKey(name: 'voice_message_duration')  double? voiceMessageDuration,  String? replyBy,  String? replyTo,  DateTime? createdAt, @JsonKey(name: 'reply_message')  String? replyMessage, @JsonKey(name: 'reply_message_type')  String? replyMessageType, @JsonKey(name: 'reply_id')  String? replyId, @JsonKey(name: 'room_id')  String? roomId, @JsonKey(name: 'message_file')  String? messageFile,  DateTime created,  DateTime updated)?  $default,) {final _that = this;
switch (_that) {
case _Message() when $default != null:
return $default(_that.id,_that.message,_that.sendBy,_that.messageType,_that.voiceMessageDuration,_that.replyBy,_that.replyTo,_that.createdAt,_that.replyMessage,_that.replyMessageType,_that.replyId,_that.roomId,_that.messageFile,_that.created,_that.updated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Message extends Message {
  const _Message({required this.id, this.message, this.sendBy, @JsonKey(name: 'message_type') this.messageType, @JsonKey(name: 'voice_message_duration') this.voiceMessageDuration, this.replyBy, this.replyTo, this.createdAt, @JsonKey(name: 'reply_message') this.replyMessage, @JsonKey(name: 'reply_message_type') this.replyMessageType, @JsonKey(name: 'reply_id') this.replyId, @JsonKey(name: 'room_id') this.roomId, @JsonKey(name: 'message_file') this.messageFile, required this.created, required this.updated}): super._();
  factory _Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);

@override final  String id;
@override final  String? message;
@override final  String? sendBy;
@override@JsonKey(name: 'message_type') final  String? messageType;
@override@JsonKey(name: 'voice_message_duration') final  double? voiceMessageDuration;
@override final  String? replyBy;
@override final  String? replyTo;
@override final  DateTime? createdAt;
@override@JsonKey(name: 'reply_message') final  String? replyMessage;
@override@JsonKey(name: 'reply_message_type') final  String? replyMessageType;
@override@JsonKey(name: 'reply_id') final  String? replyId;
@override@JsonKey(name: 'room_id') final  String? roomId;
@override@JsonKey(name: 'message_file') final  String? messageFile;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Message&&(identical(other.id, id) || other.id == id)&&(identical(other.message, message) || other.message == message)&&(identical(other.sendBy, sendBy) || other.sendBy == sendBy)&&(identical(other.messageType, messageType) || other.messageType == messageType)&&(identical(other.voiceMessageDuration, voiceMessageDuration) || other.voiceMessageDuration == voiceMessageDuration)&&(identical(other.replyBy, replyBy) || other.replyBy == replyBy)&&(identical(other.replyTo, replyTo) || other.replyTo == replyTo)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.replyMessage, replyMessage) || other.replyMessage == replyMessage)&&(identical(other.replyMessageType, replyMessageType) || other.replyMessageType == replyMessageType)&&(identical(other.replyId, replyId) || other.replyId == replyId)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.messageFile, messageFile) || other.messageFile == messageFile)&&(identical(other.created, created) || other.created == created)&&(identical(other.updated, updated) || other.updated == updated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,message,sendBy,messageType,voiceMessageDuration,replyBy,replyTo,createdAt,replyMessage,replyMessageType,replyId,roomId,messageFile,created,updated);

@override
String toString() {
  return 'Message(id: $id, message: $message, sendBy: $sendBy, messageType: $messageType, voiceMessageDuration: $voiceMessageDuration, replyBy: $replyBy, replyTo: $replyTo, createdAt: $createdAt, replyMessage: $replyMessage, replyMessageType: $replyMessageType, replyId: $replyId, roomId: $roomId, messageFile: $messageFile, created: $created, updated: $updated)';
}


}

/// @nodoc
abstract mixin class _$MessageCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$MessageCopyWith(_Message value, $Res Function(_Message) _then) = __$MessageCopyWithImpl;
@override @useResult
$Res call({
 String id, String? message, String? sendBy,@JsonKey(name: 'message_type') String? messageType,@JsonKey(name: 'voice_message_duration') double? voiceMessageDuration, String? replyBy, String? replyTo, DateTime? createdAt,@JsonKey(name: 'reply_message') String? replyMessage,@JsonKey(name: 'reply_message_type') String? replyMessageType,@JsonKey(name: 'reply_id') String? replyId,@JsonKey(name: 'room_id') String? roomId,@JsonKey(name: 'message_file') String? messageFile, DateTime created, DateTime updated
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? message = freezed,Object? sendBy = freezed,Object? messageType = freezed,Object? voiceMessageDuration = freezed,Object? replyBy = freezed,Object? replyTo = freezed,Object? createdAt = freezed,Object? replyMessage = freezed,Object? replyMessageType = freezed,Object? replyId = freezed,Object? roomId = freezed,Object? messageFile = freezed,Object? created = null,Object? updated = null,}) {
  return _then(_Message(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,sendBy: freezed == sendBy ? _self.sendBy : sendBy // ignore: cast_nullable_to_non_nullable
as String?,messageType: freezed == messageType ? _self.messageType : messageType // ignore: cast_nullable_to_non_nullable
as String?,voiceMessageDuration: freezed == voiceMessageDuration ? _self.voiceMessageDuration : voiceMessageDuration // ignore: cast_nullable_to_non_nullable
as double?,replyBy: freezed == replyBy ? _self.replyBy : replyBy // ignore: cast_nullable_to_non_nullable
as String?,replyTo: freezed == replyTo ? _self.replyTo : replyTo // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,replyMessage: freezed == replyMessage ? _self.replyMessage : replyMessage // ignore: cast_nullable_to_non_nullable
as String?,replyMessageType: freezed == replyMessageType ? _self.replyMessageType : replyMessageType // ignore: cast_nullable_to_non_nullable
as String?,replyId: freezed == replyId ? _self.replyId : replyId // ignore: cast_nullable_to_non_nullable
as String?,roomId: freezed == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String?,messageFile: freezed == messageFile ? _self.messageFile : messageFile // ignore: cast_nullable_to_non_nullable
as String?,created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as DateTime,updated: null == updated ? _self.updated : updated // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
