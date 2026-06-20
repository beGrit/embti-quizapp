import 'package:emombti/data/repositories/content/content_repository.dart';
import 'package:emombti/data/services/persistence/local/local_storage.dart';
import 'package:emombti/domain/models/content/content.dart';
import 'package:emombti/utils/result.dart';

class ContentRepositoryDev extends ContentRepository {
  ContentRepositoryDev({required this.localStorage});

  LocalStorage localStorage;

  @override
  Future<Result<List<ArticleContent>>> getAllArticle() async {
    try {
      final list = await localStorage.getArticleContents();
      return Result.ok(list);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<ArticleContent?>> getArticleById(String id) async {
    try {
      return Result.ok(await localStorage.getArticleContentById(id));
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<List<BannerContent>>> getAllBanner() async {
    try {
      final list = await localStorage.getBannerContents();
      return Result.ok(list);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<BannerContent?>> getBannerById(String id) async {
    try {
      final list = await localStorage.getBannerContents();
      final match = list.where((c) => c.id == id).firstOrNull;
      return Result.ok(match);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<List<VideoContent>>> getAllVideo() async {
    try {
      final list = await localStorage.getVideoContents();
      return Result.ok(list);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<VideoContent?>> getVideoById(String id) async {
    try {
      final list = await localStorage.getVideoContents();
      final match = list.where((c) => c.id == id).firstOrNull;
      return Result.ok(match);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<String> getPolicyHtml(String policyType) async {
    return localStorage.loadPolicy(policyType);
  }
}
