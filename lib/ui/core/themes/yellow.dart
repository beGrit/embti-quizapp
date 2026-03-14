import 'package:flutter/material.dart';

class AppTheme {
  static const Color _brightYellow = Color(0xFFF5BA07);
  static const Color _pureWhite = Color(0xFFFFFFFF);
  static const Color test = Colors.amber;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: _brightYellow,
        onPrimary: Colors.black,

        secondary: Colors.black,
        onSecondary: _pureWhite,

        surface: _pureWhite,
        onSurface: Colors.black,
        onSurfaceVariant: Colors.grey,

        outline: Colors.grey.shade300,
        outlineVariant: Colors.grey.shade400,
      ),

      scaffoldBackgroundColor: _pureWhite,

      appBarTheme: const AppBarTheme(
        backgroundColor: _pureWhite,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _brightYellow,
          foregroundColor: Colors.black,
          elevation: 0,
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.black,
          side: const BorderSide(color: Colors.black, width: 1.5),
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _brightYellow,
        brightness: Brightness.dark,
      ),
      // Dark mode needs a bit of "depth," so we use a dark charcoal
      scaffoldBackgroundColor: const Color(0xFF121212),
    );
  }
}
