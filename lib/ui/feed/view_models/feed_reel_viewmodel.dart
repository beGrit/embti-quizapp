import 'package:emombti/ui/feed/models/feed_reel_model.dart';
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
  FeedReelViewModel() {
    model = FeedReelModel();
    model.setItems([]);
  }

  late final FeedReelModel model;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void onPageChanged(int index) {
    if (index < 0 || index >= model.items.length) {
      return;
    }
    if (_currentIndex == index) return;
    _currentIndex = index;
    notifyListeners();
  }
}
