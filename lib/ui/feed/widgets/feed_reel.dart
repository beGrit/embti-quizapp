import 'package:emombti/ui/feed/models/feed_reel_model.dart';
import 'package:emombti/ui/feed/view_models/feed_reel_viewmodel.dart';
import 'package:emombti/ui/feed/widgets/feed_reel_video_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Vertical, full-viewport paging feed of videos (TikTok / Instagram Reels style).
class FeedReel extends StatefulWidget {
  const FeedReel({super.key});

  @override
  State<FeedReel> createState() => _FeedReelState();
}

class _FeedReelState extends State<FeedReel> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FeedReelViewModel viewModel = context.read<FeedReelViewModel>();
    FeedReelModel model = viewModel.model;
    return ListenableBuilder(
      listenable: Listenable.merge([viewModel, model]),
      builder: (context, _) {
        if (model.items.isEmpty) {
          return const Center(child: Text('No videos'));
        } else {
          return PageView.custom(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            allowImplicitScrolling: false,
            onPageChanged: viewModel.onPageChanged,
            key: const PageStorageKey('feed-reel-page-view'),
            childrenDelegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = model.items[index];
                return FeedReelVideoPlayer(feedReel: item);
              },
              childCount: model.items.length,
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: true,
            ),
          );
        }
      },
    );
  }
}
