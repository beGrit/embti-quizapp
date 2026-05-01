import 'package:emombti/ui/login/widgets/login_screen.dart';
import 'package:emombti/ui/me/widgets/me_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../data/repositories/auth/auth_repository.dart';
import '../routing/router_config.dart';
import '../ui/contents/widgets/video_detail.dart';
import '../ui/core/ui/nav_bottom.dart';
import '../ui/home/widgets/home_screen.dart';
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
      path: '${Routes.home}/video/:id',
      builder: (context, state) {
        final videoId = state.pathParameters['id'] ?? '';
        return VideoDetailPage(videoId: videoId);
      },
    ),

    // 带有底部导航栏的 Shell 路由
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
        // Home Branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.home,
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        // Me Branch
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
