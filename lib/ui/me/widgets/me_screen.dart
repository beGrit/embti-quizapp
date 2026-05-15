import 'package:emombti/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../view_models/me_viewmodel.dart';

class MeScreen extends StatefulWidget {
  const MeScreen({super.key, this.showBackButton = false});

  final bool showBackButton;

  @override
  State<StatefulWidget> createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final double heaherHeight;
    if (screenSize.height > 400) {
      heaherHeight = 250;
    } else {
      heaherHeight = 200;
    }
    return ChangeNotifierProvider(
      // 🔑 完美保留你原本的 ViewModel 初始化逻辑
      create: (_) => MeViewModel(context.read()),
      child: Consumer<MeViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: heaherHeight,
                  stretch: true,
                  floating: false,
                  snap: false,
                  pinned: true,
                  elevation: 0,
                  backgroundColor: theme.colorScheme.surface,
                  leading: widget.showBackButton
                      ? const BackButton(color: Colors.white)
                      : null,
                  actions: [
                    IconButton(
                      icon: const Icon(
                        Icons.qr_code_scanner,
                        color: Colors.white,
                      ),
                      onPressed: () => _openScanner(context),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.settings_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () => context.push(Routes.settings),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: const [
                      StretchMode.zoomBackground, // 下拉时放大图片
                    ],
                    background: LayoutBuilder(
                      builder: (context, constraints) {
                        final double maxExtent = heaherHeight;
                        final double minExtent =
                            MediaQuery.of(context).padding.top + kToolbarHeight;
                        final double currentHeight = constraints.maxHeight;
                        final double delta =
                            (currentHeight - minExtent) /
                            (maxExtent - minExtent);
                        final double opacity = delta.clamp(0.0, 1.0);

                        return Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              'https://cdn.pixabay.com/photo/2021/08/25/20/42/field-6574455_1280.jpg',
                              fit: BoxFit.cover,
                            ),
                            Container(
                              color: Colors.black.withValues(alpha: 0.3),
                            ),
                            Opacity(
                              opacity: opacity,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: kToolbarHeight),
                                    CircleAvatar(
                                      radius: 46,
                                      backgroundColor:
                                          theme.colorScheme.primaryContainer,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          46,
                                        ), // Matches the radius to make it a perfect circle
                                        child:
                                            viewModel.avatarUrl != null &&
                                                viewModel.avatarUrl!.isNotEmpty
                                            ? Image.network(
                                                viewModel.avatarUrl!,
                                                width: 92, // 46 radius * 2
                                                height: 92, // 46 radius * 2
                                                fit: BoxFit.cover,
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) => _buildInitialsFallback(
                                                      theme,
                                                      viewModel,
                                                    ),
                                              )
                                            : _buildInitialsFallback(
                                                theme,
                                                viewModel,
                                              ), // Fallback if URL is null/empty
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      viewModel.userName,
                                      style: theme.textTheme.titleLarge
                                          ?.copyWith(
                                            color: theme
                                                .colorScheme
                                                .surfaceContainer,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                    const SizedBox(height: 8),
                                    Chip(
                                      label: Text(
                                        viewModel.mbtiType,
                                        style: theme.textTheme.labelMedium
                                            ?.copyWith(
                                              color: theme.colorScheme.tertiary,
                                            ),
                                      ),
                                      backgroundColor:
                                          theme.colorScheme.tertiaryContainer,
                                      side: BorderSide.none,
                                      padding: EdgeInsets.zero,
                                      visualDensity: VisualDensity.compact,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (opacity < 0.2)
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: kToolbarHeight / 2,
                                  ),
                                  child: Text(viewModel.userName),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      _buildMenuSection(context, theme, viewModel),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInitialsFallback(ThemeData theme, MeViewModel viewModel) {
    return Center(
      child: Text(
        viewModel.userName.isNotEmpty ? viewModel.userName[0] : "",
        style: theme.textTheme.headlineMedium,
      ),
    );
  }

  Widget _buildMenuSection(
    BuildContext context,
    ThemeData theme,
    MeViewModel viewModel,
  ) {
    return Column(
      children: [
        _buildListTile(Icons.person_outline, "Account Info", () {}),
        _buildListTile(Icons.history, "Testing History", () {}),
        _buildListTile(Icons.favorite_border, "Saved Playlists", () {}),
        _buildListTile(Icons.help_outline, "Help & Feedback", () {}),
        const SizedBox(height: 20),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.redAccent),
          title: const Text(
            "Logout",
            style: TextStyle(color: Colors.redAccent),
          ),
          onTap: () => viewModel.logout(),
        ),
      ],
    );
  }

  Widget _buildListTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }

  // 🔑 保留你原有的扫码逻辑
  void _openScanner(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);

    final String? result = await context.push<String>(Routes.qRCodeScanner);

    if (result != null && result.isNotEmpty) {
      messenger.showSnackBar(
        SnackBar(
          content: Text('Qr Scanner Result: $result'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
