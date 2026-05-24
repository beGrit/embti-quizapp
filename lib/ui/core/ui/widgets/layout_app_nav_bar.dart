import 'package:emombti/app_state/chat_state.dart';
import 'package:emombti/app_state/theme_state.dart';
import 'package:emombti/routing/navigation_config.dart';
import 'package:emombti/ui/core/ui/view_models/layout_app_nav_bar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppLayoutNavigationBar extends StatefulWidget {
  const AppLayoutNavigationBar({
    super.key,
    required this.navigationShell,
    required this.routeBottom,
  });

  final StatefulNavigationShell navigationShell;
  final List<NavigationConfig> routeBottom;

  @override
  State<AppLayoutNavigationBar> createState() => AppLayoutNavigationBarState();
}

class AppLayoutNavigationBarState extends State<AppLayoutNavigationBar> {
  late LayoutAppNavBarViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = LayoutAppNavBarViewModel(
      configuration: widget.routeBottom,
      themeState: context.read<ThemeState>(),
      chatState: context.read<ChatState>(),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _viewModel,
      builder: (context, child) {
        return Theme(
          data: _viewModel.themeState.currentTheme,
          child: NavigationBar(
            height: 60,
            selectedIndex: widget.navigationShell.currentIndex,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: [
              for (final route in widget.routeBottom) ...[
                () {
                  String? badgeLabel =
                      _viewModel.getBadge(route.label) ?? route.badgeLabel;

                  if (route.label == 'Mess' &&
                      _viewModel.chatState.totalUnreadCount > 0) {
                    badgeLabel = _viewModel.chatState.totalUnreadCount
                        .toString();
                  }

                  return NavigationDestination(
                    icon: badgeLabel != null
                        ? Badge(
                            label: badgeLabel.isEmpty ? null : Text(badgeLabel),
                            child: Icon(route.icon),
                          )
                        : Icon(route.icon),
                    selectedIcon: badgeLabel != null
                        ? Badge(
                            label: badgeLabel.isEmpty ? null : Text(badgeLabel),
                            child: Icon(route.selectedIcon),
                          )
                        : Icon(route.selectedIcon),
                    label: route.label,
                  );
                }(),
              ],
            ],
            onDestinationSelected: (index) =>
                widget.navigationShell.goBranch(index),
          ),
        );
      },
    );
  }
}
