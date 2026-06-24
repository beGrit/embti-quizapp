import 'package:emombti/app_state/app_config.dart';
import 'package:emombti/ui/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme createTextTheme(
  String bodyFontString,
  String displayFontString,
  BuildContext? context,
) {
  TextTheme baseTextTheme = context == null
      ? Typography.material2021().black
      : Theme.of(context).textTheme;
  TextTheme bodyTextTheme = GoogleFonts.getTextTheme(
    bodyFontString,
    baseTextTheme,
  );
  TextTheme displayTextTheme = GoogleFonts.getTextTheme(
    displayFontString,
    baseTextTheme,
  );
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}

class ThemeState extends ChangeNotifier {
  late final Map<String, MaterialTheme> materialThemes = {};
  late final MaterialTheme _defaultMaterialTheme;
  final Brightness _brightness;
  Brightness get brightness => _brightness;

  ThemeState({required Brightness brightness}) : _brightness = brightness {
    _defaultMaterialTheme = MaterialTheme(
      createTextTheme("Noto Sans", "Noto Sans", null),
    );
    _currentMaterialTheme = _defaultMaterialTheme;
  }

  late MaterialTheme _currentMaterialTheme;
  MaterialTheme get currentMaterialTheme => _currentMaterialTheme;

  void load(AppConfig appconfig) {
    materialThemes['default'] = MaterialTheme(
      createTextTheme("Noto Sans", "Noto Sans", null),
    );
    _currentMaterialTheme = materialThemes['default'] ?? _defaultMaterialTheme;
    notifyListeners();
  }

  void switchTheme(String themeName) {
    _currentMaterialTheme = materialThemes[themeName] ?? _defaultMaterialTheme;
    notifyListeners();
  }
}
