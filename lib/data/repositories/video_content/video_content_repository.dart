import '../../../domain/models/content/content.dart';
import '../../../utils/result.dart';

/// Abstract repository for [VideoContent] CRUD operations.
abstract class VideoContentRepository {
  Future<Result<List<VideoContent>>> getAll();
  Future<Result<VideoContent?>> getById(String id);
  Future<Result<VideoContent>> create(VideoContent content);
  Future<Result<VideoContent>> update(VideoContent content);
  Future<Result<void>> delete(String id);
}
