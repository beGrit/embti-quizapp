// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserChatFirestoreApiModel {

 String get chatId; int get unreadCount; bool get isPinned;@FirestoreTimestampConverter() DateTime get createdAt;@FirestoreTimestampConverter() DateTime? get lastMessageSentAt; String? get lastMessageText; String? get lastMessageSenderId;
/// Create a copy of UserChatFirestoreApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserChatFirestoreApiModelCopyWith<UserChatFirestoreApiModel> get copyWith => _$UserChatFirestoreApiModelCopyWithImpl<UserChatFirestoreApiModel>(this as UserChatFirestoreApiModel, _$identity);

  /// Serializes this UserChatFirestoreApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserChatFirestoreApiModel&&(identical(other.chatId, chatId) || other.chatId == chatId)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastMessageSentAt, lastMessageSentAt) || other.lastMessageSentAt == lastMessageSentAt)&&(identical(other.lastMessageText, lastMessageText) || other.lastMessageText == lastMessageText)&&(identical(other.lastMessageSenderId, lastMessageSenderId) || other.lastMessageSenderId == lastMessageSenderId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chatId,unreadCount,isPinned,createdAt,lastMessageSentAt,lastMessageText,lastMessageSenderId);

@override
String toString() {
  return 'UserChatFirestoreApiModel(chatId: $chatId, unreadCount: $unreadCount, isPinned: $isPinned, createdAt: $createdAt, lastMessageSentAt: $lastMessageSentAt, lastMessageText: $lastMessageText, lastMessageSenderId: $lastMessageSenderId)';
}


}

