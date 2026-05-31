import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  final List<String> _allPersonalities = [
    'INTJ', 'INTP', 'ENTJ', 'ENTP',
    'INFJ', 'INFP', 'ENFJ', 'ENFP',
    'ISTJ', 'ISFJ', 'ESTJ', 'ESFJ',
    'ISTP', 'ISFP', 'ESTP', 'ESFP',
  ];

  List<String> get suggestions => _searchQuery.isEmpty
      ? []
      : _allPersonalities
          .where((p) => p.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
