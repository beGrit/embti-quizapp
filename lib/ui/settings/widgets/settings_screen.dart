import 'package:emombti/ui/core/themes/theme.dart';
import 'package:emombti/ui/core/ui/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    final List<Map<String, dynamic>> settingsData = [
      {
        'header': 'Account',
        'items': [
          {'title': 'Account & Security', 'icon': Icons.security_outlined},
          {'title': 'Privacy Settings', 'icon': Icons.lock_outlined},
        ],
      },
      {
        'header': 'General',
        'items': [
          {
            'title': 'General Settings',
            'icon': Icons.settings_suggest_outlined,
          },
          {
            'title': 'Notification Settings',
            'icon': Icons.notifications_outlined,
          },
        ],
      },
      {
        'header': '',
        'items': [
          {'title': 'Logout', 'icon': Icons.notifications_outlined},
        ],
      },
    ];

    return Scaffold(
      appBar: StandardAppBar(title: 'Settings'),
      backgroundColor: colorScheme.surface,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          itemCount: settingsData.length,
          itemBuilder: (context, index) {
            final section = settingsData[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // if (section['header'] != null && section['header'].isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 5,
                  ),
                  child: Text(
                    section['header'],
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                Container(
                  decoration: AppContainerStyles.standard(context).decoration,
                  padding: EdgeInsets.all(5),
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      children: (section['items'] as List).map((item) {
                        return Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                item['icon'],
                                color: colorScheme.onSurfaceVariant,
                              ),
                              title: Text(
                                item['title'],
                                style: textTheme.bodyMedium,
                              ),
                              trailing: Icon(
                                Icons.chevron_right,
                                color: colorScheme.onSurfaceVariant,
                              ),
                              onTap: () {
                                debugPrint("Clicked: ${item['title']}");
                              },
                            ),
                            if (item != section['items'].last)
                              Padding(
                                padding: EdgeInsets.only(left: 50, right: 50),
                                child: Divider(
                                  color: colorScheme.outlineVariant,
                                ),
                              ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
