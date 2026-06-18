import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfig extends ChangeNotifier {
  // singleton
  static final AppConfig _singleton = AppConfig._internal();
  factory AppConfig() => _singleton;
  AppConfig._internal();
  static AppConfig get instance => _singleton;

  //
  // Properties
  //
  bool firstBoot = true;
  bool onBoardingCompleted = false;

  String themeModeVal = ThemeMode.system.toString();
  ThemeMode get themeMode => themeModeVal == 'system'
      ? ThemeMode.system
      : themeModeVal == 'light'
      ? ThemeMode.light
      : ThemeMode.dark;

  bool enableNotification = true;

  void load(SharedPreferences pref) {
    firstBoot = pref.getBool('firstSync') ?? firstBoot;
    onBoardingCompleted =
        pref.getBool("onBoardingCompleted") ?? onBoardingCompleted;
    themeModeVal = pref.getString('themeMode') ?? themeModeVal;
    enableNotification =
        pref.getBool('enableNotification') ?? enableNotification;
  }

  Future<void> save() async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool("firstSync", firstBoot);
    pref.setBool("onBoardingCompleted", onBoardingCompleted);
    pref.setString("themeMode", themeModeVal);
    pref.setBool("enableNotification", enableNotification);
    notifyListeners();
  }

  Map<String, String> toMap() {
    return {
      "firstSync": firstBoot.toString(),
      "onBoardingCompleted": onBoardingCompleted.toString(),
      "themeMode": themeModeVal,
      "enableNotification": enableNotification.toString(),
    };
  }
}
