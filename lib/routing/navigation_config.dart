// lib/routing/route_config.dart
import 'package:flutter/material.dart';

class NavigationConfig {
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const NavigationConfig({
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });
}
