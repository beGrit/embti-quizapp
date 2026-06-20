import 'package:emombti/domain/models/content/content.dart';
import 'package:emombti/utils/result.dart';

/// Abstract repository for [BannerContent] CRUD operations.
abstract class ContentRepository {
  Future<Result<List<ArticleContent>>> getAllArticle();
  Future<Result<ArticleContent?>> getArticleById(String id);

  Future<Result<List<BannerContent>>> getAllBanner();
  Future<Result<BannerContent?>> getBannerById(String id);

  Future<Result<List<VideoContent>>> getAllVideo();
  Future<Result<VideoContent?>> getVideoById(String id);

  Future<String> getPolicyHtml(String policyType);
}
