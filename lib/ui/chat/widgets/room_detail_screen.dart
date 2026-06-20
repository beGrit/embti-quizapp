import 'package:emombti/app_state/chat.dart';
import 'package:emombti/domain/models/chat/chat.dart';
import 'package:emombti/ui/core/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/room_detail_viewmodel.dart';

class RoomDetailScreen extends StatelessWidget {
  const RoomDetailScreen({super.key, required this.room});

  final Room room;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: RoomDetailViewModel(
        room: room,
        authState: context.read(),
        chatRepository: context.read(),
        chatState: context.read(),
      ),
      child: const _RoomDetailContent(),
    );
  }
}

class _RoomDetailContent extends StatefulWidget {
  const _RoomDetailContent();

  @override
  State<_RoomDetailContent> createState() => _RoomDetailContentState();
}

class _RoomDetailContentState extends State<_RoomDetailContent> {
  late final RoomDetailViewModel viewModel;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    viewModel = context.read<RoomDetailViewModel>();
    _controller = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.init();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSend() {
    viewModel.sendMessage(_controller.text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer2<RoomDetailViewModel, ChatState>(
      builder: (context, viewModel, chatState, _) => Scaffold(
        appBar: StandardAppBar(title: viewModel.room.name ?? 'Chat'),
        body: Column(
          children: [
            if (!viewModel.isConnected)
              Container(
                color: theme.colorScheme.errorContainer,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.cloud_off,
                      size: 16,
                      color: theme.colorScheme.onErrorContainer,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Connecting to server...',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.onErrorContainer,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(child: _buildMessageList(viewModel, chatState)),
            _buildInputArea(viewModel),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList(RoomDetailViewModel viewModel, ChatState chatState) {
    final messages = chatState.activeRoomMessages;
    return ListenableBuilder(
      listenable: viewModel.loadMessagesCommand,
      builder: (context, child) {
        if (viewModel.loadMessagesCommand.running && messages.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (viewModel.loadMessagesCommand.completed && messages.isEmpty) {
          return const Center(child: Text('No messages yet'));
        }
        if (viewModel.loadMessagesCommand.error) {
          return const Center(child: Text('Error loading messages'));
        }
        return ListView.builder(
          reverse: true,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            final isMe = message.sendBy == viewModel.currentUserId;
            return _MessageBubble(
              key: ValueKey(message.id),
              message: message,
              isMe: isMe,
              senderName: isMe
                  ? null
                  : 'User ${message.sendBy?.substring(0, 3)}',
            );
          },
        );
      },
    );
  }

  Widget _buildInputArea(RoomDetailViewModel viewModel) {
    final theme = Theme.of(context);
    final isConnected = viewModel.isConnected;

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(color: theme.cardColor),
      child: SafeArea(
        child: Row(
          children: [
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: isConnected
                      ? theme.colorScheme.surfaceContainerHighest
                      : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        enabled: isConnected,
                        decoration: InputDecoration(
                          hintText: isConnected ? 'Message' : 'Offline - Write disabled',
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        onSubmitted: isConnected ? (_) => _handleSend() : null,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera_alt_outlined, size: 20),
                      onPressed: isConnected ? () {} : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.image_outlined, size: 20),
                      onPressed: isConnected ? () {} : null,
                    ),
                    IconButton(
                      icon: Icon(
                        _controller.text.isEmpty ? Icons.mic_none : Icons.send,
                      ),
                      color: _controller.text.isEmpty
                          ? theme.colorScheme.onSurfaceVariant
                          : theme.colorScheme.primary,
                      onPressed: isConnected ? () => _handleSend() : null,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({
    super.key,
    required this.message,
    required this.isMe,
    this.senderName,
  });

  final Message message;
  final bool isMe;
  final String? senderName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: theme.colorScheme.outlineVariant,
              child: const Icon(Icons.person, size: 18),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                if (senderName != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 2),
                    child: Text(
                      senderName!,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: isMe
                        ? theme.colorScheme.primary
                        : theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(18),
                      topRight: const Radius.circular(18),
                      bottomLeft: Radius.circular(isMe ? 18 : 0),
                      bottomRight: Radius.circular(isMe ? 0 : 18),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (message.replyId != null &&
                          message.replyId!.isNotEmpty)
                        _buildReplyPreview(context, theme),
                      if (message.messageType == 'voice')
                        _buildVoiceMessage(context, theme)
                      else if (message.messageType == 'image')
                        const Icon(Icons.image, size: 100)
                      else
                        Text(
                          message.message ?? '',
                          style: TextStyle(
                            color: isMe
                                ? theme.colorScheme.onPrimary
                                : theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReplyPreview(BuildContext context, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: isMe ? Colors.white54 : theme.colorScheme.primary,
            width: 3,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Replied by ${message.replyBy ?? 'User'}',
            style: theme.textTheme.labelSmall?.copyWith(
              color: isMe ? Colors.white70 : theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            message.replyMessage ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: isMe ? Colors.white70 : theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVoiceMessage(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.play_arrow_rounded,
          color: isMe ? theme.colorScheme.onPrimary : theme.colorScheme.primary,
        ),
        const SizedBox(width: 4),
        Container(
          width: 120,
          height: 2,
          color: isMe ? Colors.white54 : theme.colorScheme.outlineVariant,
        ),
      ],
    );
  }
}
