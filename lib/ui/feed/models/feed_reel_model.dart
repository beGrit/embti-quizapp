import 'package:emombti/domain/models/feed/feed.dart';
import 'package:flutter/material.dart';

class FeedReelModel extends ChangeNotifier {
  List<Reel> items = [];

  void setItems(List<Reel> newItems) {
    items = newItems;
    notifyListeners();
  }

  void addItem(Reel newItem) {
    items.add(newItem);
    notifyListeners();
  }

  void removeItem(Reel item) {
    items.remove(item);
    notifyListeners();
  }
}
