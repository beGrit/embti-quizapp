import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:emombti/app_state/theme.dart';
import 'package:emombti/change_notifiers.dart';
import 'package:emombti/manager/app_state_manager.dart';
import 'package:emombti/manager/repository_manager.dart';
import 'package:emombti/manager/storage_manager.dart';
import 'package:emombti/routing/router.dart';
import 'package:emombti/ui/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'ui/core/localization/app_localizations.dart';

class MainApp extends StatefulWidget {
  static Future<void> main() async {
    var storageManager = StorageManager();
    await storageManager.buildStorage();
    var repositoryManager = RepositoryManager();
    await repositoryManager.buildRepositories(storageManager);
    var appStateManager = AppStateManager();
    await appStateManager.buildAppState(
      storageManager: storageManager,
      repositoryManager: repositoryManager,
    );
    runApp(
      MainAppChangeNotifers(
        storageManager: storageManager,
        repositoryManager: repositoryManager,
        appStateManager: appStateManager,
        child: const MainApp(),
      ),
    );
  }

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
  }

  @override
  void dispose() {
    _routerConfig.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    final materialTheme = MaterialTheme(
      createTextTheme(context, "Noto Sans", "Noto Sans"),
    );
    ThemeState themeState = ThemeState(
      materialTheme: materialTheme,
      currentPlatformBrightness: brightness,
    );
    return ChangeNotifierProvider.value(
      value: themeState,
      child: Consumer<ThemeState>(
        builder: (context, value, child) {
          return MaterialApp.router(
            title: 'eMBTI',
            debugShowCheckedModeBanner: false,
            theme: value.currentTheme,
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
        },
      ),
    );
  }
}
