// lib/routing/route_config.dart
import 'package:flutter/material.dart';

enum NavigationConfigLabel {
  home('Contents'),
  explore('Explore'),
  quiz('Quiz'),
  mess('Mess'),
  me('Me');

  final String label;
  const NavigationConfigLabel(this.label);
}

class NavigationConfig {
  final IconData icon;
  final IconData selectedIcon;
  final NavigationConfigLabel label;
  final String? badgeLabel;

  const NavigationConfig({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    this.badgeLabel,
  });
}
