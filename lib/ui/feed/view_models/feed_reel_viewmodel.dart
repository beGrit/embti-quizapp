import 'package:flutter/foundation.dart';

/// One item in a vertical full-screen reel feed (TikTok / Reels style).
@immutable
class FeedReelItem {
  const FeedReelItem({
    required this.id,
    required this.videoUrl,
    this.title,
    this.subtitle,
  });

  final String id;
  final String videoUrl;
  final String? title;
  final String? subtitle;
}

/// Holds reel list and the index of the page currently in view.
class FeedReelViewModel extends ChangeNotifier {
  FeedReelViewModel({List<FeedReelItem>? items})
    : _items = List<FeedReelItem>.unmodifiable(items ?? _defaultDemoItems);

  static const List<FeedReelItem> _defaultDemoItems = [
    FeedReelItem(
      id: '1',
      videoUrl:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      title: '@sample',
      subtitle: 'Short clip from Flutter sample assets',
    ),
    FeedReelItem(
      id: '2',
      videoUrl:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      title: '@nature',
      subtitle: 'Butterfly — swipe up for next',
    ),
    FeedReelItem(
      id: '3',
      videoUrl:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      title: '@loop',
      subtitle: 'Same bee clip again to demo paging',
    ),
  ];

  final List<FeedReelItem> _items;
  List<FeedReelItem> get items => _items;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void onPageChanged(int index) {
    if (index < 0 || index >= _items.length) return;
    if (_currentIndex == index) return;
    _currentIndex = index;
    notifyListeners();
  }
}
