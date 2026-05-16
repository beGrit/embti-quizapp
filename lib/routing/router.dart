import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/domain/models/chat/chat.dart';
import 'package:emombti/routing/navigation_config.dart';
import 'package:emombti/ui/chat/widgets/room_detail_screen.dart';
import 'package:emombti/ui/chat/widgets/rooms_screen.dart';
import 'package:emombti/ui/contents/view_models/article_viewmodel.dart';
import 'package:emombti/ui/contents/widgets/article_section.dart';
import 'package:emombti/ui/core/ui/widgets/layout.dart';
import 'package:emombti/ui/core/ui/widgets/under_development.dart';
import 'package:emombti/ui/explore/view_models/explore_viewmodel.dart';
import 'package:emombti/ui/explore/widgets/explore_screen.dart';
import 'package:emombti/ui/home/widgets/home_screen.dart';
import 'package:emombti/ui/login/view_models/login_viewmodel.dart';
import 'package:emombti/ui/login/widgets/login_screen.dart';
import 'package:emombti/ui/me/widgets/me_screen.dart';
import 'package:emombti/ui/qr_code/widgets/qr_code_scanner.dart';
import 'package:emombti/ui/quiz/view_models/survey_flow_viewmodel.dart';
import 'package:emombti/ui/quiz/widgets/quiz_landing.dart';
import 'package:emombti/ui/quiz/widgets/survey_flow.dart';
import 'package:emombti/ui/settings/widgets/settings_screen.dart';
import 'package:emombti/ui/social/view_models/social_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'routes.dart';

GoRouter router(AuthRepository authRepository) => GoRouter(
  initialLocation: Routes.home,
  refreshListenable: authRepository,
  redirect: _redirect,
  routes: [
    // Login Route
    GoRoute(
      path: Routes.login,
      builder: (context, state) => LoginScreen(
        viewModel: LoginViewModel(
          repository: context.read(),
          userRepository: context.read(),
        ),
      ),
    ),
    // Me Standalone Route
    GoRoute(
      path: Routes.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: Routes.qRCodeScanner,
      builder: (context, state) => QRCodeScanner(),
    ),
    // Settings Route
    GoRoute(
      path: Routes.meStandalone,
      builder: (context, state) => const MeScreen(showBackButton: true),
    ),
    // Video Detail Route
    GoRoute(
      path: '${Routes.video}/:id',
      builder: (context, state) {
        return const UnderDevelopmentScreen(title: 'Video Detail');
      },
    ),
    GoRoute(
      path: '${Routes.article}/:id',
      builder: (context, state) {
        final articleId = state.pathParameters['id'] ?? '';
        return ArticleDetailScreen(
          viewModel: ArticleDetailViewModel(
            repository: context.read(),
            articleId: articleId,
          ),
          socialViewModel: SocialViewModel(
            repository: context.read(),
            relatedId: articleId,
          ),
        );
      },
    ),
    // Survey Flow Route
    GoRoute(
      path: Routes.surveyFlow,
      builder: (context, state) {
        final surveyId = state.uri.queryParameters['surveyId'] ?? '';
        final flowId = state.uri.queryParameters['flowId'] ?? '';
        return SurveyFlowScreen(
          viewModel: SurveyFlowViewModel(
            surveyFlowRepository: context.read(),
            quizRepository: context.read(),
            flowId: flowId,
            surveyId: surveyId,
          ),
        );
      },
    ),
    // Survey Result Route
    GoRoute(
      path: '${Routes.surveyResult}/:id',
      builder: (context, state) {
        return const UnderDevelopmentScreen(title: 'Survey Result');
      },
    ),
    GoRoute(
      path: '${Routes.chatRooms}/:id',
      builder: (context, state) {
        final room = state.extra as Room;
        return RoomDetailScreen(room: room);
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppLayout(
          navigationShell: navigationShell,
          routeBottom: [
            NavigationConfig(
              icon: Icons.explore_outlined,
              selectedIcon: Icons.explore,
              label: 'Home',
            ),
            NavigationConfig(
              icon: Icons.people_outline,
              selectedIcon: Icons.people,
              label: 'Explore',
            ),
            NavigationConfig(
              icon: Icons.hub_outlined,
              selectedIcon: Icons.hub,
              label: 'Quiz',
            ),
            NavigationConfig(
              icon: Icons.chat_bubble_outline,
              selectedIcon: Icons.chat_bubble,
              label: 'Mess',
            ),
            NavigationConfig(
              icon: Icons.storage_outlined,
              selectedIcon: Icons.storage,
              label: 'Me',
            ),
          ],
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.home,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.explore,
              builder: (context, state) =>
                  ExploreScreen(viewModel: ExploreViewModel()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.quizLanding,
              builder: (context, state) => QuizLandingScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.chatRooms,
              builder: (context, state) => RoomsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.me,
              builder: (context, state) => const MeScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  final bool isLoggedIn = await context.read<AuthRepository>().isAuthenticated;
  final bool isLogin = state.matchedLocation == Routes.login;
  if (!isLoggedIn) {
    return Routes.login;
  }
  if (isLogin) {
    return Routes.home;
  }
  return null;
}
