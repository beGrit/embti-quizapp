import 'package:flutter/material.dart';

import '../view_models/feed_post_viewmodel.dart';

class FeedPostViewerBodyPreview extends StatelessWidget {
  final String? initialJson;
  final int maxLines;
  final FeedPostViewModel viewModel;

  const FeedPostViewerBodyPreview({
    super.key,
    required this.initialJson,
    required this.viewModel,
    this.maxLines = 3,
  });

  @override
  Widget build(BuildContext context) {
    final String plainText = viewModel.getPlainTextFromAppFlowyJson(
      initialJson,
      maxLines: maxLines,
    );

    return Text(
      plainText.isNotEmpty ? plainText : '...',
      style: TextStyle(fontSize: 14, color: Colors.grey.shade700, height: 1.4),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
