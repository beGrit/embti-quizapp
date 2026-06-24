import 'dart:async';

import 'package:emombti/domain/constants/status.dart';
import 'package:emombti/ui/chat/view_models/chat_cloud_viewmodel.dart';
import 'package:flutter/material.dart';

class ConnectionStatus extends StatefulWidget {
  final ChatCloudViewModel viewModel;
  const ConnectionStatus({super.key, required this.viewModel});

  @override
  State<ConnectionStatus> createState() => _ConnectionStatusState();
}

class _ConnectionStatusState extends State<ConnectionStatus> {
  late final StreamSubscription _streamSubscription;
  ChatConnectionStatus _status = ChatConnectionStatus.disconnected;

  @override
  void initState() {
    super.initState();
    _streamSubscription = widget.viewModel.connectionStatusStream.listen((
      status,
    ) {
      setState(() {
        _status = status;
      });
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  Color _getStatusColor() {
    switch (_status) {
      case ChatConnectionStatus.disconnected:
        return Colors.red;
      case ChatConnectionStatus.connecting:
      case ChatConnectionStatus.reconnecting:
        return Colors.orange;
      case ChatConnectionStatus.connected:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _getStatusColor(),
      ),
    );
  }
}
