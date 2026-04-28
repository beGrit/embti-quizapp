import 'package:emombti/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'main_dev.dart' as development;
import 'ui/core/localization/app_localizations.dart';
import 'ui/core/themes/theme.dart';
import 'ui/core/themes/theme_util.dart';

void main() {
  development.main();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    MaterialTheme theme = MaterialTheme(
      createTextTheme(context, "Noto Sans", "Noto Sans"),
    );

    return MaterialApp.router(
      title: 'eMBTI',
      debugShowCheckedModeBanner: false,
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('zh')],
      routerConfig: router(context.read()),
    );
  }
}
