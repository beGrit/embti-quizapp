import 'package:emombti/data/repositories/quiz/quiz_repository.dart';
import 'package:emombti/data/repositories/quiz/quiz_repository_local.dart';
import 'package:emombti/data/repositories/quiz/survey_flow_repository.dart';
import 'package:emombti/data/repositories/quiz/survey_flow_repository_local.dart';
import 'package:emombti/data/repositories/social/social_repository.dart';
import 'package:emombti/data/repositories/social/social_repository_local.dart';
import 'package:emombti/data/services/advertising_service.dart';
import 'package:emombti/data/services/local/local_data_sqlite_service.dart';
import 'package:emombti/data/services/local/local_notification_service.dart';
import 'package:emombti/data/services/notification_service.dart';
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
import '../data/services/local/local_data_service.dart';
import '../data/services/local/local_policy_service.dart';
import '../data/services/policy_service.dart';

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
    ChangeNotifierProvider.value(value: AuthRepositoryDev() as AuthRepository),
    Provider<LocalDataService>.value(value: LocalDataService()),
    Provider<LocalDataSqliteService>.value(value: LocalDataSqliteService()),
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
