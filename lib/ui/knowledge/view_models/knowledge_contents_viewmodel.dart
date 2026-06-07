import 'package:emombti/data/repositories/content/content_repository.dart';
import 'package:emombti/domain/models/content/content.dart';
import 'package:emombti/utils/command.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';

class KnowledgeContentsViewModel extends ChangeNotifier {
  KnowledgeContentsViewModel({required this.repository}) {
    loadArticles = Command0<List<ArticleContent>>(_loadArticles);
    loadBanners = Command0<void>(_loadBanners);
  }

  final ContentRepository repository;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  final List<String> _allPersonalities = [
    'INTJ',
    'INTP',
    'ENTJ',
    'ENTP',
    'INFJ',
    'INFP',
    'ENFJ',
    'ENFP',
    'ISTJ',
    'ISFJ',
    'ESTJ',
    'ESFJ',
    'ISTP',
    'ISFP',
    'ESTP',
    'ESFP',
  ];

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<String> get suggestions => _searchQuery.isEmpty
      ? []
      : _allPersonalities
            .where((p) => p.toLowerCase().contains(_searchQuery.toLowerCase()))
            .toList();

  late Command0<List<ArticleContent>> loadArticles;

  List<ArticleContent> _articles = [];
  List<ArticleContent> get articles => _articles;

  Future<Result<List<ArticleContent>>> _loadArticles() async {
    final result = await repository.getAllArticle();

    if (result is Ok<List<ArticleContent>>) {
      _articles = result.value;
      notifyListeners();
    }

    return result;
  }

  late Command0<void> loadBanners;

  List<BannerContent> _banners = [];
  List<BannerContent> get banners => _banners;

  Future<Result<void>> _loadBanners() async {
    final result = await repository.getAllBanner();
    if (result is Ok<List<BannerContent>>) {
      _banners = result.value;
      notifyListeners();
      return Result.ok(null);
    }
    return Result.error(Exception('Failed to fetch banners from repository'));
  }

  @override
  void dispose() {
    loadArticles.dispose();
    loadBanners.dispose();
    super.dispose();
  }
}
