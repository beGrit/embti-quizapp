import 'package:flutter/material.dart';

class ContentAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ContentAppBar({super.key, required this.title});

  final String title;

  @override
  State<ContentAppBar> createState() => _ContentAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ContentAppBarState extends State<ContentAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(widget.title));
  }
}
