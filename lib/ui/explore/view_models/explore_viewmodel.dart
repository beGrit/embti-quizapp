import 'package:emombti/app_state/app_nav_bar.dart';
import 'package:emombti/routing/navigation_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Stable route-like id for an Explore top tab (used for body selection and analytics).
abstract final class ExploreTabIds {
  ExploreTabIds._();

  static const shares = 'shares';
  static const videos = 'videos';
  static const friends = 'friends';
  static const chatAiMbti = 'chat_ai_mbti';
}

enum ExploreTabType { shares, videos, friends, chatAiMbti, placeholder }

@immutable
class ExploreTab {
  const ExploreTab({
    required this.id,
    required this.label,
    required this.type,
    required this.themeMode,
  });

  final String id;
  final String label;
  final ExploreTabType type;
  final ThemeMode themeMode;
}

/// UI state for the Explore shell (tab selection).
class ExploreViewModel extends ChangeNotifier {
  ExploreViewModel({required AppNavBarState appNavBarState})
    : _appNavBarState = appNavBarState,
      tabs = const [
        ExploreTab(
          id: ExploreTabIds.chatAiMbti,
          label: 'Chat with AI(MBTI)',
          type: ExploreTabType.chatAiMbti,
          themeMode: ThemeMode.light,
        ),
        ExploreTab(
          id: ExploreTabIds.shares,
          label: 'Shares',
          type: ExploreTabType.shares,
          themeMode: ThemeMode.light,
        ),
        ExploreTab(
          id: ExploreTabIds.videos,
          label: 'Videos',
          type: ExploreTabType.videos,
          themeMode: ThemeMode.dark,
        ),
      ];

  final List<ExploreTab> tabs;
  final AppNavBarState _appNavBarState;

  int _selectedTabIndex = 0;
  int get selectedTabIndex => _selectedTabIndex;

  void selectTab(int index) {
    if (index < 0 || index >= tabs.length) return;
    if (_selectedTabIndex == index) return;
    _selectedTabIndex = index;
    notifyListeners();
  }

  void onTabAnimation(int targetIndex) {
    if (tabs[targetIndex].themeMode == ThemeMode.dark) {
      _appNavBarState.setDark(NavigationConfigLabel.explore.label, true);
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      );
    } else {
      _appNavBarState.setDark(NavigationConfigLabel.explore.label, false);
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      );
    }
  }
}
