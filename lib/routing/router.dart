import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/routing/router_config.dart';
import 'package:emombti/ui/contents/view_models/article_viewmodel.dart';
import 'package:emombti/ui/contents/widgets/article_section.dart';
import 'package:emombti/ui/core/ui/nav_bottom.dart';
import 'package:emombti/ui/core/ui/widgets/under_development.dart';
import 'package:emombti/ui/home/widgets/home_screen.dart';
import 'package:emombti/ui/login/widgets/login_screen.dart';
import 'package:emombti/ui/me/widgets/me_screen.dart';
import 'package:emombti/ui/social/view_models/social_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'routes.dart';

GoRouter router(AuthRepository authRepository) => GoRouter(
  initialLocation: Routes.login,
  refreshListenable: authRepository,
  redirect: _redirect,
  routes: [
    // Login Route
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    // Me Standalone Route
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

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNav(
          navigationShell: navigationShell,
          routeBottom: [
            BottomRouteConfig(
              path: Routes.home,
              builder: (context, state) => const HomeScreen(),
              icon: Icons.explore_outlined,
              selectedIcon: Icons.explore,
              label: 'Home',
            ),
            BottomRouteConfig(
              path: Routes.social,
              builder: (context, state) =>
                  const UnderDevelopmentScreen(title: 'Social'),
              icon: Icons.people_outline,
              selectedIcon: Icons.people,
              label: 'Social',
            ),
            BottomRouteConfig(
              path: Routes.connections,
              builder: (context, state) =>
                  const UnderDevelopmentScreen(title: 'Conn'),
              icon: Icons.hub_outlined,
              selectedIcon: Icons.hub,
              label: 'Conn',
            ),
            BottomRouteConfig(
              path: Routes.messaging,
              builder: (context, state) =>
                  const UnderDevelopmentScreen(title: 'Mess'),
              icon: Icons.chat_bubble_outline,
              selectedIcon: Icons.chat_bubble,
              label: 'Mess',
            ),
            BottomRouteConfig(
              path: Routes.me,
              builder: (context, state) => const MeScreen(),
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
              path: Routes.social,
              builder: (context, state) =>
                  const UnderDevelopmentScreen(title: 'Social'),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.connections,
              builder: (context, state) =>
                  const UnderDevelopmentScreen(title: 'Conn'),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.messaging,
              builder: (context, state) =>
                  const UnderDevelopmentScreen(title: 'Mes'),
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
