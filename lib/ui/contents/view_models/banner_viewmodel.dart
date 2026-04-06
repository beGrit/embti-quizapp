import 'package:flutter/material.dart';

import '../../../data/repositories/banner_content/banner_content_repository.dart';
import '../../../domain/models/content/content.dart';
import '../../../utils/command.dart';
import '../../../utils/result.dart';

class BannerViewModel extends ChangeNotifier {
  BannerViewModel(this._repository) {
    // Initialize the command with the private load method
    loadBanners = Command0<void>(_loadBanners);
  }

  final BannerContentRepository _repository;

  /// Command used by the UI to trigger loading and track status
  late Command0<void> loadBanners;

  List<BannerContent> _banners = [];
  List<BannerContent> get banners => _banners;

  Future<Result<void>> _loadBanners() async {
    // 1. Fetch data from the dedicated Banner repository
    final result = await _repository.getAll();

    if (result is Ok<List<BannerContent>>) {
      _banners = result.value;
      notifyListeners();
      return Result.ok(null);
    }

    // 2. Handle potential errors (e.g., Network issues)
    return Result.error(Exception('Failed to fetch banners from repository'));
  }
}
