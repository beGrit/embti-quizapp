import 'package:emombti/app_state/chat_state.dart';
import 'package:emombti/app_state/theme_state.dart';
import 'package:emombti/routing/navigation_config.dart';
import 'package:flutter/material.dart';

class LayoutAppNavBarViewModel extends ChangeNotifier {
  final List<NavigationConfig> _configuration;
  final ThemeState _themeState;
  final ChatState _chatState;
  final Map<String, String?> _badgeCounts = {};

  LayoutAppNavBarViewModel({
    required List<NavigationConfig> configuration,
    required ThemeState themeState,
    required ChatState chatState,
  }) : _configuration = configuration,
       _themeState = themeState,
       _chatState = chatState {
    // Initialize standard state setup
    for (var config in _configuration) {
      _badgeCounts[config.label] = null;
    }

    // Sync badge data with the current state initially
    _syncChatBadges();

    // Attach native listeners to watch your global app states
    _chatState.addListener(_onChatStateChanged);
    _themeState.addListener(_onThemeStateChanged);
  }

  List<NavigationConfig> get configuration => _configuration;
  ThemeState get themeState => _themeState;
  ChatState get chatState => _chatState;

  String? getBadge(String label) => _badgeCounts[label];

  /// Internal handler called automatically when ChatState triggers notifyListeners()
  void _onChatStateChanged() {
    _syncChatBadges();
  }

  /// Internal handler called automatically when ThemeState triggers notifyListeners()
  void _onThemeStateChanged() {
    // If your navigation bar depends on specific ThemeState properties,
    // update them here before notifying the bar's listeners.
    notifyListeners();
  }

  /// Evaluates and recalculates the badge values based on ChatState data
  void _syncChatBadges() {
    bool hasChanged = false;

    for (var config in _configuration) {
      if (config.label == 'Mess') {
        final targetValue = _chatState.totalUnreadCount > 0
            ? _chatState.totalUnreadCount.toString()
            : null;

        if (_badgeCounts[config.label] != targetValue) {
          _badgeCounts[config.label] = targetValue;
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
    _themeState.removeListener(_onThemeStateChanged);
    super.dispose();
  }
}
