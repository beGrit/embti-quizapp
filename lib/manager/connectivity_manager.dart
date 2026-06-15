import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:emombti/domain/constants/status.dart';
import 'package:flutter/material.dart';

class ConnectivityManager extends ChangeNotifier {
  // 1. Create a private internal instance
  static final ConnectivityManager _instance = ConnectivityManager._internal();

  // 2. Expose a public factory constructor that always returns the same instance
  factory ConnectivityManager() => _instance;

  // 3. A private, named constructor where the actual initialization happens
  ConnectivityManager._internal();

  // --- Core Functionality ---

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  NetworkStatus _status = NetworkStatus.checking;
  NetworkStatus get status => _status;
  bool get isOnline => _status == NetworkStatus.online;

  Future<void> load() async {
    final results = await _connectivity.checkConnectivity();
    _updateStatus(results);
    _subscribeToConnectivityStream();
  }

  void _subscribeToConnectivityStream() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateStatus,
      onError: (error) {
        _status = NetworkStatus.offline;
        notifyListeners();
      },
    );
  }

  void _updateStatus(List<ConnectivityResult> results) {
    final oldStatus = _status;

    if (results.isEmpty || results.contains(ConnectivityResult.none)) {
      _status = NetworkStatus.offline;
    } else {
      _status = NetworkStatus.online;
    }

    if (oldStatus != _status) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }
}
