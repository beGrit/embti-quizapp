import 'package:emombti/ui/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme createTextTheme(
  BuildContext context,
  String bodyFontString,
  String displayFontString,
) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
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
  final MaterialTheme materialTheme;

  ThemeData? _customTheme;
  Brightness _currentPlatformBrightness;

  ThemeState({
    required this.materialTheme,
    required Brightness currentPlatformBrightness,
  }) : _currentPlatformBrightness = currentPlatformBrightness;

  // Syncs the system brightness with the controller
  void updatePlatformBrightness(Brightness brightness) {
    if (_currentPlatformBrightness != brightness) {
      _currentPlatformBrightness = brightness;
      if (_customTheme == null) notifyListeners();
    }
  }

  // 2. Dynamically resolve the theme data from the materialTheme property
  ThemeData get currentTheme {
    if (_customTheme != null) {
      return _customTheme!;
    }
    return _currentPlatformBrightness == Brightness.dark
        ? materialTheme.dark()
        : materialTheme.light();
  }

  // Global override trigger function (e.g., when entering a tab)
  void overrideGlobalTheme(ThemeData newTheme) {
    _customTheme = newTheme;
    notifyListeners();
  }

  // Reset back to system light/dark theme
  void resetToSystemTheme() {
    _customTheme = null;
    notifyListeners();
  }
}
