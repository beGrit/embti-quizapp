import 'package:emombti/data/services/persistence/api/pocketbase_service.dart';
import 'package:emombti/domain/models/common/common.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/models/user/user.dart';
import '../../../utils/result.dart';
import '../../services/persistence/api/model/user/user_api_model.dart';
import 'auth_repository.dart';

class AuthRepositoryDev extends AuthRepository {
  AuthRepositoryDev({required PocketBaseService pbService})
    : _pbService = pbService {
    _pbService.client.authStore.onChange.listen((event) {
      notifyListeners();
    });
  }

  final PocketBaseService _pbService;

  @override
  User? get user {
    final recordModel = _pbService.client.authStore.record;
    if (recordModel is RecordModel) {
      final apiModel = UserApiModel.fromJson(recordModel.toJson());
      Uri avatarUri = _pbService.client.files.getURL(
        RecordModel({
          'id': apiModel.id,
          'collectionId': apiModel.collectionId,
          'collectionName': apiModel.collectionName,
        }),
        apiModel.avatar ?? '',
      );
      return User(
        id: apiModel.id,
        email: apiModel.email,
        name: apiModel.name,
        avatar: apiModel.avatar != null
            ? AppFile(uri: avatarUri, name: apiModel.avatar!)
            : null,
      );
    }
    return null;
  }

  @override
  Future<bool> get isAuthenticated =>
      Future.value(_pbService.client.authStore.isValid);

  @override
  Future<Result<void>> login({
    required String email,
    required String password,
  }) async {
    try {
      await _pbService.client
          .collection('users')
          .authWithPassword(email, password);
      return const Result.ok(null);
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<void>> logout() async {
    _pbService.client.authStore.clear();
    return const Result.ok(null);
  }

  @override
  Future<Result<void>> loginWithGoogle() async {
    try {
      await _pbService.client.collection('users').authWithOAuth2('google', (
        url,
      ) async {
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        } else {
          throw Exception('Could not launch OAuth URL');
        }
      });
      return const Result.ok(null);
    } catch (e) {
      return Result.error(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<Result<void>> loginWithWechat() async {
    return Result.error(
      Exception('Wechat login not implemented with PocketBase'),
    );
  }
}
