import 'package:emombti/app_state/app_nav_bar.dart';
import 'package:emombti/app_state/chat.dart';
import 'package:emombti/app_state/theme.dart';
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
      navBarState: context.read<AppNavBarState>(),
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
        final themeState = context.read<ThemeState>();
        return Theme(
          data:
              _viewModel.isDark(
                widget
                    .routeBottom[widget.navigationShell.currentIndex]
                    .label
                    .label,
              )
              ? themeState.materialTheme.dark()
              : themeState.currentTheme,
          child: NavigationBar(
            height: 60,
            selectedIndex: widget.navigationShell.currentIndex,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            destinations: [
              for (final route in widget.routeBottom) ...[
                () {
                  String? badgeLabel =
                      _viewModel.getBadge(route.label.label) ??
                      route.badgeLabel;

                  if (route.label == NavigationConfigLabel.mess &&
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
                    label: route.label.label,
                  );
                }(),
              ],
            ],
            onDestinationSelected: (index) {
              widget.navigationShell.goBranch(index);
              _viewModel.appNavBarState.currentSelectedIndex = index;
              _viewModel.appNavBarState.currentSelectedLabel =
                  widget.routeBottom[index].label.label;
            },
          ),
        );
      },
    );
  }
}