/// @nodoc
abstract mixin class $UserChatFirestoreApiModelCopyWith<$Res>  {
  factory $UserChatFirestoreApiModelCopyWith(UserChatFirestoreApiModel value, $Res Function(UserChatFirestoreApiModel) _then) = _$UserChatFirestoreApiModelCopyWithImpl;
@useResult
$Res call({
 String chatId, int unreadCount, bool isPinned,@FirestoreTimestampConverter() DateTime createdAt,@FirestoreTimestampConverter() DateTime? lastMessageSentAt, String? lastMessageText, String? lastMessageSenderId
});




}
/// @nodoc
class _$UserChatFirestoreApiModelCopyWithImpl<$Res>
    implements $UserChatFirestoreApiModelCopyWith<$Res> {
  _$UserChatFirestoreApiModelCopyWithImpl(this._self, this._then);

  final UserChatFirestoreApiModel _self;
  final $Res Function(UserChatFirestoreApiModel) _then;

/// Create a copy of UserChatFirestoreApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chatId = null,Object? unreadCount = null,Object? isPinned = null,Object? createdAt = null,Object? lastMessageSentAt = freezed,Object? lastMessageText = freezed,Object? lastMessageSenderId = freezed,}) {
  return _then(_self.copyWith(
chatId: null == chatId ? _self.chatId : chatId // ignore: cast_nullable_to_non_nullable
as String,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastMessageSentAt: freezed == lastMessageSentAt ? _self.lastMessageSentAt : lastMessageSentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastMessageText: freezed == lastMessageText ? _self.lastMessageText : lastMessageText // ignore: cast_nullable_to_non_nullable
as String?,lastMessageSenderId: freezed == lastMessageSenderId ? _self.lastMessageSenderId : lastMessageSenderId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserChatFirestoreApiModel].
extension UserChatFirestoreApiModelPatterns on UserChatFirestoreApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserChatFirestoreApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserChatFirestoreApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserChatFirestoreApiModel value)  $default,){
final _that = this;
switch (_that) {
case _UserChatFirestoreApiModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserChatFirestoreApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserChatFirestoreApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String chatId,  int unreadCount,  bool isPinned, @FirestoreTimestampConverter()  DateTime createdAt, @FirestoreTimestampConverter()  DateTime? lastMessageSentAt,  String? lastMessageText,  String? lastMessageSenderId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserChatFirestoreApiModel() when $default != null:
return $default(_that.chatId,_that.unreadCount,_that.isPinned,_that.createdAt,_that.lastMessageSentAt,_that.lastMessageText,_that.lastMessageSenderId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String chatId,  int unreadCount,  bool isPinned, @FirestoreTimestampConverter()  DateTime createdAt, @FirestoreTimestampConverter()  DateTime? lastMessageSentAt,  String? lastMessageText,  String? lastMessageSenderId)  $default,) {final _that = this;
switch (_that) {
case _UserChatFirestoreApiModel():
return $default(_that.chatId,_that.unreadCount,_that.isPinned,_that.createdAt,_that.lastMessageSentAt,_that.lastMessageText,_that.lastMessageSenderId);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String chatId,  int unreadCount,  bool isPinned, @FirestoreTimestampConverter()  DateTime createdAt, @FirestoreTimestampConverter()  DateTime? lastMessageSentAt,  String? lastMessageText,  String? lastMessageSenderId)?  $default,) {final _that = this;
switch (_that) {
case _UserChatFirestoreApiModel() when $default != null:
return $default(_that.chatId,_that.unreadCount,_that.isPinned,_that.createdAt,_that.lastMessageSentAt,_that.lastMessageText,_that.lastMessageSenderId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserChatFirestoreApiModel implements UserChatFirestoreApiModel {
  const _UserChatFirestoreApiModel({required this.chatId, this.unreadCount = 0, this.isPinned = false, @FirestoreTimestampConverter() required this.createdAt, @FirestoreTimestampConverter() this.lastMessageSentAt, this.lastMessageText, this.lastMessageSenderId});
  factory _UserChatFirestoreApiModel.fromJson(Map<String, dynamic> json) => _$UserChatFirestoreApiModelFromJson(json);

@override final  String chatId;
@override@JsonKey() final  int unreadCount;
@override@JsonKey() final  bool isPinned;
@override@FirestoreTimestampConverter() final  DateTime createdAt;
@override@FirestoreTimestampConverter() final  DateTime? lastMessageSentAt;
@override final  String? lastMessageText;
@override final  String? lastMessageSenderId;

/// Create a copy of UserChatFirestoreApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserChatFirestoreApiModelCopyWith<_UserChatFirestoreApiModel> get copyWith => __$UserChatFirestoreApiModelCopyWithImpl<_UserChatFirestoreApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserChatFirestoreApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserChatFirestoreApiModel&&(identical(other.chatId, chatId) || other.chatId == chatId)&&(identical(other.unreadCount, unreadCount) || other.unreadCount == unreadCount)&&(identical(other.isPinned, isPinned) || other.isPinned == isPinned)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastMessageSentAt, lastMessageSentAt) || other.lastMessageSentAt == lastMessageSentAt)&&(identical(other.lastMessageText, lastMessageText) || other.lastMessageText == lastMessageText)&&(identical(other.lastMessageSenderId, lastMessageSenderId) || other.lastMessageSenderId == lastMessageSenderId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chatId,unreadCount,isPinned,createdAt,lastMessageSentAt,lastMessageText,lastMessageSenderId);

@override
String toString() {
  return 'UserChatFirestoreApiModel(chatId: $chatId, unreadCount: $unreadCount, isPinned: $isPinned, createdAt: $createdAt, lastMessageSentAt: $lastMessageSentAt, lastMessageText: $lastMessageText, lastMessageSenderId: $lastMessageSenderId)';
}


}

/// @nodoc
abstract mixin class _$UserChatFirestoreApiModelCopyWith<$Res> implements $UserChatFirestoreApiModelCopyWith<$Res> {
  factory _$UserChatFirestoreApiModelCopyWith(_UserChatFirestoreApiModel value, $Res Function(_UserChatFirestoreApiModel) _then) = __$UserChatFirestoreApiModelCopyWithImpl;
@override @useResult
$Res call({
 String chatId, int unreadCount, bool isPinned,@FirestoreTimestampConverter() DateTime createdAt,@FirestoreTimestampConverter() DateTime? lastMessageSentAt, String? lastMessageText, String? lastMessageSenderId
});




}
/// @nodoc
class __$UserChatFirestoreApiModelCopyWithImpl<$Res>
    implements _$UserChatFirestoreApiModelCopyWith<$Res> {
  __$UserChatFirestoreApiModelCopyWithImpl(this._self, this._then);

  final _UserChatFirestoreApiModel _self;
  final $Res Function(_UserChatFirestoreApiModel) _then;

/// Create a copy of UserChatFirestoreApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chatId = null,Object? unreadCount = null,Object? isPinned = null,Object? createdAt = null,Object? lastMessageSentAt = freezed,Object? lastMessageText = freezed,Object? lastMessageSenderId = freezed,}) {
  return _then(_UserChatFirestoreApiModel(
chatId: null == chatId ? _self.chatId : chatId // ignore: cast_nullable_to_non_nullable
as String,unreadCount: null == unreadCount ? _self.unreadCount : unreadCount // ignore: cast_nullable_to_non_nullable
as int,isPinned: null == isPinned ? _self.isPinned : isPinned // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastMessageSentAt: freezed == lastMessageSentAt ? _self.lastMessageSentAt : lastMessageSentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastMessageText: freezed == lastMessageText ? _self.lastMessageText : lastMessageText // ignore: cast_nullable_to_non_nullable
as String?,lastMessageSenderId: freezed == lastMessageSenderId ? _self.lastMessageSenderId : lastMessageSenderId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ChatLastMessageApiModel {

 String get text; String get senderId;@FirestoreTimestampConverter() DateTime get sentAt;
/// Create a copy of ChatLastMessageApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatLastMessageApiModelCopyWith<ChatLastMessageApiModel> get copyWith => _$ChatLastMessageApiModelCopyWithImpl<ChatLastMessageApiModel>(this as ChatLastMessageApiModel, _$identity);

  /// Serializes this ChatLastMessageApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatLastMessageApiModel&&(identical(other.text, text) || other.text == text)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,senderId,sentAt);

@override
String toString() {
  return 'ChatLastMessageApiModel(text: $text, senderId: $senderId, sentAt: $sentAt)';
}


}

/// @nodoc
abstract mixin class $ChatLastMessageApiModelCopyWith<$Res>  {
  factory $ChatLastMessageApiModelCopyWith(ChatLastMessageApiModel value, $Res Function(ChatLastMessageApiModel) _then) = _$ChatLastMessageApiModelCopyWithImpl;
@useResult
$Res call({
 String text, String senderId,@FirestoreTimestampConverter() DateTime sentAt
});




}
/// @nodoc
class _$ChatLastMessageApiModelCopyWithImpl<$Res>
    implements $ChatLastMessageApiModelCopyWith<$Res> {
  _$ChatLastMessageApiModelCopyWithImpl(this._self, this._then);

  final ChatLastMessageApiModel _self;
  final $Res Function(ChatLastMessageApiModel) _then;

/// Create a copy of ChatLastMessageApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? senderId = null,Object? sentAt = null,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatLastMessageApiModel].
extension ChatLastMessageApiModelPatterns on ChatLastMessageApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatLastMessageApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatLastMessageApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatLastMessageApiModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatLastMessageApiModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatLastMessageApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatLastMessageApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text,  String senderId, @FirestoreTimestampConverter()  DateTime sentAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatLastMessageApiModel() when $default != null:
return $default(_that.text,_that.senderId,_that.sentAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text,  String senderId, @FirestoreTimestampConverter()  DateTime sentAt)  $default,) {final _that = this;
switch (_that) {
case _ChatLastMessageApiModel():
return $default(_that.text,_that.senderId,_that.sentAt);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text,  String senderId, @FirestoreTimestampConverter()  DateTime sentAt)?  $default,) {final _that = this;
switch (_that) {
case _ChatLastMessageApiModel() when $default != null:
return $default(_that.text,_that.senderId,_that.sentAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatLastMessageApiModel implements ChatLastMessageApiModel {
  const _ChatLastMessageApiModel({required this.text, required this.senderId, @FirestoreTimestampConverter() required this.sentAt});
  factory _ChatLastMessageApiModel.fromJson(Map<String, dynamic> json) => _$ChatLastMessageApiModelFromJson(json);

@override final  String text;
@override final  String senderId;
@override@FirestoreTimestampConverter() final  DateTime sentAt;

/// Create a copy of ChatLastMessageApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatLastMessageApiModelCopyWith<_ChatLastMessageApiModel> get copyWith => __$ChatLastMessageApiModelCopyWithImpl<_ChatLastMessageApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatLastMessageApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatLastMessageApiModel&&(identical(other.text, text) || other.text == text)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,senderId,sentAt);

@override
String toString() {
  return 'ChatLastMessageApiModel(text: $text, senderId: $senderId, sentAt: $sentAt)';
}


}

/// @nodoc
abstract mixin class _$ChatLastMessageApiModelCopyWith<$Res> implements $ChatLastMessageApiModelCopyWith<$Res> {
  factory _$ChatLastMessageApiModelCopyWith(_ChatLastMessageApiModel value, $Res Function(_ChatLastMessageApiModel) _then) = __$ChatLastMessageApiModelCopyWithImpl;
@override @useResult
$Res call({
 String text, String senderId,@FirestoreTimestampConverter() DateTime sentAt
});




}
/// @nodoc
class __$ChatLastMessageApiModelCopyWithImpl<$Res>
    implements _$ChatLastMessageApiModelCopyWith<$Res> {
  __$ChatLastMessageApiModelCopyWithImpl(this._self, this._then);

  final _ChatLastMessageApiModel _self;
  final $Res Function(_ChatLastMessageApiModel) _then;

/// Create a copy of ChatLastMessageApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? senderId = null,Object? sentAt = null,}) {
  return _then(_ChatLastMessageApiModel(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$ChatFirestoreApiModel {

 String get chatId; bool get isGroup; String? get chatName;@FirestoreTimestampConverter() DateTime get createdAt; List<String> get members; ChatLastMessageApiModel? get lastMessage;
/// Create a copy of ChatFirestoreApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatFirestoreApiModelCopyWith<ChatFirestoreApiModel> get copyWith => _$ChatFirestoreApiModelCopyWithImpl<ChatFirestoreApiModel>(this as ChatFirestoreApiModel, _$identity);

  /// Serializes this ChatFirestoreApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatFirestoreApiModel&&(identical(other.chatId, chatId) || other.chatId == chatId)&&(identical(other.isGroup, isGroup) || other.isGroup == isGroup)&&(identical(other.chatName, chatName) || other.chatName == chatName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.members, members)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chatId,isGroup,chatName,createdAt,const DeepCollectionEquality().hash(members),lastMessage);

@override
String toString() {
  return 'ChatFirestoreApiModel(chatId: $chatId, isGroup: $isGroup, chatName: $chatName, createdAt: $createdAt, members: $members, lastMessage: $lastMessage)';
}


}

/// @nodoc
abstract mixin class $ChatFirestoreApiModelCopyWith<$Res>  {
  factory $ChatFirestoreApiModelCopyWith(ChatFirestoreApiModel value, $Res Function(ChatFirestoreApiModel) _then) = _$ChatFirestoreApiModelCopyWithImpl;
@useResult
$Res call({
 String chatId, bool isGroup, String? chatName,@FirestoreTimestampConverter() DateTime createdAt, List<String> members, ChatLastMessageApiModel? lastMessage
});


$ChatLastMessageApiModelCopyWith<$Res>? get lastMessage;

}
/// @nodoc
class _$ChatFirestoreApiModelCopyWithImpl<$Res>
    implements $ChatFirestoreApiModelCopyWith<$Res> {
  _$ChatFirestoreApiModelCopyWithImpl(this._self, this._then);

  final ChatFirestoreApiModel _self;
  final $Res Function(ChatFirestoreApiModel) _then;

/// Create a copy of ChatFirestoreApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chatId = null,Object? isGroup = null,Object? chatName = freezed,Object? createdAt = null,Object? members = null,Object? lastMessage = freezed,}) {
  return _then(_self.copyWith(
chatId: null == chatId ? _self.chatId : chatId // ignore: cast_nullable_to_non_nullable
as String,isGroup: null == isGroup ? _self.isGroup : isGroup // ignore: cast_nullable_to_non_nullable
as bool,chatName: freezed == chatName ? _self.chatName : chatName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,members: null == members ? _self.members : members // ignore: cast_nullable_to_non_nullable
as List<String>,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as ChatLastMessageApiModel?,
  ));
}
/// Create a copy of ChatFirestoreApiModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatLastMessageApiModelCopyWith<$Res>? get lastMessage {
    if (_self.lastMessage == null) {
    return null;
  }

  return $ChatLastMessageApiModelCopyWith<$Res>(_self.lastMessage!, (value) {
    return _then(_self.copyWith(lastMessage: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChatFirestoreApiModel].
extension ChatFirestoreApiModelPatterns on ChatFirestoreApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatFirestoreApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatFirestoreApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatFirestoreApiModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatFirestoreApiModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatFirestoreApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatFirestoreApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String chatId,  bool isGroup,  String? chatName, @FirestoreTimestampConverter()  DateTime createdAt,  List<String> members,  ChatLastMessageApiModel? lastMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatFirestoreApiModel() when $default != null:
return $default(_that.chatId,_that.isGroup,_that.chatName,_that.createdAt,_that.members,_that.lastMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String chatId,  bool isGroup,  String? chatName, @FirestoreTimestampConverter()  DateTime createdAt,  List<String> members,  ChatLastMessageApiModel? lastMessage)  $default,) {final _that = this;
switch (_that) {
case _ChatFirestoreApiModel():
return $default(_that.chatId,_that.isGroup,_that.chatName,_that.createdAt,_that.members,_that.lastMessage);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String chatId,  bool isGroup,  String? chatName, @FirestoreTimestampConverter()  DateTime createdAt,  List<String> members,  ChatLastMessageApiModel? lastMessage)?  $default,) {final _that = this;
switch (_that) {
case _ChatFirestoreApiModel() when $default != null:
return $default(_that.chatId,_that.isGroup,_that.chatName,_that.createdAt,_that.members,_that.lastMessage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatFirestoreApiModel implements ChatFirestoreApiModel {
  const _ChatFirestoreApiModel({required this.chatId, this.isGroup = false, this.chatName, @FirestoreTimestampConverter() required this.createdAt, final  List<String> members = const [], this.lastMessage}): _members = members;
  factory _ChatFirestoreApiModel.fromJson(Map<String, dynamic> json) => _$ChatFirestoreApiModelFromJson(json);

@override final  String chatId;
@override@JsonKey() final  bool isGroup;
@override final  String? chatName;
@override@FirestoreTimestampConverter() final  DateTime createdAt;
 final  List<String> _members;
@override@JsonKey() List<String> get members {
  if (_members is EqualUnmodifiableListView) return _members;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_members);
}

@override final  ChatLastMessageApiModel? lastMessage;

/// Create a copy of ChatFirestoreApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatFirestoreApiModelCopyWith<_ChatFirestoreApiModel> get copyWith => __$ChatFirestoreApiModelCopyWithImpl<_ChatFirestoreApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatFirestoreApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatFirestoreApiModel&&(identical(other.chatId, chatId) || other.chatId == chatId)&&(identical(other.isGroup, isGroup) || other.isGroup == isGroup)&&(identical(other.chatName, chatName) || other.chatName == chatName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._members, _members)&&(identical(other.lastMessage, lastMessage) || other.lastMessage == lastMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,chatId,isGroup,chatName,createdAt,const DeepCollectionEquality().hash(_members),lastMessage);

@override
String toString() {
  return 'ChatFirestoreApiModel(chatId: $chatId, isGroup: $isGroup, chatName: $chatName, createdAt: $createdAt, members: $members, lastMessage: $lastMessage)';
}


}

/// @nodoc
abstract mixin class _$ChatFirestoreApiModelCopyWith<$Res> implements $ChatFirestoreApiModelCopyWith<$Res> {
  factory _$ChatFirestoreApiModelCopyWith(_ChatFirestoreApiModel value, $Res Function(_ChatFirestoreApiModel) _then) = __$ChatFirestoreApiModelCopyWithImpl;
@override @useResult
$Res call({
 String chatId, bool isGroup, String? chatName,@FirestoreTimestampConverter() DateTime createdAt, List<String> members, ChatLastMessageApiModel? lastMessage
});


@override $ChatLastMessageApiModelCopyWith<$Res>? get lastMessage;

}
/// @nodoc
class __$ChatFirestoreApiModelCopyWithImpl<$Res>
    implements _$ChatFirestoreApiModelCopyWith<$Res> {
  __$ChatFirestoreApiModelCopyWithImpl(this._self, this._then);

  final _ChatFirestoreApiModel _self;
  final $Res Function(_ChatFirestoreApiModel) _then;

/// Create a copy of ChatFirestoreApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chatId = null,Object? isGroup = null,Object? chatName = freezed,Object? createdAt = null,Object? members = null,Object? lastMessage = freezed,}) {
  return _then(_ChatFirestoreApiModel(
chatId: null == chatId ? _self.chatId : chatId // ignore: cast_nullable_to_non_nullable
as String,isGroup: null == isGroup ? _self.isGroup : isGroup // ignore: cast_nullable_to_non_nullable
as bool,chatName: freezed == chatName ? _self.chatName : chatName // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,members: null == members ? _self._members : members // ignore: cast_nullable_to_non_nullable
as List<String>,lastMessage: freezed == lastMessage ? _self.lastMessage : lastMessage // ignore: cast_nullable_to_non_nullable
as ChatLastMessageApiModel?,
  ));
}

/// Create a copy of ChatFirestoreApiModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChatLastMessageApiModelCopyWith<$Res>? get lastMessage {
    if (_self.lastMessage == null) {
    return null;
  }

  return $ChatLastMessageApiModelCopyWith<$Res>(_self.lastMessage!, (value) {
    return _then(_self.copyWith(lastMessage: value));
  });
}
}


/// @nodoc
mixin _$ChatMessageFirestoreApiModel {

@JsonKey(includeFromJson: false, includeToJson: false) String? get id; String get messageId; String get senderId; String get type; String get content;@FirestoreTimestampConverter() DateTime get sentAt;
/// Create a copy of ChatMessageFirestoreApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatMessageFirestoreApiModelCopyWith<ChatMessageFirestoreApiModel> get copyWith => _$ChatMessageFirestoreApiModelCopyWithImpl<ChatMessageFirestoreApiModel>(this as ChatMessageFirestoreApiModel, _$identity);

  /// Serializes this ChatMessageFirestoreApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatMessageFirestoreApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.type, type) || other.type == type)&&(identical(other.content, content) || other.content == content)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,messageId,senderId,type,content,sentAt);

@override
String toString() {
  return 'ChatMessageFirestoreApiModel(id: $id, messageId: $messageId, senderId: $senderId, type: $type, content: $content, sentAt: $sentAt)';
}


}

/// @nodoc
abstract mixin class $ChatMessageFirestoreApiModelCopyWith<$Res>  {
  factory $ChatMessageFirestoreApiModelCopyWith(ChatMessageFirestoreApiModel value, $Res Function(ChatMessageFirestoreApiModel) _then) = _$ChatMessageFirestoreApiModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(includeFromJson: false, includeToJson: false) String? id, String messageId, String senderId, String type, String content,@FirestoreTimestampConverter() DateTime sentAt
});




}
/// @nodoc
class _$ChatMessageFirestoreApiModelCopyWithImpl<$Res>
    implements $ChatMessageFirestoreApiModelCopyWith<$Res> {
  _$ChatMessageFirestoreApiModelCopyWithImpl(this._self, this._then);

  final ChatMessageFirestoreApiModel _self;
  final $Res Function(ChatMessageFirestoreApiModel) _then;

/// Create a copy of ChatMessageFirestoreApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? messageId = null,Object? senderId = null,Object? type = null,Object? content = null,Object? sentAt = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatMessageFirestoreApiModel].
extension ChatMessageFirestoreApiModelPatterns on ChatMessageFirestoreApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatMessageFirestoreApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatMessageFirestoreApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatMessageFirestoreApiModel value)  $default,){
final _that = this;
switch (_that) {
case _ChatMessageFirestoreApiModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatMessageFirestoreApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChatMessageFirestoreApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(includeFromJson: false, includeToJson: false)  String? id,  String messageId,  String senderId,  String type,  String content, @FirestoreTimestampConverter()  DateTime sentAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatMessageFirestoreApiModel() when $default != null:
return $default(_that.id,_that.messageId,_that.senderId,_that.type,_that.content,_that.sentAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(includeFromJson: false, includeToJson: false)  String? id,  String messageId,  String senderId,  String type,  String content, @FirestoreTimestampConverter()  DateTime sentAt)  $default,) {final _that = this;
switch (_that) {
case _ChatMessageFirestoreApiModel():
return $default(_that.id,_that.messageId,_that.senderId,_that.type,_that.content,_that.sentAt);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(includeFromJson: false, includeToJson: false)  String? id,  String messageId,  String senderId,  String type,  String content, @FirestoreTimestampConverter()  DateTime sentAt)?  $default,) {final _that = this;
switch (_that) {
case _ChatMessageFirestoreApiModel() when $default != null:
return $default(_that.id,_that.messageId,_that.senderId,_that.type,_that.content,_that.sentAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChatMessageFirestoreApiModel implements ChatMessageFirestoreApiModel {
  const _ChatMessageFirestoreApiModel({@JsonKey(includeFromJson: false, includeToJson: false) this.id, required this.messageId, required this.senderId, this.type = 'text', required this.content, @FirestoreTimestampConverter() required this.sentAt});
  factory _ChatMessageFirestoreApiModel.fromJson(Map<String, dynamic> json) => _$ChatMessageFirestoreApiModelFromJson(json);

@override@JsonKey(includeFromJson: false, includeToJson: false) final  String? id;
@override final  String messageId;
@override final  String senderId;
@override@JsonKey() final  String type;
@override final  String content;
@override@FirestoreTimestampConverter() final  DateTime sentAt;

/// Create a copy of ChatMessageFirestoreApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatMessageFirestoreApiModelCopyWith<_ChatMessageFirestoreApiModel> get copyWith => __$ChatMessageFirestoreApiModelCopyWithImpl<_ChatMessageFirestoreApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChatMessageFirestoreApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatMessageFirestoreApiModel&&(identical(other.id, id) || other.id == id)&&(identical(other.messageId, messageId) || other.messageId == messageId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.type, type) || other.type == type)&&(identical(other.content, content) || other.content == content)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,messageId,senderId,type,content,sentAt);

@override
String toString() {
  return 'ChatMessageFirestoreApiModel(id: $id, messageId: $messageId, senderId: $senderId, type: $type, content: $content, sentAt: $sentAt)';
}


}

/// @nodoc
abstract mixin class _$ChatMessageFirestoreApiModelCopyWith<$Res> implements $ChatMessageFirestoreApiModelCopyWith<$Res> {
  factory _$ChatMessageFirestoreApiModelCopyWith(_ChatMessageFirestoreApiModel value, $Res Function(_ChatMessageFirestoreApiModel) _then) = __$ChatMessageFirestoreApiModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(includeFromJson: false, includeToJson: false) String? id, String messageId, String senderId, String type, String content,@FirestoreTimestampConverter() DateTime sentAt
});




}
/// @nodoc
class __$ChatMessageFirestoreApiModelCopyWithImpl<$Res>
    implements _$ChatMessageFirestoreApiModelCopyWith<$Res> {
  __$ChatMessageFirestoreApiModelCopyWithImpl(this._self, this._then);

  final _ChatMessageFirestoreApiModel _self;
  final $Res Function(_ChatMessageFirestoreApiModel) _then;

/// Create a copy of ChatMessageFirestoreApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? messageId = null,Object? senderId = null,Object? type = null,Object? content = null,Object? sentAt = null,}) {
  return _then(_ChatMessageFirestoreApiModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,messageId: null == messageId ? _self.messageId : messageId // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$RobotFirestoreApiModel {

 String get id;
/// Create a copy of RobotFirestoreApiModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RobotFirestoreApiModelCopyWith<RobotFirestoreApiModel> get copyWith => _$RobotFirestoreApiModelCopyWithImpl<RobotFirestoreApiModel>(this as RobotFirestoreApiModel, _$identity);

  /// Serializes this RobotFirestoreApiModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RobotFirestoreApiModel&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'RobotFirestoreApiModel(id: $id)';
}


}

/// @nodoc
abstract mixin class $RobotFirestoreApiModelCopyWith<$Res>  {
  factory $RobotFirestoreApiModelCopyWith(RobotFirestoreApiModel value, $Res Function(RobotFirestoreApiModel) _then) = _$RobotFirestoreApiModelCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$RobotFirestoreApiModelCopyWithImpl<$Res>
    implements $RobotFirestoreApiModelCopyWith<$Res> {
  _$RobotFirestoreApiModelCopyWithImpl(this._self, this._then);

  final RobotFirestoreApiModel _self;
  final $Res Function(RobotFirestoreApiModel) _then;

/// Create a copy of RobotFirestoreApiModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RobotFirestoreApiModel].
extension RobotFirestoreApiModelPatterns on RobotFirestoreApiModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RobotFirestoreApiModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RobotFirestoreApiModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RobotFirestoreApiModel value)  $default,){
final _that = this;
switch (_that) {
case _RobotFirestoreApiModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RobotFirestoreApiModel value)?  $default,){
final _that = this;
switch (_that) {
case _RobotFirestoreApiModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RobotFirestoreApiModel() when $default != null:
return $default(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id)  $default,) {final _that = this;
switch (_that) {
case _RobotFirestoreApiModel():
return $default(_that.id);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id)?  $default,) {final _that = this;
switch (_that) {
case _RobotFirestoreApiModel() when $default != null:
return $default(_that.id);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RobotFirestoreApiModel implements RobotFirestoreApiModel {
  const _RobotFirestoreApiModel({required this.id});
  factory _RobotFirestoreApiModel.fromJson(Map<String, dynamic> json) => _$RobotFirestoreApiModelFromJson(json);

@override final  String id;

/// Create a copy of RobotFirestoreApiModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RobotFirestoreApiModelCopyWith<_RobotFirestoreApiModel> get copyWith => __$RobotFirestoreApiModelCopyWithImpl<_RobotFirestoreApiModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RobotFirestoreApiModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RobotFirestoreApiModel&&(identical(other.id, id) || other.id == id));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'RobotFirestoreApiModel(id: $id)';
}


}

/// @nodoc
abstract mixin class _$RobotFirestoreApiModelCopyWith<$Res> implements $RobotFirestoreApiModelCopyWith<$Res> {
  factory _$RobotFirestoreApiModelCopyWith(_RobotFirestoreApiModel value, $Res Function(_RobotFirestoreApiModel) _then) = __$RobotFirestoreApiModelCopyWithImpl;
@override @useResult
$Res call({
 String id
});




}
/// @nodoc
class __$RobotFirestoreApiModelCopyWithImpl<$Res>
    implements _$RobotFirestoreApiModelCopyWith<$Res> {
  __$RobotFirestoreApiModelCopyWithImpl(this._self, this._then);

  final _RobotFirestoreApiModel _self;
  final $Res Function(_RobotFirestoreApiModel) _then;

/// Create a copy of RobotFirestoreApiModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_RobotFirestoreApiModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
