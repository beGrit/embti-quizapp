import 'package:emombti/routing/router_config.dart';
import 'package:emombti/ui/home/widgets/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/core/ui/nav_bottom.dart';
import 'routes.dart';

final List<BottomRouteConfig> routeBottom = [
  BottomRouteConfig(
    path: Routes.home,
    builder: (context, state) => const HomeScreen(),
    icon: Icons.explore_outlined,
    selectedIcon: Icons.explore,
    label: 'Home',
  ),
  BottomRouteConfig(
    path: Routes.login,
    builder: (context, state) => const Center(child: Text("Login Screen")),
    icon: Icons.storage_outlined,
    selectedIcon: Icons.storage,
    label: 'Login',
  ),
];

GoRouter router() => GoRouter(
  initialLocation: Routes.home,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNav(
          navigationShell: navigationShell,
          routeBottom: routeBottom,
        );
      },
      branches: [
        for (var route in routeBottom)
          StatefulShellBranch(
            routes: [
              GoRoute(path: route.path, builder: route.builder, routes: []),
            ],
          ),
      ],
    ),
  ],
);
