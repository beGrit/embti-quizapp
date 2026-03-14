import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/repositories/article_content/article_content_repository.dart';
import '../data/repositories/article_content/article_content_repository_local.dart';
import '../data/services/local/local_data_service.dart';

List<SingleChildWidget> _sharedProviders = [];

List<SingleChildWidget> get providersLocal {
  return [
    ..._sharedProviders,
    Provider<LocalDataService>.value(value: LocalDataService()),
    Provider<ArticleContentRepository>(
      create: (context) =>
          ArticleContentRepositoryLocal(localDataService: context.read())
              as ArticleContentRepository,
    ),
  ];
}

List<SingleChildWidget> get providersRemote {
  return [..._sharedProviders];
}
