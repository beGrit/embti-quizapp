import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/repositories/chat/chat_repository.dart';
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
    return ChangeNotifierProvider(
      create: (context) => RoomDetailViewModel(
        room: room,
        authRepository: context.read<AuthRepository>(),
        chatRepository: context.read<ChatRepository>(),
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
  final TextEditingController _controller = TextEditingController();

  void _handleSend(RoomDetailViewModel viewModel) {
    viewModel.sendMessage(_controller.text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RoomDetailViewModel>();
    final currentUserId = context.read<AuthRepository>().user?.id;

    return Scaffold(
      appBar: StandardAppBar(title: viewModel.room.name ?? 'Chat'),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: viewModel.messagesStream,
              builder: (context, snapshot) {
                if (viewModel.isLoading && !snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data ?? [];
                if (messages.isEmpty && !viewModel.isLoading) {
                  return const Center(child: Text('No messages yet'));
                }

                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    // Since the list is chronological and we use reverse: true,
                    // we map index 0 (bottom) to the last item in the list.
                    final message = messages[messages.length - 1 - index];
                    final isMe = message.sendBy == currentUserId;
                    return _MessageBubble(
                      message: message,
                      isMe: isMe,
                      senderName: isMe
                          ? null
                          : 'User ${message.sendBy?.substring(0, 3)}',
                    );
                  },
                );
              },
            ),
          ),
          _buildInputArea(viewModel),
        ],
      ),
    );
  }

  Widget _buildInputArea(RoomDetailViewModel viewModel) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border(top: BorderSide(color: theme.dividerColor, width: 0.5)),
      ),
      child: SafeArea(
        child: Row(
          children: [
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Message',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        ),
                        onSubmitted: (_) => _handleSend(viewModel),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.camera_alt_outlined, size: 20),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.image_outlined, size: 20),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: Icon(
                _controller.text.isEmpty ? Icons.mic_none : Icons.send,
              ),
              color: _controller.text.isEmpty
                  ? theme.colorScheme.onSurfaceVariant
                  : theme.colorScheme.primary,
              onPressed: () => _handleSend(viewModel),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({
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
                      if (message.replyMessage != null)
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
          if (isMe) const SizedBox(width: 32), // Offset for right side
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
