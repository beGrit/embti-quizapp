import 'package:emombti/app_state/app_config.dart';
import 'package:emombti/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';

void main() async {
  Logger.root.level = Level.ALL;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load();
  SharedPreferences pref = await SharedPreferences.getInstance();
  AppConfig.instance.load(pref);

  await MainApp.main(pref);
}
