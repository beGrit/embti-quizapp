import 'package:flutter/material.dart';

/// Global state to manage the behavior and appearance of the application's
/// navigation bar (e.g., branch-specific dark mode).
class AppNavBarState extends ChangeNotifier {
  int _currentSelectedIndex = 0;
  int get currentSelectedIndex => _currentSelectedIndex;

  String _currentSelectedLabel = '';
  String get currentSelectedLabel => _currentSelectedLabel;

  final Map<String, bool> _branchIsDark = {};

  bool isDark(String label) => _branchIsDark[label] ?? false;

  set currentSelectedIndex(int index) {
    _currentSelectedIndex = index;
    notifyListeners();
  }

  set currentSelectedLabel(String label) {
    _currentSelectedLabel = label;
    notifyListeners();
  }

  /// Updates the dark mode state for a specific navigation branch [label].
  void setDark(String label, bool value) {
    if (_branchIsDark[label] == value) return;
    _branchIsDark[label] = value;
    notifyListeners();
  }

  /// Resets all branches to their default light mode state.
  void reset() {
    _branchIsDark.clear();
    notifyListeners();
  }

  bool _isFullScreen = false;
  bool get isFullScreen => _isFullScreen;

  set isFullScreen(bool value) {
    if (_isFullScreen != value) {
      _isFullScreen = value;
      notifyListeners(); // This triggers the ListenableBuilder to rebuild
    }
  }
}
