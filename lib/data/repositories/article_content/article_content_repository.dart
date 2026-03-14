import '../../../domain/models/content/content.dart';
import '../../../utils/result.dart';

/// Abstract repository for [ArticleContent] CRUD operations.
abstract class ArticleContentRepository {
  Future<Result<List<ArticleContent>>> getAll();
  Future<Result<ArticleContent?>> getById(String id);
  Future<Result<ArticleContent>> create(ArticleContent content);
  Future<Result<ArticleContent>> update(ArticleContent content);
  Future<Result<void>> delete(String id);
}
