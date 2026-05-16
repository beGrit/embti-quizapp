import '../../../domain/models/user/user.dart';
import '../../../utils/result.dart';

/// User repository interface responsible for handling basic user information.
abstract class UserRepository {
  /// Fetches basic user information for a specific ID.
  Future<Result<User>> getUser(String id);

  /// Saves or updates core user information.
  Future<Result<void>> saveUser(User user);

  /// Updates the user's avatar.
  Future<Result<String>> updateAvatar(String id, List<int> bytes, String filename);
}
