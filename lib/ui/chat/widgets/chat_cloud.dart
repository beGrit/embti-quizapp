import 'package:emombti/domain/constants/status.dart';
import 'package:emombti/ui/chat/view_models/chat_cloud_viewmodel.dart';
import 'package:emombti/ui/chat/widgets/chat_cloud_actions.dart';
import 'package:emombti/ui/chat/widgets/chat_cloud_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_core/flutter_chat_core.dart' as fcc;
import 'package:flutter_chat_core/flutter_chat_core.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flyer_chat_image_message/flyer_chat_image_message.dart';
import 'package:flyer_chat_text_message/flyer_chat_text_message.dart';

class ChatCloud extends StatefulWidget {
  final ChatCloudViewModel viewModel;

  const ChatCloud({super.key, required this.viewModel});

  @override
  State<ChatCloud> createState() => ChatCloudState();
}

class ChatCloudState extends State<ChatCloud> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.connect();
  }

  @override
  void didUpdateWidget(covariant ChatCloud oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.viewModel != widget.viewModel) {
      widget.viewModel.connect();
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 50,
            backgroundColor: theme.colorScheme.surfaceContainer,
            elevation: 0,
            scrolledUnderElevation: 0,
            title: Text(
              widget.viewModel.chat.name ?? 'Unknown Chat',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            centerTitle: true,
            actions: [],
          ),
          body: widget.viewModel.pageStatus == PageStatus.init
              ? Center(child: Text('Loading'))
              : Stack(
                  children: [
                    Chat(
                      builders: Builders(
                        chatAnimatedListBuilder: (context, itemBuilder) {
                          return ChatAnimatedList(
                            itemBuilder: itemBuilder,
                            insertAnimationDurationResolver: (message) {
                              if (message is SystemMessage) {
                                return Duration.zero;
                              }
                              return null;
                            },
                            onEndReached: widget.viewModel.onEndReachedAble
                                ? widget.viewModel.loadOlderMessages
                                : null,
                          );
                        },
                        textMessageBuilder:
                            (
                              context,
                              message,
                              index, {
                              required bool isSentByMe,
                              MessageGroupStatus? groupStatus,
                            }) => FlyerChatTextMessage(
                              message: message,
                              index: index,
                            ),
                        imageMessageBuilder:
                            (
                              context,
                              message,
                              index, {
                              required bool isSentByMe,
                              MessageGroupStatus? groupStatus,
                            }) => FlyerChatImageMessage(
                              message: message,
                              index: index,
                            ),
                        chatMessageBuilder:
                            (
                              context,
                              message,
                              index,
                              animation,
                              child, {
                              bool? isRemoved,
                              required bool isSentByMe,
                              MessageGroupStatus? groupStatus,
                            }) {
                              final isSystemMessage =
                                  message.authorId == 'system';
                              final isFirstInGroup =
                                  groupStatus?.isFirst ?? true;
                              final isLastInGroup = groupStatus?.isLast ?? true;
                              final shouldShowAvatar =
                                  !isSystemMessage &&
                                  isLastInGroup &&
                                  isRemoved != true;
                              final isCurrentUser =
                                  message.authorId ==
                                  widget.viewModel.currentUserId;
                              final shouldShowUsername =
                                  !isSystemMessage &&
                                  isFirstInGroup &&
                                  isRemoved != true;

                              Widget? avatar;
                              if (shouldShowAvatar) {
                                avatar = Padding(
                                  padding: EdgeInsets.only(
                                    left: isCurrentUser ? 8 : 0,
                                    right: isCurrentUser ? 0 : 8,
                                  ),
                                  child: Avatar(userId: message.authorId),
                                );
                              } else if (!isSystemMessage) {
                                avatar = const SizedBox(width: 40);
                              }

                              return ChatMessage(
                                message: message,
                                index: index,
                                animation: animation,
                                isRemoved: isRemoved,
                                groupStatus: groupStatus,
                                topWidget: shouldShowUsername
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                          bottom: 4,
                                          left: isCurrentUser ? 0 : 48,
                                          right: isCurrentUser ? 48 : 0,
                                        ),
                                        child: Username(
                                          userId: message.authorId,
                                        ),
                                      )
                                    : null,
                                leadingWidget: !isCurrentUser
                                    ? avatar
                                    : isSystemMessage
                                    ? null
                                    : const SizedBox(width: 40),
                                trailingWidget: isCurrentUser
                                    ? avatar
                                    : isSystemMessage
                                    ? null
                                    : const SizedBox(width: 40),
                                receivedMessageScaleAnimationAlignment:
                                    (message is SystemMessage)
                                    ? Alignment.center
                                    : Alignment.centerLeft,
                                receivedMessageAlignment:
                                    (message is SystemMessage)
                                    ? AlignmentDirectional.center
                                    : AlignmentDirectional.centerStart,
                                horizontalPadding: (message is SystemMessage)
                                    ? 0
                                    : 8,
                                child: child,
                              );
                            },
                        composerBuilder: (context) => Composer(
                          topWidget: ComposerActionBar(
                            buttons: [
                              ComposerActionButton(
                                icon: Icons.shuffle,
                                title: 'Send random',
                                onPressed: () => {},
                              ),
                              ComposerActionButton(
                                icon: Icons.delete_sweep,
                                title: 'Clear all',
                                onPressed: () => {},
                                destructive: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                      chatController: widget.viewModel.chatController,
                      currentUserId: widget.viewModel.currentUserId,
                      decoration: BoxDecoration(
                        color: theme.brightness == Brightness.dark
                            ? ChatColors.dark().surface
                            : ChatColors.light().surface,
                      ),
                      onMessageSend: (text) async {
                        try {
                          widget.viewModel.sendMessage(text);
                        } catch (error) {
                          _showInfo(
                            'Send Message failed, please check the network status.',
                          );
                        }
                      },
                      resolveUser: (fcc.UserID id) =>
                          Future.value(widget.viewModel.users[id]),
                      theme: ChatTheme.fromThemeData(theme),
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: ConnectionStatus(viewModel: widget.viewModel),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Future<void> _showInfo(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Info'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
