import 'package:flutter/material.dart';

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
    this.themeDataName,
  });

  final String id;
  final String label;
  final ExploreTabType type;
  final String? themeDataName;
}

/// UI state for the Explore shell (tab selection).
class ExploreViewModel extends ChangeNotifier {
  ExploreViewModel({List<ExploreTab>? tabs})
    : tabs =
          tabs ??
          const [
            ExploreTab(
              id: ExploreTabIds.shares,
              label: 'Shares',
              type: ExploreTabType.shares,
            ),
            ExploreTab(
              id: ExploreTabIds.videos,
              label: 'Videos',
              type: ExploreTabType.videos,
              themeDataName: 'dark',
            ),
            ExploreTab(
              id: ExploreTabIds.friends,
              label: 'Friends',
              type: ExploreTabType.friends,
            ),
            ExploreTab(
              id: ExploreTabIds.chatAiMbti,
              label: 'Chat with AI(MBTI)',
              type: ExploreTabType.chatAiMbti,
            ),
          ];

  final List<ExploreTab> tabs;

  int _selectedTabIndex = 0;
  int get selectedTabIndex => _selectedTabIndex;

  void selectTab(int index) {
    if (index < 0 || index >= tabs.length) return;
    if (_selectedTabIndex == index) return;
    _selectedTabIndex = index;
    notifyListeners();
  }
}
