import 'dart:io';

import 'package:emombti/ui/core/ui/widgets/app_bar.dart';
import 'package:emombti/ui/me/view_models/me_screen_feedback_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MeFeedbackScreen extends StatelessWidget {
  const MeFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MeFeedbackViewModel(),
      child: const _MeFeedbackScreenContent(),
    );
  }
}

class _MeFeedbackScreenContent extends StatefulWidget {
  const _MeFeedbackScreenContent();

  @override
  State<_MeFeedbackScreenContent> createState() =>
      _MeFeedbackScreenContentState();
}

class _MeFeedbackScreenContentState extends State<_MeFeedbackScreenContent> {
  late final FocusNode _titleFocusNode;
  late final FocusNode _descriptionFocusNode;
  late final FocusNode _contactFocusNode;

  @override
  void initState() {
    super.initState();
    _titleFocusNode = FocusNode();
    _descriptionFocusNode = FocusNode();
    _contactFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _contactFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MeFeedbackViewModel>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: StandardAppBar(title: 'Help & Feedback'),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Score',
                  border: OutlineInputBorder(),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                child: Slider(
                  activeColor: theme.colorScheme.primary,
                  value: viewModel.score,
                  min: 0,
                  max: 10,
                  divisions: 10,
                  label: viewModel.score.round().toString(),
                  onChanged: (value) => viewModel.score = value,
                ),
              ),
              const SizedBox(height: 16),
              DropdownMenu<FeedbackCategory>(
                initialSelection: viewModel.category,
                expandedInsets: EdgeInsets.zero,
                label: const Text('Feedback Category'),
                dropdownMenuEntries: FeedbackCategory.values.map((category) {
                  return DropdownMenuEntry<FeedbackCategory>(
                    value: category,
                    label: category.label,
                  );
                }).toList(),
                onSelected: (value) {
                  viewModel.updateCategory(value);
                  _titleFocusNode.requestFocus();
                },
              ),
              const SizedBox(height: 16),
              TextField(
                focusNode: _titleFocusNode,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                onChanged: viewModel.updateTitle,
                onSubmitted: (_) => _descriptionFocusNode.requestFocus(),
              ),
              const SizedBox(height: 16),
              TextField(
                focusNode: _descriptionFocusNode,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                maxLines: 4,
                onChanged: viewModel.updateDescription,
              ),
              const SizedBox(height: 16),
              InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Attachments (Optional, max 3)',
                  border: OutlineInputBorder(),
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
                child: SizedBox(
                  height: 80,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      ...viewModel.images.asMap().entries.map((entry) {
                        final index = entry.key;
                        final image = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Stack(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: kIsWeb
                                      ? Image.network(
                                          image.path,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          File(image.path),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () => viewModel.removeImage(index),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      if (viewModel.images.length < 3)
                        GestureDetector(
                          onTap: viewModel.pickImages,
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: const Icon(
                              Icons.add_a_photo,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                focusNode: _contactFocusNode,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'Contact Info (Optional)',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                onChanged: viewModel.updateContact,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ListenableBuilder(
                  listenable: viewModel.submitCommand,
                  builder: (context, _) {
                    return FilledButton(
                      onPressed: viewModel.submitCommand.running
                          ? null
                          : () async {
                              await viewModel.submitCommand.execute();
                              if (context.mounted) {
                                if (viewModel.submitCommand.completed) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Feedback submitted!'),
                                    ),
                                  );
                                  Navigator.of(context).pop();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Failed to submit feedback.',
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                      child: viewModel.submitCommand.running
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Submit'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
