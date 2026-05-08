import 'package:flutter/material.dart';

mixin PagingMixin<T> on ChangeNotifier {
  List<T> _dataItems = [];
  bool _isLoading = false;
  bool _isFetchingMore = false;
  bool _hasMore = true;
  int _currentPage = 1;
  static const int defaultPageSize = 15;

  List<T> get dataItems => _dataItems;
  bool get isLoading => _isLoading;
  bool get isFetchingMore => _isFetchingMore;
  bool get hasMore => _hasMore;

  @protected
  Future<List<T>> loadData(int page, int pageSize);

  Future<void> refreshData() async {
    _currentPage = 1;
    _hasMore = true;
    _isLoading = true;
    notifyListeners();

    try {
      final results = await loadData(_currentPage, defaultPageSize);
      _dataItems = results;
      _hasMore = results.length >= defaultPageSize;
    } catch (e) {
      debugPrint("Paging Refresh Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadNextPage() async {
    if (_isFetchingMore || !_hasMore) return;

    _isFetchingMore = true;
    notifyListeners();

    try {
      final nextPage = _currentPage + 1;
      final results = await loadData(nextPage, defaultPageSize);

      if (results.isEmpty) {
        _hasMore = false;
      } else {
        _dataItems.addAll(results);
        _currentPage = nextPage;
        _hasMore = results.length >= defaultPageSize;
      }
    } catch (e) {
      debugPrint("Paging LoadMore Error: $e");
    } finally {
      _isFetchingMore = false;
      notifyListeners();
    }
  }
}
