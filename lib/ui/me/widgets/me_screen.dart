import 'package:emombti/routing/routes.dart';
import 'package:emombti/ui/core/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../view_models/me_viewmodel.dart';

class MeScreen extends StatefulWidget {
  const MeScreen({super.key, this.showBackButton = false});

  final bool showBackButton;

  @override
  State<StatefulWidget> createState() => _MeScreenState();
}

class _MeScreenState extends State<MeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ChangeNotifierProvider(
      create: (_) => MeViewModel(context.read()),
      child: Consumer<MeViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: _MeScreenAppBar(showBackButton: widget.showBackButton),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  _buildHeader(theme, viewModel),
                  const Divider(),
                  _buildMenuSection(context, theme, viewModel),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(ThemeData theme, MeViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: theme.colorScheme.primaryContainer,
            child: Text(
              viewModel.userName[0],
              style: theme.textTheme.headlineMedium,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            viewModel.userName,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Chip(
            label: Text(viewModel.mbtiType),
            backgroundColor: theme.colorScheme.secondaryContainer,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(
    BuildContext context,
    ThemeData theme,
    MeViewModel viewModel,
  ) {
    return Column(
      children: [
        _buildListTile(Icons.person_outline, "Account Info", () {}),
        _buildListTile(Icons.history, "Testing History", () {}),
        _buildListTile(Icons.favorite_border, "Saved Playlists", () {}),
        _buildListTile(Icons.help_outline, "Help & Feedback", () {}),
        const SizedBox(height: 20),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.redAccent),
          title: const Text(
            "Logout",
            style: TextStyle(color: Colors.redAccent),
          ),
          onTap: () => viewModel.logout(),
        ),
      ],
    );
  }

  Widget _buildListTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}

class _MeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;

  const _MeScreenAppBar({required this.showBackButton});

  @override
  Widget build(BuildContext context) {
    return StandardAppBar(
      title: "Profile",
      leading: showBackButton ? const BackButton() : null,
      actions: [
        IconButton(
          icon: const Icon(Icons.qr_code_scanner),
          onPressed: () => _openScanner(context),
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined),
          onPressed: () => context.push(Routes.settings),
        ),
      ],
    );
  }

  void _openScanner(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);

    final String? result = await context.push<String>(Routes.qRCodeScanner);

    if (result != null && result.isNotEmpty) {
      messenger.showSnackBar(
        SnackBar(
          content: Text('Qr Scanner Result: $result'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
