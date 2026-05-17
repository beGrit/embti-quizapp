import 'package:emombti/domain/models/user/user.dart';

extension UserPocketBaseX on User {
  static const String collectionId =
      '_pb_users_auth_'; // PocketBase default auth collection ID
  static const String collectionName = 'users';
}
