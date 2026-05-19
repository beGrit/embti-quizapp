import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';

class FeedPostViewer extends StatefulWidget {
  final Map<String, dynamic> initialJson;

  const FeedPostViewer({super.key, required this.initialJson});

  @override
  State<FeedPostViewer> createState() => _FeedPostViewerState();
}

class _FeedPostViewerState extends State<FeedPostViewer> {
  late final EditorState _editorState;
  late final EditorScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // 1. Load the state from the saved JSON map
    _editorState = EditorState(document: Document.fromJson(widget.initialJson));
    _scrollController = EditorScrollController(editorState: _editorState);
  }

  @override
  void dispose() {
    _editorState.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppFlowyEditor(
      editorState: _editorState,
      editorScrollController: _scrollController,
      editable: false,
      editorStyle: const EditorStyle.mobile(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      ),
    );
  }
}
