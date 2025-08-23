import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_theme.dart';

class LightTheme implements AppTheme {
  const LightTheme({required this.primaryColor});

  final Color primaryColor;

  @override
  ThemeData get themeData => ThemeData.light().copyWith(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: AppColors.lightBackgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: AppColors.foregroundColor,
    ),
    cardTheme: CardThemeData(color: AppColors.lightGrey),
    popupMenuTheme: PopupMenuThemeData(iconColor: AppColors.white)
  );
}
