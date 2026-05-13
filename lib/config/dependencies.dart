import 'package:emombti/data/repositories/quiz/quiz_repository.dart';
import 'package:emombti/data/repositories/quiz/quiz_repository_local.dart';
import 'package:emombti/data/repositories/social/social_repository.dart';
import 'package:emombti/data/repositories/social/social_repository_local.dart';
import 'package:emombti/data/services/local/local_notification_service.dart';
import 'package:emombti/data/services/notification_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/repositories/article_content/article_content_repository.dart';
import '../data/repositories/article_content/article_content_repository_local.dart';
import '../data/repositories/auth/auth_repository.dart';
import '../data/repositories/auth/auth_repository_dev.dart';
import '../data/repositories/banner_content/banner_content_repository.dart';
import '../data/repositories/banner_content/banner_content_repository_local.dart';
import '../data/repositories/video_content/video_content_repository.dart';
import '../data/repositories/video_content/video_content_repository_local.dart';
import '../data/services/local/local_data_service.dart';
import '../data/services/local/local_policy_service.dart';
import '../data/services/policy_service.dart';

List<SingleChildWidget> _sharedProviders = [];

List<SingleChildWidget> get providersLocal {
  return [
    ..._sharedProviders,
    ChangeNotifierProvider.value(value: AuthRepositoryDev() as AuthRepository),
    Provider<LocalDataService>.value(value: LocalDataService()),
    Provider<ArticleContentRepository>(
      create: (context) =>
          ArticleContentRepositoryLocal(localDataService: context.read())
              as ArticleContentRepository,
    ),
    Provider<BannerContentRepository>(
      create: (context) =>
          BannerContentRepositoryLocal(localDataService: context.read())
              as BannerContentRepository,
    ),
    Provider<VideoContentRepository>(
      create: (context) =>
          VideoContentRepositoryLocal(localDataService: context.read())
              as VideoContentRepository,
    ),
    Provider<SocialRepository>(
      create: (context) => SocialRepositoryLocal() as SocialRepository,
    ),
    Provider<QuizRepository>(
      create: (context) =>
          QuizRepositoryLocal(localDataService: context.read())
              as QuizRepository,
    ),
    Provider<PolicyService>(create: (context) => LocalPolicyService()),
    Provider<NotificationService>(
      create: (context) => LocalNotificationService(),
    ),
  ];
}

List<SingleChildWidget> get providersRemote {
  return [..._sharedProviders];
}
