import 'package:flutter/material.dart';

import 'package:task_project/config/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme(Color primaryColor) => ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: AppColors.whiteColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      // ignore: deprecated_member_use
      secondary: primaryColor.withOpacity(0.7),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.whiteColor,
      foregroundColor: AppColors.blackColor,
      elevation: 0,
    ),
  );

  static ThemeData darkTheme(Color primaryColor) => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: AppColors.blackColor,
    colorScheme: ColorScheme.dark(
      primary: primaryColor,
      // ignore: deprecated_member_use
      secondary: primaryColor.withOpacity(0.7),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.blackColor,
      foregroundColor: AppColors.whiteColor,
      elevation: 0,
    ),
  );
}
