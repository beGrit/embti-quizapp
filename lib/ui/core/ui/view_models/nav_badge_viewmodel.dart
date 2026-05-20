import 'package:emombti/routing/navigation_config.dart';
import 'package:flutter/material.dart';

class NavBadgeViewmodel extends ChangeNotifier {
  NavBadgeViewmodel({required List<NavigationConfig> configuration})
    : _configuration = configuration {
    for (var config in configuration) {
      _badgeCounts[config.label] = null;
    }
  }

  final List<NavigationConfig> _configuration;

  List<NavigationConfig> get configuration => _configuration;

  final Map<String, String?> _badgeCounts = {};

  String? getBadge(String label) => _badgeCounts[label];

  void updateBadge(String label, String? value) {
    if (!_badgeCounts.containsKey(label)) return;

    if (_badgeCounts[label] == value) return;
    _badgeCounts[label] = value;
    notifyListeners();
  }

  void clearBadge(String label) => updateBadge(label, null);
}
