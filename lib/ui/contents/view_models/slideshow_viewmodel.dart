import 'dart:async';

import 'package:flutter/material.dart';

import '../../../domain/models/content/content.dart';
import 'banner_viewmodel.dart';

class SlideshowViewModel extends ChangeNotifier {
  SlideshowViewModel({required this.bannerViewModel}) {
    // 1. Listen to the command's status to know when loading starts/ends
    bannerViewModel.loadBanners.addListener(_onLoadStatusChanged);
    bannerViewModel.loadBanners.execute();
    _pageController = PageController();
  }

  final BannerViewModel bannerViewModel;
  late final PageController _pageController;

  Timer? _timer;
  int _currentPage = 0;
  DateTime _lastInteractionTime = DateTime.now();

  // Getters
  PageController get pageController => _pageController;
  int get currentPage => _currentPage;
  List<BannerContent> get banners => bannerViewModel.banners;

  // 2. React to the Command execution
  void _onLoadStatusChanged() {
    final command = bannerViewModel.loadBanners;

    if (command.running) {
      // Pause or reset timer if a refresh starts
      _timer?.cancel();
      _timer = null;
    } else if (!command.running && banners.isNotEmpty) {
      // Data is ready, start the timer
      _startTimer();
    }
    notifyListeners();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_pageController.hasClients || banners.isEmpty) return;

      final timeSinceInteraction = DateTime.now().difference(
        _lastInteractionTime,
      );

      // Auto-animate every 5 seconds of inactivity
      if (timeSinceInteraction.inSeconds >= 5) {
        _autoNextPage();
      }
    });
  }

  /// Private next page specifically for auto-animate
  /// (to avoid resetting interaction time in a loop)
  void _autoNextPage() {
    if (banners.isEmpty) return;
    final targetPage = (_currentPage + 1) % banners.length;
    _animateTo(targetPage);
    // Note: We don't call _recordInteraction here because
    // the timer itself tracks the 5-second window.
    _lastInteractionTime = DateTime.now();
  }

  void handlePageChanged(int index) {
    _currentPage = index;
    notifyListeners();
  }

  void _recordInteraction() {
    _lastInteractionTime = DateTime.now();
  }

  void nextPage() {
    if (banners.isEmpty) return;
    _recordInteraction();
    final targetPage = (_currentPage + 1) % banners.length;
    _animateTo(targetPage);
  }

  void previousPage() {
    if (banners.isEmpty) return;
    _recordInteraction();
    final targetPage = _currentPage == 0
        ? banners.length - 1
        : _currentPage - 1;
    _animateTo(targetPage);
  }

  void _animateTo(int page) {
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    // 3. Clean up listeners
    bannerViewModel.loadBanners.removeListener(_onLoadStatusChanged);
    bannerViewModel.loadBanners.dispose();
    bannerViewModel.dispose();
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }
}
