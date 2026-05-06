import 'package:flutter/material.dart';

class MeasureSize extends StatefulWidget {
  final Widget child;
  final Function(Size size) onSizeChange;

  const MeasureSize({
    super.key,
    required this.onSizeChange,
    required this.child,
  });

  @override
  State<MeasureSize> createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        widget.onSizeChange(context.size!);
      }
    });
    return widget.child;
  }
}
