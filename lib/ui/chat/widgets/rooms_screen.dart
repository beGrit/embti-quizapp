import 'package:emombti/app_state/chat_state.dart';
import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/repositories/chat/chat_repository.dart';
import 'package:emombti/domain/models/chat/chat.dart';
import 'package:emombti/routing/routes.dart';
import 'package:emombti/ui/core/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../view_models/rooms_viewmodel.dart';

class RoomsScreen extends StatelessWidget {
  const RoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RoomsViewModel>(
      create: (context) => RoomsViewModel(
        authRepository: context.read<AuthRepository>(),
        chatRepository: context.read<ChatRepository>(),
      )..loadRoomsCommand.execute(),
      builder: (context, _) {
        final viewModel = context.watch<RoomsViewModel>();

        return Scaffold(
          appBar: StandardAppBar(
            title: 'Messages',
            actions: [
              IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () => viewModel.loadRoomsCommand.execute(),
            child: ListenableBuilder(
              listenable: viewModel.loadRoomsCommand,
              builder: (context, _) {
                return CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  slivers: [
                    if (viewModel.loadRoomsCommand.running &&
                        viewModel.rooms.isEmpty)
                      const SliverFillRemaining(
                        child: Center(child: Text('Refreshing')),
                      )
                    else if (viewModel.loadRoomsCommand.error)
                      const SliverFillRemaining(
                        child: Center(child: Text('Error')),
                      )
                    else if (viewModel.rooms.isEmpty)
                      const SliverFillRemaining(
                        child: Center(child: Text('No active chats found')),
                      )
                    else
                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final room = viewModel.rooms[index];
                          return _RoomListTile(room: room);
                        }, childCount: viewModel.rooms.length),
                      ),
                  ],
                );
              },
            ),
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

    return Column(
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
          onTap: () =>
              context.push('${Routes.chatRooms}/${room.id}', extra: room),
        ),
        const Divider(height: 1, indent: 80),
      ],
    );
  }
}
