import '../../../domain/models/content/content.dart';
import '../../../utils/result.dart';
import '../../services/persistence/local/local_data_service.dart';
import 'banner_content_repository.dart';

/// Local repository for [BannerContent].
/// Reads from [LocalDataService] (asset). Create/update/delete are not implemented.
class BannerContentRepositoryLocal extends BannerContentRepository {
  BannerContentRepositoryLocal({LocalDataService? localDataService})
      : _localDataService = localDataService ?? LocalDataService();

  final LocalDataService _localDataService;

  @override
  Future<Result<List<BannerContent>>> getAll() async {
    try {
      final list = await _localDataService.getBannerContents();
      return Result.ok(list);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<BannerContent?>> getById(String id) async {
    try {
      final list = await _localDataService.getBannerContents();
      final match = list.where((c) => c.id == id).firstOrNull;
      return Result.ok(match);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<BannerContent>> create(BannerContent content) async {
    return Result.error(Exception('Not implemented'));
  }

  @override
  Future<Result<BannerContent>> update(BannerContent content) async {
    return Result.error(Exception('Not implemented'));
  }

  @override
  Future<Result<void>> delete(String id) async {
    return Result.error(Exception('Not implemented'));
  }
}
