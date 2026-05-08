import 'package:emombti/routing/router_config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNav extends StatelessWidget {
  const ScaffoldWithNav({
    required this.navigationShell,
    required this.routeBottom,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  final List<BottomRouteConfig> routeBottom;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isDesktop = size.width >= 600;
    final bool isExtended = size.width >= 1000;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Row(
        children: [
          if (isDesktop)
            NavigationRail(
              backgroundColor: colorScheme.surfaceContainer,
              extended: isExtended,
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: (index) => navigationShell.goBranch(index),
              // Optional: Add a Gmail-like FAB or Logo at the top
              leading: isExtended
                  ? const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "eMBTI",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: FlutterLogo(),
                    ),
              destinations: [
                for (final route in routeBottom)
                  NavigationRailDestination(
                    icon: Icon(route.icon),
                    selectedIcon: Icon(route.selectedIcon),
                    label: Text(route.label),
                  ),
              ],
            ),
          // This is the main content area
          Expanded(child: navigationShell),
        ],
      ),
      // Only show bottom nav on mobile
      bottomNavigationBar: isDesktop
          ? null
          : NavigationBar(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: (index) => navigationShell.goBranch(index),
              destinations: [
                for (final route in routeBottom)
                  NavigationDestination(
                    icon: Icon(route.icon),
                    selectedIcon: Icon(route.selectedIcon),
                    label: route.label,
                  ),
              ],
            ),
    );
  }
}
