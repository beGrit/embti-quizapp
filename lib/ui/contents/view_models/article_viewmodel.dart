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
}
