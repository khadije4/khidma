import 'package:flutter/material.dart';

class AppColors {
  // Colors from your palette
  static const Color federalBlue = Color(0xFF000066);
  static const Color marianBlue = Color(0xFF004080);
  static const Color honoluluBlue = Color(0xFF0080B3);
  static const Color blueGreen = Color(0xFF0099B3);
  static const Color pacificCyan = Color(0xFF00B3B3);
  static const Color vividSkyBlue = Color(0xFF33CCCC);
  static const Color nonPhotoBlue1 = Color(0xFF66CCCC);
  static const Color nonPhotoBlue2 = Color(0xFF99CCCC);
  static const Color lightCyan = Color(0xFFCCFFFF);

  // Additional colors for UI elements
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Color(0xFFBDBDBD);
  static const Color lightGrey = Color(0xFFEEEEEE);
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFE53935);
  static const Color warning = Color(0xFFFFB300);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.federalBlue,
    colorScheme: ColorScheme.light(
      primary: AppColors.federalBlue,
      secondary: AppColors.honoluluBlue,
      surface: AppColors.white,
      background: AppColors.lightGrey,
      onPrimary: AppColors.white,
      onSecondary: AppColors.white,
      onSurface: AppColors.black,
      onBackground: AppColors.black,
      error: AppColors.error,
      onError: AppColors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.federalBlue,
      foregroundColor: AppColors.white,
      centerTitle: true,
      elevation: 0,
    ),
    scaffoldBackgroundColor: AppColors.white,
    fontFamily: 'Poppins',
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: AppColors.federalBlue, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(color: AppColors.federalBlue, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(color: AppColors.federalBlue, fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(color: AppColors.federalBlue, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(color: AppColors.federalBlue, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(color: AppColors.federalBlue, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(color: AppColors.federalBlue, fontWeight: FontWeight.w600),
      titleMedium: TextStyle(color: AppColors.federalBlue, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(color: AppColors.federalBlue, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(color: AppColors.black),
      bodyMedium: TextStyle(color: AppColors.black),
      bodySmall: TextStyle(color: AppColors.black),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.honoluluBlue,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.honoluluBlue,
        side: const BorderSide(color: AppColors.honoluluBlue),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.honoluluBlue,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightGrey,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.honoluluBlue),
      ),
    ),
    cardTheme: CardTheme(
      color: AppColors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
