import 'dart:io';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/repositories/feed/feed_repository.dart';
import 'package:emombti/domain/models/feed/feed.dart';
import 'package:emombti/ui/core/ui/widgets/app_bar.dart';
import 'package:emombti/ui/feed/view_models/feed_post_editor_viewmodel.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FeedPostEditor extends StatefulWidget {
  const FeedPostEditor({super.key});

  @override
  State<FeedPostEditor> createState() => _FeedPostEditorState();
}

class _FeedPostEditorState extends State<FeedPostEditor> {
  late final EditorState _editorState;
  late final EditorScrollController _scrollController;
  late final TextEditingController _titleController;
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _selectedImages = [];

  @override
  void initState() {
    super.initState();
    // 1. 初始化 EditorState 并提供可辨认的初始块
    _editorState = EditorState.blank(withInitialText: true);
    _scrollController = EditorScrollController(editorState: _editorState);
    _titleController = TextEditingController();
  }

  @override
  void dispose() {
    _editorState.dispose();
    _scrollController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (context) => FeedPostEditorViewModel(
        authRepository: context.read<AuthRepository>(),
        feedRepository: context.read<FeedRepository>(),
      ),
      child: Consumer<FeedPostEditorViewModel>(
        builder: (context, viewModel, child) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) return;
            },
            child: Scaffold(
              backgroundColor: theme.colorScheme.surface,
              appBar: StandardAppBar(
                title: '',
                leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
                actions: [
                  if (viewModel.saveCommand.running)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: FilledButton(
                        onPressed: () async {
                          await viewModel.saveCommand.execute((
                            title: _titleController.text,
                            body: _editorState.document.toJson(),
                            photos: _selectedImages,
                          ));
                          if (context.mounted) {
                            if (viewModel.saveCommand.completed) {
                              final post =
                                  (viewModel.saveCommand.result as Ok<Post>)
                                      .value;
                              Navigator.of(context).pop(post);
                            } else if (viewModel.saveCommand.error) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Error saving post: ${viewModel.saveCommand.result}',
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        child: Text('Publish'),
                      ),
                    ),
                ],
              ),
              body: Column(
                children: [
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                      scrollDirection: Axis.horizontal,
                      itemCount: _selectedImages.length + 1,
                      itemBuilder: (context, index) {
                        if (index == _selectedImages.length) {
                          return GestureDetector(
                            onTap: () async {
                              final images = await _picker.pickMultiImage();
                              if (images.isNotEmpty) {
                                setState(() {
                                  _selectedImages.addAll(images);
                                });
                              }
                            },
                            child: Container(
                              width: 96,
                              decoration: BoxDecoration(
                                color:
                                    theme.colorScheme.surfaceContainerHighest,
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
                      maxLines: null,
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
                  Expanded(
                    child: AppFlowyEditor(
                      editorState: _editorState,
                      editorScrollController: _scrollController,
                      editorStyle: const EditorStyle.mobile(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10.0,
                        ),
                        cursorColor: Colors.green,
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.grey.shade50,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: MobileToolbar(
                      editorState: _editorState,
                      toolbarItems: [
                        MobileToolbarItem.action(
                          itemIconBuilder: (context, editorState, service) {
                            final isBold =
                                editorState.toggledStyle.bold == true;
                            return Icon(
                              Icons.format_bold,
                              color: isBold ? Colors.green : Colors.black87,
                            );
                          },
                          actionHandler: (context, editorState) {
                            editorState.toggleAttribute(
                              AppFlowyRichTextKeys.bold,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
