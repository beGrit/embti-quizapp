import 'package:emombti/app_state/app_nav_bar.dart';
import 'package:emombti/app_state/chat.dart';
import 'package:emombti/app_state/theme.dart';
import 'package:emombti/routing/navigation_config.dart';
import 'package:flutter/material.dart';

class LayoutAppNavBarViewModel extends ChangeNotifier {
  final List<NavigationConfig> _configuration;
  final ChatState _chatState;
  final AppNavBarState _navBarState;
  final Map<String, String?> _badgeCounts = {};

  LayoutAppNavBarViewModel({
    required List<NavigationConfig> configuration,
    required ThemeState themeState,
    required ChatState chatState,
    required AppNavBarState navBarState,
  }) : _configuration = configuration,
       _chatState = chatState,
       _navBarState = navBarState {
    // Initialize standard state setup
    for (var config in _configuration) {
      _badgeCounts[config.label.label] = null;
    }

    // Sync badge data with the current state initially
    _syncChatBadges();

    // Attach native listeners to watch your global app states
    _chatState.addListener(_onChatStateChanged);
    _navBarState.addListener(_onNavBarStateChanged);
  }

  List<NavigationConfig> get configuration => _configuration;
  ChatState get chatState => _chatState;
  AppNavBarState get appNavBarState => _navBarState;

  String? getBadge(String label) => _badgeCounts[label];
  bool isDark(String label) => _navBarState.isDark(label);

  /// Internal handler called automatically when ChatState triggers notifyListeners()
  void _onChatStateChanged() {
    _syncChatBadges();
  }

  /// Internal handler called automatically when AppNavBarState triggers notifyListeners()
  void _onNavBarStateChanged() {
    notifyListeners();
  }

  /// Evaluates and recalculates the badge values based on ChatState data
  void _syncChatBadges() {
    bool hasChanged = false;

    for (var config in _configuration) {
      if (config.label == NavigationConfigLabel.mess) {
        final targetValue = _chatState.totalUnreadCount > 0
            ? _chatState.totalUnreadCount.toString()
            : null;

        if (_badgeCounts[config.label.label] != targetValue) {
          _badgeCounts[config.label.label] = targetValue;
          hasChanged = true;
        }
      }
    }

    // Only notify UI layers if a badge string actually shifted
    if (hasChanged) {
      notifyListeners();
    }
  }

  void updateBadge(String label, String? value) {
    if (!_badgeCounts.containsKey(label)) return;
    if (_badgeCounts[label] == value) return;

    _badgeCounts[label] = value;
    notifyListeners();
  }

  void clearBadge(String label) => updateBadge(label, null);

  /// CRITICAL: Removes listeners to prevent memory leaks when this ViewModel is destroyed.
  @override
  void dispose() {
    _chatState.removeListener(_onChatStateChanged);
    _navBarState.removeListener(_onNavBarStateChanged);
    super.dispose();
  }
}
