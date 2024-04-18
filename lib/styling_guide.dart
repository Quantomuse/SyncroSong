import 'package:flutter/material.dart';

class AppColors {
  static const Color _white = Color(0xFFFFFFFF);
  static const Color _black = Color(0xFF191919);
  static const Color _lightDark = Color(0xFFbcbcbc);
  static const Color _green = Color(0xFF079B4C);
  static const Color _lightGreen = Color(0xFF51B57F);
  static const Color _red = Color(0xFFA73E3E);

  static const Color statusBarColor = _green;
}

class AppThemeProvider {
  static ThemeData createLightTheme() => ThemeData(
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 24,
          color: AppColors._green,
        ),
        displayMedium: TextStyle(
          fontSize: 18,
          color: AppColors._green,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          fontSize: 14,
          color: AppColors._lightGreen,
        ),
      ),
      scaffoldBackgroundColor: AppColors._white,
      colorScheme: const ColorScheme.light(
        error: AppColors._red,
        primary: AppColors._green,
        background: AppColors._white,
      ));

  static ThemeData createDarkTheme() => ThemeData(
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 24,
          color: AppColors._green,
        ),
        displayMedium: TextStyle(
          fontSize: 18,
          color: AppColors._green,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          fontSize: 14,
          color: AppColors._lightGreen,
        ),
      ),
      scaffoldBackgroundColor: AppColors._black,
      colorScheme: const ColorScheme.light(
        error: AppColors._red,
        primary: AppColors._green,
        background: AppColors._lightDark,
      ));
}

extension ThemeMode on BuildContext {
  bool get isDarkMode {
    return MediaQuery.of(this).platformBrightness == Brightness.dark;
  }
}

extension HexColor on Color {
  String toHex() => "#${value.toRadixString(16).substring(2)}";
}
