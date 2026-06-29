import 'package:flutter/material.dart';

class FeedPostViewerBodyPreview extends StatelessWidget {
  final String text;
  final int maxLines;

  const FeedPostViewerBodyPreview({
    super.key,
    required this.text,
    this.maxLines = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 14, color: Colors.grey.shade700, height: 1.4),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
