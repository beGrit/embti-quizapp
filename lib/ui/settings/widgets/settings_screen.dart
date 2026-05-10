import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final List<Map<String, dynamic>> settingsData = [
      {
        'header': '账号',
        'items': [
          {'title': '账号与安全', 'icon': Icons.security_outlined},
          {'title': '隐私设置', 'icon': Icons.lock_outlined},
        ],
      },
      {
        'header': '通用',
        'items': [
          {'title': '通用设置', 'icon': Icons.settings_suggest_outlined},
          {'title': '通知设置', 'icon': Icons.notifications_outlined},
        ],
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('设置')),
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                  child: Text(
                    section['header'],
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                ),
                Container(
                  color: colorScheme.surfaceContainer,
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
                              style: TextStyle(color: colorScheme.onSurface),
                            ),
                            trailing: Icon(
                              Icons.chevron_right,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            onTap: () {},
                          ),
                          if (item != section['items'].last)
                            Padding(
                              padding: EdgeInsets.only(left: 50, right: 50),
                              child: Divider(color: colorScheme.outlineVariant),
                            ),
                        ],
                      );
                    }).toList(),
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
