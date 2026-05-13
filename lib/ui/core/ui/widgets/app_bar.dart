import 'package:flutter/material.dart';

class StandardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final double height;

  const StandardAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.height = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      toolbarHeight: height,
      backgroundColor: theme.colorScheme.surfaceContainer,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: leading,
      title: Text(
        title,
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
