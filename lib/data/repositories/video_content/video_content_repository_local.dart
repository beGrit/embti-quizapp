import '../../../domain/models/content/content.dart';
import '../../../utils/result.dart';
import '../../services/local/local_data_service.dart';
import 'video_content_repository.dart';

/// Local repository for [VideoContent].
/// Reads from [LocalDataService] (asset). Create/update/delete are not implemented.
class VideoContentRepositoryLocal extends VideoContentRepository {
  VideoContentRepositoryLocal({LocalDataService? localDataService})
    : _localDataService = localDataService ?? LocalDataService();

  final LocalDataService _localDataService;

  @override
  Future<Result<List<VideoContent>>> getAll() async {
    try {
      final list = await _localDataService.getVideoContents();
      return Result.ok(list);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<VideoContent?>> getById(String id) async {
    try {
      final list = await _localDataService.getVideoContents();
      final match = list.where((c) => c.id == id).firstOrNull;
      return Result.ok(match);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<VideoContent>> create(VideoContent content) async {
    return Result.error(Exception('Not implemented'));
  }

  @override
  Future<Result<VideoContent>> update(VideoContent content) async {
    return Result.error(Exception('Not implemented'));
  }

  @override
  Future<Result<void>> delete(String id) async {
    return Result.error(Exception('Not implemented'));
  }
}
