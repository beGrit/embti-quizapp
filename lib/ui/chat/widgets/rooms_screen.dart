import 'package:emombti/app_state/chat.dart';
import 'package:emombti/domain/models/chat/chat.dart';
import 'package:emombti/routing/routes.dart';
import 'package:emombti/ui/core/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../view_models/rooms_viewmodel.dart';
import 'rooms_add_room.dart';

class RoomsScreen extends StatelessWidget {
  const RoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RoomsViewModel>(
      create: (context) => RoomsViewModel(
        authState: context.read(),
        chatRepository: context.read(),
        userRepository: context.read(),
        chatState: context.read(),
      )..loadRoomsCommand.execute(),
      builder: (context, _) {
        return Scaffold(
          appBar: StandardAppBar(
            title: 'Messages',
            actions: [
              IconButton(
                icon: const Icon(Icons.add_comment_outlined),
                tooltip: 'Add Chat Room',
                onPressed: () => AddChatRoomDialog.show(context, context.read<RoomsViewModel>()),
              ),
            ],
          ),
          body: Consumer2<RoomsViewModel, ChatState>(
            builder: (context, viewModel, chatState, _) {
              return RefreshIndicator(
                onRefresh: () => viewModel.loadRoomsCommand.execute(),
                child: ListenableBuilder(
                  listenable: viewModel.loadRoomsCommand,
                  builder: (context, _) {
                    final rooms = chatState.rooms;
                    return CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      slivers: [
                        if (viewModel.loadRoomsCommand.running)
                          const SliverFillRemaining(child: SizedBox.shrink())
                        else if (viewModel.loadRoomsCommand.error)
                          const SliverFillRemaining(
                            child: Center(child: Text('Error')),
                          )
                        else if (rooms.isEmpty)
                          const SliverFillRemaining(
                            child: Center(child: Text('No active chats found')),
                          )
                        else
                          SliverList(
                            delegate: SliverChildBuilderDelegate((
                              context,
                              index,
                            ) {
                              final room = rooms[index];
                              return _RoomListTile(room: room);
                            }, childCount: rooms.length),
                          ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _RoomListTile extends StatelessWidget {
  const _RoomListTile({required this.room});

  final Room room;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chatState = context.watch<ChatState>();
    final unreadCount = chatState.getUnreadCount(room.id);

    return Dismissible(
      key: ValueKey(room.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: theme.colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: Icon(
          Icons.delete_outline,
          color: theme.colorScheme.onError,
        ),
      ),
      onDismissed: (_) {
        context.read<RoomsViewModel>().deleteRoomCommand.execute(room.id);
      },
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            leading: CircleAvatar(
              radius: 28,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Icon(
                Icons.group,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
            title: Text(
              room.name ?? 'Chat Room',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              'Start a conversation...',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${room.updated.hour}:${room.updated.minute.toString().padLeft(2, '0')}',
                  style: theme.textTheme.bodySmall,
                ),
                if (unreadCount > 0) ...[
                  const SizedBox(height: 4),
                  Badge(
                    label: Text(unreadCount.toString()),
                    backgroundColor: theme.colorScheme.primary,
                  ),
                ],
              ],
            ),
            onTap: () async {
              final chatState = context.read<ChatState>();
              await context.push('${Routes.chatRooms}/${room.id}', extra: room);
              chatState.setActiveRoom(null);
            },
          ),
          const Divider(height: 1, indent: 80),
        ],
      ),
    );
  }
}
