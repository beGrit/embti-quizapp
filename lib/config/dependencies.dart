import 'package:emombti/data/repositories/chat/chat_repository.dart';
import 'package:emombti/data/repositories/chat/chat_repository_dev.dart';
import 'package:emombti/data/repositories/feed/feed_repository.dart';
import 'package:emombti/data/repositories/feed/feed_repository_dev.dart';
import 'package:emombti/data/repositories/quiz/quiz_repository.dart';
import 'package:emombti/data/repositories/quiz/quiz_repository_local.dart';
import 'package:emombti/data/repositories/quiz/survey_flow_repository.dart';
import 'package:emombti/data/repositories/quiz/survey_flow_repository_local.dart';
import 'package:emombti/data/repositories/social/social_repository.dart';
import 'package:emombti/data/repositories/social/social_repository_local.dart';
import 'package:emombti/data/repositories/user/user_repository.dart';
import 'package:emombti/data/repositories/user/user_repository_dev.dart';
import 'package:emombti/data/services/common/advertising_service.dart';
import 'package:emombti/data/services/common/notification_service.dart';
import 'package:emombti/data/services/common/notification_service_local.dart';
import 'package:emombti/data/services/persistence/api/pocketbase_service.dart';
import 'package:emombti/data/services/persistence/local/local_data_sqlite_service.dart';
import 'package:emombti/ui/core/themes/theme.dart';
import 'package:emombti/ui/core/themes/theme_util.dart';
import 'package:flutter/material.dart';
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
import '../data/services/common/policy_service.dart';
import '../data/services/common/policy_service_local.dart';
import '../data/services/persistence/local/local_data_service.dart';

List<SingleChildWidget> _sharedProviders = [
  ChangeNotifierProvider<ThemeController>(
    create: (context) {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;

      final materialTheme = MaterialTheme(
        createTextTheme(context, "Noto Sans", "Noto Sans"),
      );

      return ThemeController(
        materialTheme: materialTheme,
        currentPlatformBrightness: brightness,
      );
    },
  ),
];
List<SingleChildWidget> get providersLocal {
  return [
    ..._sharedProviders,
    Provider<LocalDataService>.value(value: LocalDataService()),
    Provider<LocalDataSqliteService>.value(value: LocalDataSqliteService()),
    Provider<PocketBaseService>(create: (context) => PocketBaseService()),
    ChangeNotifierProvider<AuthRepository>(
      create: (context) => AuthRepositoryDev(pbService: context.read()),
    ),
    Provider<UserRepository>(
      create: (context) => UserRepositoryDev(pbService: context.read()),
    ),
    Provider<ChatRepository>(
      create: (context) => ChatRepositoryDev(pbService: context.read()),
    ),
    Provider<FeedRepository>(
      create: (context) => FeedRepositoryDev(pbService: context.read()),
    ),
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
          QuizRepositoryLocal(
                localDataService: context.read(),
                localDataSqliteService: context.read(),
              )
              as QuizRepository,
    ),
    Provider<SurveyFlowRepository>(
      create: (context) => SurveyFlowRepositoryLocal() as SurveyFlowRepository,
    ),
    Provider<PolicyService>(create: (context) => LocalPolicyService()),
    Provider<NotificationService>(
      create: (context) {
        LocalNotificationService service = LocalNotificationService();
        service.init().then((_) {
          service.requestPermissions();
        });
        return service as NotificationService;
      },
    ),
    Provider<AdvertisingService>(create: (context) => AdvertisingService()),
  ];
}

List<SingleChildWidget> get providersRemote {
  return [..._sharedProviders];
}
