// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'common.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppFile {

 Uri get uri; String get name;
/// Create a copy of AppFile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppFileCopyWith<AppFile> get copyWith => _$AppFileCopyWithImpl<AppFile>(this as AppFile, _$identity);

  /// Serializes this AppFile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppFile&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uri,name);

@override
String toString() {
  return 'AppFile(uri: $uri, name: $name)';
}


}

/// @nodoc
abstract mixin class $AppFileCopyWith<$Res>  {
  factory $AppFileCopyWith(AppFile value, $Res Function(AppFile) _then) = _$AppFileCopyWithImpl;
@useResult
$Res call({
 Uri uri, String name
});




}
/// @nodoc
class _$AppFileCopyWithImpl<$Res>
    implements $AppFileCopyWith<$Res> {
  _$AppFileCopyWithImpl(this._self, this._then);

  final AppFile _self;
  final $Res Function(AppFile) _then;

/// Create a copy of AppFile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uri = null,Object? name = null,}) {
  return _then(_self.copyWith(
uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as Uri,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AppFile].
extension AppFilePatterns on AppFile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppFile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppFile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppFile value)  $default,){
final _that = this;
switch (_that) {
case _AppFile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppFile value)?  $default,){
final _that = this;
switch (_that) {
case _AppFile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Uri uri,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppFile() when $default != null:
return $default(_that.uri,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Uri uri,  String name)  $default,) {final _that = this;
switch (_that) {
case _AppFile():
return $default(_that.uri,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Uri uri,  String name)?  $default,) {final _that = this;
switch (_that) {
case _AppFile() when $default != null:
return $default(_that.uri,_that.name);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppFile implements AppFile {
  const _AppFile({required this.uri, required this.name});
  factory _AppFile.fromJson(Map<String, dynamic> json) => _$AppFileFromJson(json);

@override final  Uri uri;
@override final  String name;

/// Create a copy of AppFile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppFileCopyWith<_AppFile> get copyWith => __$AppFileCopyWithImpl<_AppFile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppFileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppFile&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.name, name) || other.name == name));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uri,name);

@override
String toString() {
  return 'AppFile(uri: $uri, name: $name)';
}


}

/// @nodoc
abstract mixin class _$AppFileCopyWith<$Res> implements $AppFileCopyWith<$Res> {
  factory _$AppFileCopyWith(_AppFile value, $Res Function(_AppFile) _then) = __$AppFileCopyWithImpl;
@override @useResult
$Res call({
 Uri uri, String name
});




}
/// @nodoc
class __$AppFileCopyWithImpl<$Res>
    implements _$AppFileCopyWith<$Res> {
  __$AppFileCopyWithImpl(this._self, this._then);

  final _AppFile _self;
  final $Res Function(_AppFile) _then;

/// Create a copy of AppFile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uri = null,Object? name = null,}) {
  return _then(_AppFile(
uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as Uri,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
