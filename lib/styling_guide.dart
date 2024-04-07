import 'package:flutter/material.dart';

class AppColors {
  static const Color _white = Color(0xFFFFFFFF);
  static const Color _green = Color(0xFF3C654F);
  static const Color _lightGreen = Color(0xFF779C88);
  static const Color _red = Color(0xFFA73E3E);

  static const Color mainColor = _green;
  static const Color errorColor = _red;

  static const Color mainTextColor = _green;
  static const Color secondaryTextColor = _lightGreen;
}

class AppThemeProvider {
  static ThemeData create() => ThemeData(
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
        primary: AppColors.mainColor,
      ));
}
//
// class StyleGuide {
//   TextStyle get regularX => TextStyle(
//         fontSize: 20,
//         color: AppColors.mainColor,
//         fontWeight: FontWeight.bold,
//       );
//   TextStyle regular = TextStyle(
//     fontSize: 20,
//     color: AppColors.mainColor,
//     fontWeight: FontWeight.bold,
//   );
//
//   TextStyle get secondary => TextStyle(
//         color: AppColors._lightGreen,
//       );
//
//   TextStyle get error => TextStyle(
//         color: AppColors.errorColor,
//         fontWeight: FontWeight.bold,
//       );
// }
