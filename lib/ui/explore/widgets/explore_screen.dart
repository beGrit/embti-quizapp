import 'package:emombti/ui/core/themes/theme_util.dart';
import 'package:emombti/ui/explore/view_models/explore_viewmodel.dart';
import 'package:emombti/ui/feed/view_models/feed_reel_viewmodel.dart';
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
    ThemeController themeController = context.read<ThemeController>();
    final bool hasThemeOverride =
        widget.viewModel.tabs[targetIndex].themeDataName != null;
    if (hasThemeOverride) {
      themeController.overrideGlobalTheme(themeController.materialTheme.dark());
    } else {
      themeController.resetToSystemTheme();
    }
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

    return Scaffold(
      // We handle the background layout ourselves, so body is completely full-screen
      body: Stack(
        children: [
          // Layer 1: Full-screen TabBarView (Content goes completely underneath)
          TabBarView(
            controller: _tabController,
            children: [for (final tab in vm.tabs) _ExploreTabBody(tab: tab)],
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
                      unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
                      dividerColor: Colors.transparent,
                      // Removes the default full-width bottom line indicator styling
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: [
                        for (final tab in vm.tabs)
                          Tab(key: ValueKey<String>(tab.id), text: tab.label),
                      ],
                      onFocusChange: (value, index) => {},
                    ),
                  ),
                  const SizedBox(width: 16.0), // Uniform padding at the end
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExploreTabBody extends StatelessWidget {
  const _ExploreTabBody({required this.tab});

  final ExploreTab tab;

  @override
  Widget build(BuildContext context) {
    if (tab.id == ExploreTabIds.videos) {
      return _ExploreVideosReelTab();
    }

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

/// Owns [FeedReelViewModel] for the Videos tab so it is disposed with this branch.
class _ExploreVideosReelTab extends StatefulWidget {
  const _ExploreVideosReelTab();

  @override
  State<_ExploreVideosReelTab> createState() => _ExploreVideosReelTabState();
}

class _ExploreVideosReelTabState extends State<_ExploreVideosReelTab> {
  late final FeedReelViewModel _feedReelViewModel;

  // @override
  // bool get wantKeepAlive => false;

  @override
  void initState() {
    debugPrint('InitState: _ExploreVideosReelTabState.');
    super.initState();
    _feedReelViewModel = FeedReelViewModel();
  }

  @override
  void dispose() {
    debugPrint('Dispose: _ExploreVideosReelTabState.');
    _feedReelViewModel.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant _ExploreVideosReelTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('didUpdateWidget: _ExploreVideosReelTabState.');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Build: _ExploreVideosReelTabState');
    return FeedReel(viewModel: _feedReelViewModel);
  }
}
