import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_api_model.freezed.dart';
part 'user_api_model.g.dart';

/// Model representing a User from the API
/// Based on PocketBase users collection schema
@freezed
abstract class UserApiModel with _$UserApiModel {
  const factory UserApiModel({
    required String id,
    required String collectionId,
    required String collectionName,
    String? username,
    String? email,
    bool? emailVisibility,
    bool? verified,
    String? name,
    String? avatar,
    required DateTime created,
    required DateTime updated,
  }) = _UserApiModel;

  factory UserApiModel.fromJson(Map<String, dynamic> json) =>
      _$UserApiModelFromJson(json);
}
