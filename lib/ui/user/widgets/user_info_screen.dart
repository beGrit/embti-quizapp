import 'package:cached_network_image/cached_network_image.dart';
import 'package:emombti/data/repositories/auth/auth_repository.dart';
import 'package:emombti/data/repositories/user/user_repository.dart';
import 'package:emombti/domain/use_cases/user/user_avatar_update_use_case.dart';
import 'package:emombti/ui/core/themes/theme.dart';
import 'package:emombti/ui/core/ui/widgets/app_bar.dart';
import 'package:emombti/ui/user/view_models/user_info_screen_viewmodel.dart';
import 'package:emombti/utils/command.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class UserInfoScreen extends StatelessWidget {
  const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserInfoScreenViewModel>(
      create: (context) => UserInfoScreenViewModel(
        authRepository: context.read<AuthRepository>(),
        userRepository: context.read<UserRepository>(),
        userAvatarUpdateUseCase: context.read<UserAvatarUpdateUseCase>(),
      ),
      child: const _UserInfoScreenContent(),
    );
  }
}

class _UserInfoScreenContent extends StatelessWidget {
  const _UserInfoScreenContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UserInfoScreenViewModel>();
    final colorScheme = Theme.of(context).colorScheme;
    final user = viewModel.user;

    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: const StandardAppBar(title: 'User Info'),
      backgroundColor: colorScheme.surface,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: [
          _buildSectionHeader(context, 'Basic Info'),
          Container(
            decoration: AppContainerStyles.standard(context).decoration,
            child: Column(
              children: [
                _buildAvatarTile(context, viewModel),
                _buildDivider(context),
                _buildInfoTile(
                  context,
                  title: 'Name',
                  value: user.name ?? 'Not set',
                  onTap: () => _editName(context, viewModel),
                ),
                _buildDivider(context),
                _buildInfoTile(
                  context,
                  title: 'MBTI',
                  value: user.mbtiType ?? 'Not set',
                  onTap: () => _editMbtiType(context, viewModel),
                ),
                _buildDivider(context),
                _buildInfoTile(
                  context,
                  title: 'Introduce',
                  value: user.introduce ?? 'Not set',
                  onTap: () => _editIntroduce(context, viewModel),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarTile(BuildContext context, UserInfoScreenViewModel viewModel) {
    final user = viewModel.user!;
    return ListTile(
      dense: true,
      title: const Text('Avatar'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: user.avatar?.uri != null
                ? CachedNetworkImageProvider(user.avatar!.uri.toString())
                : null,
            child: user.avatar?.uri == null ? const Icon(Icons.person) : null,
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
      onTap: () => viewModel.updateAvatarCommand.execute(),
    );
  }

  Widget _buildInfoTile(
    BuildContext context, {
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return ListTile(
      dense: true,
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 150),
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.end,
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
      onTap: onTap,
    );
  }

  void _editName(BuildContext context, UserInfoScreenViewModel viewModel) {
    viewModel.tempName = viewModel.user!.name ?? '';
    _navigateToEdit(
      context,
      title: 'Edit Name',
      command: viewModel.updateNameCommand,
      builder: (context) => TextField(
        autofocus: true,
        decoration: const InputDecoration(
          hintText: 'Enter your name',
          border: InputBorder.none,
        ),
        onChanged: (value) => viewModel.tempName = value,
        controller: TextEditingController(text: viewModel.tempName)
          ..selection = TextSelection.fromPosition(
            TextPosition(offset: viewModel.tempName.length),
          ),
      ),
    );
  }

  void _editIntroduce(BuildContext context, UserInfoScreenViewModel viewModel) {
    viewModel.tempIntroduce = viewModel.user!.introduce ?? '';
    _navigateToEdit(
      context,
      title: 'Edit Introduction',
      command: viewModel.updateIntroduceCommand,
      builder: (context) => TextField(
        autofocus: true,
        maxLines: 5,
        decoration: const InputDecoration(
          hintText: 'Enter introduction',
          border: InputBorder.none,
        ),
        onChanged: (value) => viewModel.tempIntroduce = value,
        controller: TextEditingController(text: viewModel.tempIntroduce)
          ..selection = TextSelection.fromPosition(
            TextPosition(offset: viewModel.tempIntroduce.length),
          ),
      ),
    );
  }

  void _editMbtiType(BuildContext context, UserInfoScreenViewModel viewModel) {
    viewModel.tempMbtiType = viewModel.user!.mbtiType ?? '';
    _navigateToEdit(
      context,
      title: 'Select MBTI',
      command: viewModel.updateMbtiTypeCommand,
      builder: (context) {
        return ListenableBuilder(
          listenable: viewModel,
          builder: (context, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: viewModel.mbtiTypes.map((type) {
                return RadioListTile<String>(
                  title: Text(type),
                  value: type,
                  groupValue: viewModel.tempMbtiType,
                  onChanged: (value) {
                    if (value != null) viewModel.tempMbtiType = value;
                  },
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                );
              }).toList(),
            );
          },
        );
      },
      scrollable: true,
    );
  }

  void _navigateToEdit(
    BuildContext context, {
    required String title,
    required Command0 command,
    required WidgetBuilder builder,
    bool scrollable = false,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => _EditPropertyScreen(
          appBarTitle: title,
          command: command,
          scrollable: scrollable,
          child: builder(context),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(color: Theme.of(context).colorScheme.outlineVariant, height: 1),
    );
  }
}

class _EditPropertyScreen extends StatelessWidget {
  final String appBarTitle;
  final Widget child;
  final Command0 command;
  final bool scrollable;

  const _EditPropertyScreen({
    required this.appBarTitle,
    required this.child,
    required this.command,
    this.scrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Widget content = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: AppContainerStyles.standard(context).decoration,
      child: child,
    );

    if (scrollable) {
      content = SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: content,
      );
    } else {
      content = Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(alignment: Alignment.topCenter, child: content),
      );
    }

    return Scaffold(
      appBar: StandardAppBar(
        title: appBarTitle,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: FilledButton(
              onPressed: () async {
                command.clearResult();
                await command.execute();
                if (context.mounted) {
                  if (command.completed) {
                    if (context.canPop()) Navigator.of(context).pop();
                  } else if (command.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed: ${command.result.toString()}')),
                    );
                  }
                }
              },
              child: const Text('Save'),
            ),
          ),
        ],
      ),
      backgroundColor: colorScheme.surface,
      body: ListenableBuilder(
        listenable: command,
        builder: (context, _) {
          if (command.running) {
            return const Center(child: CircularProgressIndicator());
          }
          return content;
        },
      ),
    );
  }
}
