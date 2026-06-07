import 'package:emombti/data/repositories/content/content_repository.dart';
import 'package:emombti/domain/models/content/content.dart';
import 'package:emombti/utils/command.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';

class ArticleDetailViewModel extends ChangeNotifier {
  ArticleDetailViewModel({
    required ContentRepository repository,
    required this.articleId,
  }) : _repository = repository {
    loadArticleContent = Command0<ArticleContent?>(_loadArticle);
  }

  final String articleId;
  final ContentRepository _repository;

  // The current article state
  ArticleContent _article = ArticleContent(
    id: '',
    title: '',
    createdAt: DateTime.now(),
  );
  ArticleContent get article => _article;

  late Command0<ArticleContent?> loadArticleContent;

  Future<Result<ArticleContent?>> _loadArticle() async {
    final result = await _repository.getArticleById(articleId);

    if (result is Ok<ArticleContent?>) {
      _article =
          result.value ??
          ArticleContent(id: '', title: '', createdAt: DateTime.now());
      notifyListeners();
    }

    return result;
  }
}
