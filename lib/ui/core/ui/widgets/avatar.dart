import 'package:flutter/material.dart';

class AppBarAvatar extends StatefulWidget {
  final Widget child;
  final double size;

  const AppBarAvatar({super.key, required this.child, this.size = 46.0});

  @override
  State<AppBarAvatar> createState() => _AppBarAvatarState();
}

class _AppBarAvatarState extends State<AppBarAvatar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: widget.child,
    );
  }
}
