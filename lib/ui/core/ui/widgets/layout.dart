import 'package:emombti/routing/navigation_config.dart';
import 'package:emombti/ui/core/ui/widgets/layout_app_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({
    required this.navigationShell,
    required this.routeBottom,
    super.key,
  });

  final StatefulNavigationShell navigationShell;
  final List<NavigationConfig> routeBottom;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isDesktop = size.width >= 600;
    final bool isExtended = size.width >= 1000;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
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
                    icon: route.badgeLabel != null
                        ? Badge(
                            label: route.badgeLabel!.isEmpty
                                ? null
                                : Text(route.badgeLabel!),
                            child: Icon(route.icon),
                          )
                        : Icon(route.icon),
                    selectedIcon: route.badgeLabel != null
                        ? Badge(
                            label: route.badgeLabel!.isEmpty
                                ? null
                                : Text(route.badgeLabel!),
                            child: Icon(route.selectedIcon),
                          )
                        : Icon(route.selectedIcon),
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
          : NavigationBarTheme(
              data: NavigationBarThemeData(
                indicatorShape: null,
                iconTheme: WidgetStateProperty.all(
                  const IconThemeData(size: 24),
                ),
                labelTextStyle: WidgetStateProperty.all(
                  textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                labelPadding: EdgeInsets.zero,
              ),
              child: AppLayoutNavigationBar(
                navigationShell: navigationShell,
                routeBottom: routeBottom,
              ),
            ),
    );
  }
}
