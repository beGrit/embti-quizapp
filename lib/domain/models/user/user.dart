import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// Core user model representing authenticated user information
/// Based on PocketBase users collection schema
@freezed
sealed class User with _$User {
  const User._();

  const factory User({
    required String id,
    required String email,
    required bool emailVisibility,
    required bool verified,
    String? name,
    String? avatar,
    required DateTime created,
    required DateTime updated,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
