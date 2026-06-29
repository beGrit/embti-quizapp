import 'package:emombti/data/repositories/feed/feed_repository.dart';
import 'package:emombti/data/repositories/user/user_repository.dart';
import 'package:emombti/domain/models/feed/feed.dart';
import 'package:emombti/domain/models/user/user.dart';
import 'package:emombti/ui/feed/models/feed_reel_model.dart';
import 'package:emombti/utils/command.dart';
import 'package:emombti/utils/result.dart';
import 'package:flutter/foundation.dart';

class FeedReelViewModel extends ChangeNotifier {
  final FeedRepository _feedRepository;
  final UserRepository _userRepository;

  FeedReelViewModel({
    required FeedRepository feedRepository,
    required UserRepository userRepository,
  }) : _feedRepository = feedRepository,
       _userRepository = userRepository {
    model = FeedReelModel();
    model.setItems([]);
    loadReelsCommand = Command0<List<Reel>>(_loadReelsInternal);
    loadMoreReelsCommand = Command0<List<Reel>>(_loadMoreReelsInternal);
  }

  late final FeedReelModel model;

  static const int _perPage = 5;
  bool _hasMore = true;
  bool get hasMore => _hasMore;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  late final Command0<List<Reel>> loadReelsCommand;
  late final Command0<List<Reel>> loadMoreReelsCommand;

  Future<Result<List<Reel>>> _loadReelsInternal() async {
    _hasMore = true;
    // Fetches the first page of reels (paginated)
    final result = await _feedRepository.getReelsLimit(_perPage, null, null);

    switch (result) {
      case Ok<List<Reel>>():
        final reelsWithAuthors = await _loadUsers(result.value);
        model.setItems(reelsWithAuthors);
        if (result.value.length < _perPage) {
          _hasMore = false;
        }
        notifyListeners();
      case Error<List<Reel>>():
        break;
    }
    return result;
  }

  Future<Result<List<Reel>>> _loadMoreReelsInternal() async {
    if (!_hasMore) return Result.ok([]);

    final reels = model.items;
    final result = await _feedRepository.getReelsLimit(
      _perPage,
      reels[reels.length - 1].id,
      null,
    );

    switch (result) {
      case Ok<List<Reel>>():
        final newReels = await _loadUsers(result.value);
        if (newReels.isEmpty) {
          _hasMore = false;
        } else {
          model.addItems(newReels);
          if (newReels.length < _perPage) {
            _hasMore = false;
          }
        }
        notifyListeners();
      case Error<List<Reel>>():
        break;
    }
    return result;
  }

  void onPageChanged(int index) {
    final reels = model.items;
    if (index < 0 || index >= reels.length) return;
    if (_currentIndex == index) return;
    _currentIndex = index;

    // Pre-fetch more reels when approaching the end of the list
    if (index >= reels.length - 2 && _hasMore) {
      loadMoreReelsCommand.execute();
    }

    notifyListeners();
  }

  /// Adds a newly created reel to the top of the reel list.
  void addReel(Reel reel) {
    model.items = [reel, ...model.items];
    notifyListeners();
  }

  /// Joins author (User) data onto each reel using a batch user lookup.
  Future<List<Reel>> _loadUsers(List<Reel> reels) async {
    final userIds = reels
        .map((e) => e.author.id != null ? e.author.id! : '')
        .where((id) => id.isNotEmpty)
        .toList();

    final Result res = await _userRepository.getUsersByIds(userIds);
    if (res is Ok) {
      final Map<String, User> usersMap = {};
      final List<User> userList = res.value;
      for (final user in userList) {
        if (user.id != null) {
          usersMap[user.id!] = user;
        }
      }
      return reels.map((reel) {
        final User? newAuthor = usersMap[reel.author.id];
        return reel.copyWith(author: newAuthor ?? reel.author);
      }).toList();
    }
    return [];
  }
}
