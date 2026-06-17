import 'package:emombti/domain/constants/status.dart';
import 'package:emombti/manager/connectivity_manager.dart';
import 'package:flutter/material.dart';

class NotificationWrapper extends StatefulWidget {
  final Widget child;

  final ConnectivityManager connectivityManager;

  const NotificationWrapper({
    super.key,
    required this.child,
    required this.connectivityManager,
  });

  @override
  State<NotificationWrapper> createState() => _NotificationWrapperState();
}

class _NotificationWrapperState extends State<NotificationWrapper> {
  NetworkStatus? _lastStatus;

  @override
  void initState() {
    super.initState();
    widget.connectivityManager.addListener(_onNetworkChange);
    // Check initial state after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkNetwork();
    });
  }

  @override
  void dispose() {
    widget.connectivityManager.removeListener(_onNetworkChange);
    super.dispose();
  }

  void _onNetworkChange() {
    if (!mounted) return;
    _checkNetwork();
  }

  void _checkNetwork() {
    final currentStatus = widget.connectivityManager.status;
    if (currentStatus == NetworkStatus.checking) return;
    if (_lastStatus == currentStatus) return;

    final messenger = ScaffoldMessenger.of(context);

    if (currentStatus == NetworkStatus.offline) {
      // 1. Show a persistent snackbar when connection drops
      messenger.hideCurrentMaterialBanner();
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Connection lost, working in offline mode.'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(days: 1),
        ),
      );
    } else if (currentStatus == NetworkStatus.online) {
      // 2. Clear the error and show a brief success snackbar when back online
      messenger.hideCurrentMaterialBanner();
      messenger.hideCurrentSnackBar();

      // Only show the online snackbar if we were previously offline
      if (_lastStatus == NetworkStatus.offline) {
        messenger.showSnackBar(
          const SnackBar(
            content: Text('Working in online mode, syncing data...'),
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
    _lastStatus = currentStatus;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.connectivityManager,
      builder: (context, _) {
        return widget.child;
      },
    );
  }
}
