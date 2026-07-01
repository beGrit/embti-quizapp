import 'dart:convert';
import 'dart:io';

import 'package:emombti/domain/models/feed/feed.dart';
import 'package:emombti/ui/feed/view_models/feed_post_editor_viewmodel.dart';
import 'package:emombti/ui/feed/widgets/feed_post_editor_quill_toolbar.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:image_picker/image_picker.dart';

enum FeedPostEditorQuillPageMode { edit, preview, publishing }

class FeedPostEditorQuill extends StatefulWidget {
  final FeedPostEditorViewModel viewModel;
  const FeedPostEditorQuill({super.key, required this.viewModel});

  @override
  State<FeedPostEditorQuill> createState() => _FeedPostEditorQuillState();
}

class _FeedPostEditorQuillState extends State<FeedPostEditorQuill> {
  late final TextEditingController _titleController;
  late final QuillController _bodyController;
  late final FocusNode _bodyFocusNode;
  late final ImagePicker _picker;
  final List<XFile> _selectedImages = [];

  late FeedPostEditorQuillPageMode pageMode = FeedPostEditorQuillPageMode.edit;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _bodyController = QuillController.basic();
    _bodyFocusNode = FocusNode();
    _picker = ImagePicker();
    widget.viewModel.saveCommand.addListener(_onSaveCommand);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _bodyFocusNode.dispose();
    widget.viewModel.saveCommand.removeListener(_onSaveCommand);
    super.dispose();
  }

  void _onSaveCommand() {
    if (widget.viewModel.saveCommand.running) {
      setState(() {
        pageMode = FeedPostEditorQuillPageMode.publishing;
        _bodyController.readOnly = true;
      });
    } else {
      setState(() {
        pageMode = FeedPostEditorQuillPageMode.edit;
        _bodyController.readOnly = false;
      });
      if (widget.viewModel.saveCommand.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Error saving post: ${widget.viewModel.saveCommand.result}',
            ),
          ),
        );
      }
    }
  }

  SavePostParams _extractSaveParams() {
    return (
      title: _titleController.text,
      body: _bodyController.document.toDelta().toJson(),
      photos: _selectedImages,
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ListenableBuilder(
      listenable: widget.viewModel.saveCommand,
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Post Editor'),
          actions: [
            if (kDebugMode)
              IconButton(
                icon: const Icon(Icons.output),
                tooltip: 'Print Delta JSON to log',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'The JSON Delta has been printed to the console.',
                      ),
                    ),
                  );
                  debugPrint(
                    jsonEncode(_bodyController.document.toDelta().toJson()),
                  );
                },
              ),
            pageMode == FeedPostEditorQuillPageMode.publishing
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      spacing: 6,
                      children: [
                        if (pageMode == FeedPostEditorQuillPageMode.preview)
                          ElevatedButton.icon(
                            onPressed: () {
                              setState(() {
                                pageMode = FeedPostEditorQuillPageMode.edit;
                                _bodyController.readOnly = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.colorScheme.tertiary,
                              foregroundColor: theme.colorScheme.onTertiary,
                            ),
                            icon: const Icon(Icons.close),
                            label: const Text('Exit Preview'),
                          )
                        else
                          OutlinedButton(
                            onPressed: () {
                              _bodyFocusNode.unfocus();
                              setState(() {
                                pageMode = FeedPostEditorQuillPageMode.preview;
                                _bodyController.readOnly = true;
                              });
                            },
                            child: const Text('Preview'),
                          ),
                        FilledButton(
                          onPressed: () async {
                            _bodyFocusNode.unfocus();
                            await widget.viewModel.saveCommand.execute(
                              _extractSaveParams(),
                            );
                            if (context.mounted) {
                              if (widget.viewModel.saveCommand.completed) {
                                final post =
                                    (widget.viewModel.saveCommand.result
                                            as Ok<Post>)
                                        .value;
                                Navigator.of(context).pop(post);
                              }
                            }
                          },
                          child: Text('Publish'),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 120,
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                  scrollDirection: Axis.horizontal,
                  itemCount: _selectedImages.length + 1,
                  itemBuilder: (context, index) {
                    if (index == _selectedImages.length) {
                      // Hide the add button when the limit is reached.
                      if (pageMode != FeedPostEditorQuillPageMode.edit ||
                          _selectedImages.length >=
                              FeedPostEditorViewModel.maxPhotoCount) {
                        return const SizedBox.shrink();
                      }
                      return GestureDetector(
                        onTap: () async {
                          final images = await _picker.pickMultiImage();
                          if (images.isEmpty) return;

                          // Merge with already-selected to validate total.
                          final merged = [..._selectedImages, ...images];
                          final error = await widget.viewModel.validatePhotos(
                            merged,
                          );
                          if (error != null) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(SnackBar(content: Text(error)));
                            }
                            return;
                          }
                          setState(() {
                            _selectedImages.addAll(images);
                          });
                        },
                        child: Container(
                          width: 96,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: theme.colorScheme.outlineVariant,
                            ),
                          ),
                          child: Icon(
                            Icons.add_a_photo_outlined,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      );
                    }

                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 96,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: FileImage(
                                File(_selectedImages[index].path),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        if (pageMode == FeedPostEditorQuillPageMode.edit)
                          Positioned(
                            top: -4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedImages.removeAt(index);
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.error,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: theme.colorScheme.surface,
                                    width: 2,
                                  ),
                                ),
                                child: Icon(
                                  Icons.close,
                                  size: 14,
                                  color: theme.colorScheme.onError,
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
              if (pageMode == FeedPostEditorQuillPageMode.preview ||
                  pageMode == FeedPostEditorQuillPageMode.publishing) ...[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      _titleController.text,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: QuillEditor.basic(
                      controller: _bodyController,
                      focusNode: _bodyFocusNode,
                      config: QuillEditorConfig(
                        // 2. Hide the text selection cursor when previewing
                        showCursor:
                            pageMode == FeedPostEditorQuillPageMode.edit,
                      ),
                    ),
                  ),
                ),
              ],
              if (pageMode == FeedPostEditorQuillPageMode.edit) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(
                    height: 1,
                    color: theme.colorScheme.outlineVariant,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                  child: TextField(
                    controller: _titleController,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Title',
                      hintStyle: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurfaceVariant.withValues(
                          alpha: 0.4,
                        ),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(
                    height: 1,
                    color: theme.colorScheme.outlineVariant,
                  ),
                ),
                FeedPostEditorQuillToobar(controller: _bodyController),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: QuillEditor.basic(
                      controller: _bodyController,
                      focusNode: _bodyFocusNode,
                      config: QuillEditorConfig(
                        placeholder: 'Please input your post body...',
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
