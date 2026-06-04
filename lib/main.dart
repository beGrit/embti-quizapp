import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:emombti/firebase_options.dart';
import 'package:emombti/routing/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'app_state/theme_state.dart';
import 'main_dev.dart' as development;
import 'ui/core/localization/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  development.main();
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  _MainAppState();
  late final GoRouter _routerConfig;
  late final ThemeData _themeData;

  @override
  void initState() {
    super.initState();
    _routerConfig = router(context.read());
    _themeData = context.read<ThemeState>().currentTheme;
  }

  @override
  void dispose() {
    _routerConfig.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'eMBTI',
      debugShowCheckedModeBanner: false,
      theme: _themeData,
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        AppFlowyEditorLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('zh')],
      routerConfig: _routerConfig,
    );
  }
}
