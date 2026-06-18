import 'package:emombti/app_state/app_config.dart';
import 'package:emombti/ui/core/themes/theme.dart';
import 'package:emombti/ui/core/ui/widgets/app_bar.dart';
import 'package:emombti/ui/core/ui/widgets/policy.dart';
import 'package:emombti/ui/settings/view_models/settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SettingsViewModel>(
      create: (context) => SettingsViewModel(
        authRepository: context.read(),
        authState: context.read(),
        appConfig: context.read(),
      ),
      child: const _SettingsScreenContent(),
    );
  }
}

class _SettingsScreenContent extends StatelessWidget {
  const _SettingsScreenContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SettingsViewModel>();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: StandardAppBar(title: 'Settings'),
      backgroundColor: colorScheme.surface,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: [
          _buildSectionHeader(context, 'Preferences'),
          Consumer<AppConfig>(
            builder: (context, appConfig, child) => Container(
              decoration: AppContainerStyles.standard(context).decoration,
              child: Column(
                children: [
                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.notifications_outlined),
                    title: const Text('Notification'),
                    trailing: Switch(
                      value: appConfig.enableNotification,
                      onChanged: viewModel.toggleNotifications,
                    ),
                  ),
                  _buildDivider(context),
                  ListTile(
                    dense: true,
                    leading: const Icon(Icons.palette_outlined),
                    title: const Text('Theme'),
                    trailing: Text(
                      _getThemeModeLabel(
                        ThemeModeOption.fromString(appConfig.themeModeVal),
                      ),
                      style: textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    onTap: () => _showThemeSelectionDialog(
                      context,
                      viewModel,
                      ThemeModeOption.fromString(appConfig.themeModeVal),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader(context, 'Community'),
          Container(
            decoration: AppContainerStyles.standard(context).decoration,
            child: Column(
              children: [
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.share_outlined),
                  title: const Text('Share App'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: viewModel.shareApp,
                ),
                _buildDivider(context),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.star_outline),
                  title: const Text('Evaluate App'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: viewModel.rateApp,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader(context, 'About'),
          Container(
            decoration: AppContainerStyles.standard(context).decoration,
            child: Column(
              children: [
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.privacy_tip_outlined),
                  title: const Text('Privacy'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showPolicyModal(context, 'privacy'),
                ),
                _buildDivider(context),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.policy),
                  title: const Text('Policy'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showPolicyModal(context, 'terms'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            decoration: AppContainerStyles.standard(context).decoration,
            child: ListTile(
              dense: true,
              // 1. Forces any vertical alignment to be perfectly centered inside the tile row
              titleAlignment: ListTileTitleAlignment.center,

              // 2. We leave 'leading: const Icon(...)' out entirely so it doesn't stay stuck to the left wall.

              // 3. Put both the Icon and Text inside a centered Row right in the title slot
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize
                    .min, // Shrinks the row to tightly fit its contents
                children: [
                  const Icon(Icons.logout, color: Colors.redAccent, size: 20),
                  const SizedBox(
                    width: 8,
                  ), // Clean separation between icon and text
                  Text(
                    'Log out',
                    style: textTheme.bodyMedium?.copyWith(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              onTap: () async {
                await viewModel.logout();
                if (context.mounted) {
                  // Navigation is handled by router based on auth state
                }
              },
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              'version ${viewModel.version}',
              style: textTheme.labelSmall?.copyWith(color: colorScheme.outline),
            ),
          ),
        ],
      ),
    );
  }

  void _showPolicyModal(BuildContext context, String type) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        expand: false,
        builder: (context, scrollController) => Column(
          children: [
            Container(
              margin: const EdgeInsets.all(12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Text(
              type == 'privacy' ? 'Privacy Policy' : 'Terms of Service',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Divider(),
            Expanded(child: PolicyWebView(policyType: type)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: textTheme.labelSmall?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(color: colorScheme.outlineVariant, height: 1),
    );
  }

  String _getThemeModeLabel(ThemeModeOption option) {
    switch (option) {
      case ThemeModeOption.system:
        return 'System';
      case ThemeModeOption.light:
        return 'Light';
      case ThemeModeOption.dark:
        return 'Dark';
    }
  }

  void _showThemeSelectionDialog(
    BuildContext context,
    SettingsViewModel viewModel,
    ThemeModeOption currentSelected,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('主题显示'),
          children: [
            _buildThemeOption(
              context,
              viewModel,
              ThemeModeOption.system,
              'System',
              currentSelected,
            ),
            _buildThemeOption(
              context,
              viewModel,
              ThemeModeOption.light,
              'Light',
              currentSelected,
            ),
            _buildThemeOption(
              context,
              viewModel,
              ThemeModeOption.dark,
              'Dark',
              currentSelected,
            ),
          ],
        );
      },
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    SettingsViewModel viewModel,
    ThemeModeOption option,
    String label,
    ThemeModeOption currentSelected,
  ) {
    return SimpleDialogOption(
      onPressed: () {
        viewModel.setThemeMode(option);
        Navigator.pop(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          if (currentSelected == option)
            Icon(
              Icons.check,
              color: Theme.of(context).colorScheme.primary,
              size: 18,
            ),
        ],
      ),
    );
  }
}
