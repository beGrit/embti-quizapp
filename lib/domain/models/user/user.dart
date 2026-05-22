import 'package:emombti/domain/models/common/common.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// Core user model representing authenticated user information
/// Based on PocketBase users collection schema
@freezed
abstract class User with _$User {
  const factory User({
    String? id,
    String? email,
    String? name,
    AppFile? avatar,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
