import '../../../domain/models/content/content.dart';
import '../../../utils/result.dart';
import '../../services/local/local_data_service.dart';
import 'article_content_repository.dart';

/// Local repository for [ArticleContent].
/// Reads from [LocalDataService] (asset). Create/update/delete are not implemented.
class ArticleContentRepositoryLocal extends ArticleContentRepository {
  ArticleContentRepositoryLocal({LocalDataService? localDataService})
      : _localDataService = localDataService ?? LocalDataService();

  final LocalDataService _localDataService;

  @override
  Future<Result<List<ArticleContent>>> getAll() async {
    try {
      final list = await _localDataService.getArticleContents();
      return Result.ok(list);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<ArticleContent?>> getById(String id) async {
    try {
      final list = await _localDataService.getArticleContents();
      final match = list.where((c) => c.id == id).firstOrNull;
      return Result.ok(match);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<ArticleContent>> create(ArticleContent content) async {
    // Not implemented
    return Result.error(Exception('Not implemented'));
  }

  @override
  Future<Result<ArticleContent>> update(ArticleContent content) async {
    // Not implemented
    return Result.error(Exception('Not implemented'));
  }

  @override
  Future<Result<void>> delete(String id) async {
    // Not implemented
    return Result.error(Exception('Not implemented'));
  }
}
