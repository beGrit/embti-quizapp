// lib/routing/route_config.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomRouteConfig {
  final String path;
  final Widget Function(BuildContext, GoRouterState) builder;
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  const BottomRouteConfig({
    required this.path,
    required this.builder,
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });
}
