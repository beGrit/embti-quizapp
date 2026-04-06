import 'package:emombti/ui/contents/view_models/banner_viewmodel.dart';
import 'package:emombti/ui/contents/view_models/slideshow_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../contents/view_models/article_viewmodel.dart';
import '../../contents/widgets/article_section.dart';
import '../../contents/widgets/slideshow_section.dart';
import '../widgets/home_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: HomeAppBar(
        onSearchChanged: (value) {
          debugPrint("Searching for: $value");
        },
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      // 1. Padding is now the TOP-LEVEL child of the body
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        // 2. The ScrollView now lives inside the padding
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                // Slideshow Section
                SlideshowHomeSection(
                  viewModel: SlideshowViewModel(
                    bannerViewModel: BannerViewModel(context.read()),
                  ),
                ),
                const SizedBox(height: 16),
                // Articles Section
                ArticleHomeSection(viewModel: ArticleViewModel(context.read())),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
