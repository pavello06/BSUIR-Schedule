import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_theme.dart';

class DarkTheme implements AppTheme {
  const DarkTheme({required this.primaryColor});

  final Color primaryColor;

  @override
  ThemeData get themeData => ThemeData.dark().copyWith(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: AppColors.darkBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: AppColors.foregroundColor,
    ),
    cardTheme: CardThemeData(color: AppColors.darkGrey)
  );
}
