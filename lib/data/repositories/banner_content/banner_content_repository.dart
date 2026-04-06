import '../../../domain/models/content/content.dart';
import '../../../utils/result.dart';

/// Abstract repository for [BannerContent] CRUD operations.
abstract class BannerContentRepository {
  Future<Result<List<BannerContent>>> getAll();
  Future<Result<BannerContent?>> getById(String id);
  Future<Result<BannerContent>> create(BannerContent content);
  Future<Result<BannerContent>> update(BannerContent content);
  Future<Result<void>> delete(String id);
}
