import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/repositories/feed/feed_repository.dart';
import 'package:emombti/ui/core/ui/widgets/app_bar.dart';
import 'package:emombti/ui/feed/view_models/feed_post_editor_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedPostEditor extends StatefulWidget {
  const FeedPostEditor({super.key});

  @override
  State<FeedPostEditor> createState() => _FeedPostEditorState();
}

class _FeedPostEditorState extends State<FeedPostEditor> {
  late final EditorState _editorState;
  late final EditorScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // 1. 初始化 EditorState 并提供可辨认的初始块
    _editorState = EditorState.blank(withInitialText: true);
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
              backgroundColor: Colors.white,
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
                          await viewModel.saveCommand.execute(_editorState);
                          if (context.mounted) {
                            if (viewModel.saveCommand.completed) {
                              Navigator.of(context).pop();
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
                        child: const Text('Publish'),
                      ),
                    ),
                ],
              ),
              body: Column(
                children: [
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
