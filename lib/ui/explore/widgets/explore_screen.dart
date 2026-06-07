import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/repositories/feed/feed_repository.dart';
import 'package:emombti/ui/explore/view_models/explore_viewmodel.dart';
import 'package:emombti/ui/feed/view_models/feed_post_viewmodel.dart';
import 'package:emombti/ui/feed/view_models/feed_reel_viewmodel.dart';
import 'package:emombti/ui/feed/widgets/feed_post.dart';
import 'package:emombti/ui/feed/widgets/feed_reel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key, required this.viewModel});

  final ExploreViewModel viewModel;

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.viewModel.tabs.length,
      vsync: this,
    );
    _tabController.animation?.addListener(_onTabAnimation);
    _tabController.addListener(_onTabControllerChanged);
  }

  void _onTabAnimation() {
    final double value = _tabController.animation!.value;
    final int targetIndex = value.round();
    widget.viewModel.onTabAnimation(targetIndex);
  }

  void _onTabControllerChanged() {
    // 这里只负责处理最终的状态同步
    if (!_tabController.indexIsChanging) {
      widget.viewModel.selectTab(_tabController.index);
    }
  }

  void _onViewModelChanged() {
    if (_tabController.index != widget.viewModel.selectedTabIndex) {
      _tabController.animateTo(widget.viewModel.selectedTabIndex);
    }
  }

  @override
  void dispose() {
    debugPrint('Dispose: _ExploreScreenState.');
    widget.viewModel.removeListener(_onViewModelChanged);
    _tabController.animation?.removeListener(_onTabAnimation);
    _tabController.removeListener(_onTabControllerChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ExploreScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('didUpdateWidget: _ExploreScreenState.');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final vm = widget.viewModel;

    return MultiProvider(
      // mount the tab view's state(viewmodel) at the explore screen.
      providers: [
        ChangeNotifierProvider<FeedPostViewModel>(
          create: (context) => FeedPostViewModel(
            authRepository: context.read<AuthRepository>(),
            feedRepository: context.read<FeedRepository>(),
          )..loadPostsCommand.execute(),
        ),
        ChangeNotifierProvider(create: (context) => FeedReelViewModel()),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            // We handle the background layout ourselves, so body is completely full-screen
            body: Stack(
              children: [
                // Layer 1: Full-screen TabBarView (Content goes completely underneath)
                TabBarView(
                  controller: _tabController,
                  children: [
                    for (final tab in vm.tabs) _ExploreTabBody(tab: tab),
                  ],
                ),

                // Layer 2: Floating Custom AppBar
                Positioned(
                  // MediaQuery top padding ensures it floats safely below the status bar notch
                  top: MediaQuery.of(context).padding.top,
                  left: 16.0,
                  right: 16.0,
                  child: SizedBox(
                    height:
                        56.0, // Slightly taller for a comfortable floating bar action
                    child: Row(
                      children: [
                        const SizedBox(width: 8.0), // Padding before the button
                        IconButton(
                          color: theme.colorScheme.primary,
                          icon: const Icon(Icons.add),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: TabBar(
                            controller: _tabController,
                            isScrollable: true,
                            tabAlignment: TabAlignment.start,
                            labelColor: theme.colorScheme.onSurface,
                            unselectedLabelColor:
                                theme.colorScheme.onSurfaceVariant,
                            dividerColor: Colors.transparent,
                            // Removes the default full-width bottom line indicator styling
                            indicatorSize: TabBarIndicatorSize.label,
                            tabs: [
                              for (final tab in vm.tabs)
                                Tab(
                                  key: ValueKey<String>(tab.id),
                                  text: tab.label,
                                ),
                            ],
                            onFocusChange: (value, index) => {},
                          ),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ), // Uniform padding at the end
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ExploreTabBody extends StatelessWidget {
  const _ExploreTabBody({required this.tab});

  final ExploreTab tab;

  @override
  Widget build(BuildContext context) {
    switch (tab.type) {
      case ExploreTabType.shares:
        // Reusing the FeedPostScreen widget. Since it has its own
        // provider/scaffold, it works as a standalone module.
        return const FeedPostScreen();

      case ExploreTabType.videos:
        return const FeedReel();

      case ExploreTabType.friends:
      case ExploreTabType.chatAiMbti:
      case ExploreTabType.placeholder:
        return _buildPlaceholder(context);
    }
  }

  Widget _buildPlaceholder(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Text(
        tab.label,
        style: theme.textTheme.titleMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
