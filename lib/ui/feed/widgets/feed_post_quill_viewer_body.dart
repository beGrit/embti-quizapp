import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class FeedPostViewerBody extends StatefulWidget {
  final String rawBody;

  const FeedPostViewerBody({super.key, required this.rawBody});

  @override
  State<FeedPostViewerBody> createState() => _FeedPostViewerBodyState();
}

class _FeedPostViewerBodyState extends State<FeedPostViewerBody> {
  late final QuillController _bodyController;

  @override
  void initState() {
    super.initState();
    _bodyController = QuillController.basic();
    _bodyController.readOnly = true;
    _bodyController.document = Document.fromJson(jsonDecode(widget.rawBody));
  }

  @override
  void dispose() {
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: QuillEditor.basic(controller: _bodyController)),
      ],
    );
  }
}
