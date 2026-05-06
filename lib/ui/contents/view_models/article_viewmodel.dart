import 'package:flutter/material.dart';

import '../../../data/repositories/article_content/article_content_repository.dart';
import '../../../domain/models/content/content.dart';
import '../../../utils/command.dart'; // Your new command file
import '../../../utils/result.dart';

class ArticleViewModel extends ChangeNotifier {
  ArticleViewModel(this._repository) {
    loadArticles = Command0<List<ArticleContent>>(_loadArticles);
  }

  final ArticleContentRepository _repository;

  late Command0<List<ArticleContent>> loadArticles;

  List<ArticleContent> _articles = [];
  List<ArticleContent> get articles => _articles;

  Future<Result<List<ArticleContent>>> _loadArticles() async {
    final result = await _repository.getAll();

    if (result is Ok<List<ArticleContent>>) {
      _articles = result.value;
      notifyListeners();
    }

    return result;
  }

  @override
  void dispose() {
    loadArticles.dispose();
    super.dispose();
  }
}

class ArticleDetailViewModel extends ChangeNotifier {
  ArticleDetailViewModel({
    required ArticleContentRepository repository,
    required this.articleId,
  }) : _repository = repository {
    loadArticleContent = Command0<ArticleContent?>(_loadArticle);
  }

  final String articleId;
  final ArticleContentRepository _repository;

  // The current article state
  ArticleContent _article = ArticleContent(
    id: '',
    title: '',
    createdAt: DateTime.now(),
  );
  ArticleContent get article => _article;

  late Command0<ArticleContent?> loadArticleContent;

  Future<Result<ArticleContent?>> _loadArticle() async {
    final result = await _repository.getById(articleId);

    if (result is Ok<ArticleContent?>) {
      _article =
          result.value ??
          ArticleContent(id: '', title: '', createdAt: DateTime.now());
      notifyListeners();
    }

    return result;
  }
}
