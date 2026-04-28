import 'package:emombti/ui/login/widgets/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../data/repositories/auth/auth_repository.dart';
import '../routing/router_config.dart';
import '../ui/core/ui/nav_bottom.dart';
import '../ui/home/widgets/home_screen.dart';
import 'routes.dart';

GoRouter router(AuthRepository authRepository) => GoRouter(
  initialLocation: Routes.home,
  refreshListenable: authRepository,
  redirect: _redirect,
  routes: [
    // Routes for normal
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const LoginScreen(),
    ),

    // Routes for the bottom nav
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
              builder: (context, state) =>
                  const Center(child: Text("About Me Screen")),
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
              builder: (context, state) =>
                  const Center(child: Text("About Me Screen")),
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
