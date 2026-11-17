// lib/core/theme/app_fonts.dart
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppFonts {
  // Light Theme Text Styles (Using Default System Fonts)
  static TextTheme lightTextTheme = TextTheme(
    displayLarge: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.lightTextPrimary, fontFamily: 'Roboto'),
    headlineMedium: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.lightTextPrimary, fontFamily: 'Roboto'),
    titleLarge: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.lightTextPrimary, fontFamily: 'Roboto'),
    bodyLarge: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.lightTextPrimary, fontFamily: 'Roboto'),
    bodyMedium: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.lightTextSecondary, fontFamily: 'Roboto'),
    labelLarge: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: 'Roboto'),
  );

  // Dark Theme Text Styles
  static TextTheme darkTextTheme = TextTheme(
    displayLarge: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.darkTextPrimary, fontFamily: 'Roboto'),
    headlineMedium: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.darkTextPrimary, fontFamily: 'Roboto'),
    titleLarge: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.darkTextPrimary, fontFamily: 'Roboto'),
    bodyLarge: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: AppColors.darkTextPrimary, fontFamily: 'Roboto'),
    bodyMedium: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: AppColors.darkTextSecondary, fontFamily: 'Roboto'),
    labelLarge: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: 'Roboto'),
  );
}