import 'package:emombti/domain/models/common/common.dart';
import 'package:emombti/domain/models/feed/feed.dart';
import 'package:emombti/domain/models/user/user.dart';
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
    model.setItems([
      Reel(
        id: '1',
        title: 'Test Reel',
        subTitle: 'This is a test reel',
        author: User(id: '1', name: 'Test User'),
        videoUrl: AppFile(
          name: 'test.mp4',
          uri: Uri.parse(
            'https://cdn.pixabay.com/video/2026/04/08/345377_large.mp4',
          ),
        ),
        created: DateTime.now(),
        updated: DateTime.now(),
      ),
      Reel(
        id: '2',
        title: 'Test Reel',
        subTitle: 'This is a test reel',
        author: User(id: '1', name: 'Test User'),
        videoUrl: AppFile(
          name: 'test.mp4',
          uri: Uri.parse(
            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
          ),
        ),
        created: DateTime.now(),
        updated: DateTime.now(),
      ),
      Reel(
        id: '3',
        title: 'Test Reel',
        subTitle: 'This is a test reel',
        author: User(id: '1', name: 'Test User'),
        videoUrl: AppFile(
          name: 'test.mp4',
          uri: Uri.parse('https://storage.grit-soft.com/71565-538962840.mp4'),
        ),
        created: DateTime.now(),
        updated: DateTime.now(),
      ),
    ]);
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
