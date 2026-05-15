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

// 🔑 必须混入 TickerProviderStateMixin 以便初始化 TabController
class _MeScreenState extends State<MeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // 初始化 3 个 Tab
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final screenSize = MediaQuery.of(context).size;

    final double headerHeight = screenSize.height > 400 ? 250 : 200;

    return ChangeNotifierProvider(
      create: (_) => MeViewModel(context.read()),
      child: Consumer<MeViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: DefaultTabController(
              length: 3,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(), // 弹性物理滚动
                slivers: [
                  SliverAppBar(
                    expandedHeight: headerHeight,
                    stretch: true,
                    pinned: true,
                    elevation: 0,
                    backgroundColor: theme.colorScheme.primary,
                    leading: widget.showBackButton ? const BackButton() : null,
                    actions: [
                      IconButton(
                        icon: Icon(
                          Icons.qr_code_scanner,
                          color: colorScheme.surfaceBright,
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
                      stretchModes: const [StretchMode.zoomBackground],
                      background: LayoutBuilder(
                        builder: (context, constraints) {
                          final double maxExtent = headerHeight;
                          final double minExtent =
                              MediaQuery.of(context).padding.top +
                              kToolbarHeight;
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
                                          ),
                                          child:
                                              viewModel.avatarUrl != null &&
                                                  viewModel
                                                      .avatarUrl!
                                                      .isNotEmpty
                                              ? Image.network(
                                                  viewModel.avatarUrl!,
                                                  width: 92,
                                                  height: 92,
                                                  fit: BoxFit.cover,
                                                  errorBuilder:
                                                      (
                                                        context,
                                                        error,
                                                        stackTrace,
                                                      ) =>
                                                          _buildInitialsFallback(
                                                            theme,
                                                            viewModel,
                                                          ),
                                                )
                                              : _buildInitialsFallback(
                                                  theme,
                                                  viewModel,
                                                ),
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
                                                color:
                                                    theme.colorScheme.tertiary,
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
                                    child: Text(
                                      viewModel.userName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),

                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverAppBarDelegate(
                      child: Container(
                        color: colorScheme.surface, // 确保吸顶后背景不透明
                        child: TabBar(
                          controller: _tabController,
                          labelColor: colorScheme.primary,
                          unselectedLabelColor: colorScheme.onSurfaceVariant,
                          indicatorColor: colorScheme.primary,
                          indicatorSize: TabBarIndicatorSize.label,
                          tabs: const [
                            Tab(text: "My Activity"),
                            Tab(text: "History"),
                            Tab(text: "About Me"),
                          ],
                        ),
                      ),
                    ),
                  ),

                  ListenableBuilder(
                    listenable: _tabController,
                    builder: (context, child) {
                      switch (_tabController.index) {
                        case 0:
                          return _buildMyActivityTab(context, theme, viewModel);
                        case 1:
                          return _buildHistoryTab(context, theme, viewModel);
                        case 2:
                          return _buildAboutMeTab(context, theme, viewModel);
                        default:
                          return const SliverToBoxAdapter(
                            child: SizedBox.shrink(),
                          );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ==================== TABS DETAILED IMPLEMENTATION ====================

  // 选项卡一：My Activity (瀑布流或动态卡片样式)
  Widget _buildMyActivityTab(
    BuildContext context,
    ThemeData theme,
    MeViewModel viewModel,
  ) {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      color: theme.colorScheme.primaryContainer.withValues(
                        alpha: 0.3,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.article_outlined,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Activity Post #$index",
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            );
          },
          childCount: 8, // 测试数据长度
        ),
      ),
    );
  }

  // 选项卡二：History (原菜单中 Testing History 等列表项的更高级展现)
  Widget _buildHistoryTab(
    BuildContext context,
    ThemeData theme,
    MeViewModel viewModel,
  ) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.tertiaryContainer,
              child: Icon(
                Icons.analytics_outlined,
                color: theme.colorScheme.tertiary,
                size: 20,
              ),
            ),
            title: Text("MBTI Test Round ${8 - index}"),
            subtitle: Text("Completed on 2026-05-${15 - index}"),
            trailing: const Icon(Icons.chevron_right, size: 18),
            onTap: () {},
          );
        }, childCount: 5),
      ),
    );
  }

  // 选项卡三：About Me (原来的常规账户和注销等菜单)
  Widget _buildAboutMeTab(
    BuildContext context,
    ThemeData theme,
    MeViewModel viewModel,
  ) {
    return SliverList(
      delegate: SliverChildListDelegate([
        const SizedBox(height: 8),
        _buildListTile(Icons.person_outline, "Account Info", () {}),
        _buildListTile(Icons.badge_outlined, "My MBTI Dimension Badges", () {}),
        _buildListTile(Icons.help_outline, "Help & Feedback", () {}),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(),
        ),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.redAccent),
          title: const Text(
            "Logout",
            style: TextStyle(color: Colors.redAccent),
          ),
          onTap: () => viewModel.logout(),
        ),
        const SizedBox(height: 50), // 底部留白
      ]),
    );
  }

  // ==================== HELPER METHODS ====================

  Widget _buildInitialsFallback(ThemeData theme, MeViewModel viewModel) {
    return Center(
      child: Text(
        viewModel.userName.isNotEmpty ? viewModel.userName[0] : "",
        style: theme.textTheme.headlineMedium,
      ),
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

// ==================== 🔑 SLIVER 吸顶辅助代理类 ====================
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({required this.child});

  final Container child;

  @override
  double get minExtent => 48.0; // TabBar 的标准固定高度
  @override
  double get maxExtent => 48.0;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
