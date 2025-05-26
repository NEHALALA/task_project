import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryDarkColor = Color(0xFF08160A);
  static const Color primaryLightColor = Color(0xFF2C4731);
  static const Color colorC6892F1 = Color(0xFFC6892F);
  static const Color buttonSecondaryColor = Color(0xff272710);
  static const Color colorCC7B2A = Color(0xffCC7B2A);

  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color blackColor = Color(0xFF000000);
  static Color redColor = Color(0xFFE53935);
  static Color yellowColor = Color(0xFFFF9800);
  static Color greenColor = Color(0xFF4CAF50);
  static Color blueColor = Color(0xFF2196F3);
  static Color purpleColor = Color(0xFF9C27B0);
  static Color darkerGreyColor = Color(0xff7d94a0);
  static Color greyColor = Color(0xffebe9fc);

  static const Color primaryAccentColor = Color(0xFF00A6FB);
  static const Color borderColor = Color(0xff222e1d);
  static const Color cardColor = Color(0xff212918);

  // Secondary Colors
  static const Color secondaryDarkColor = Color(0xFF2C3E50);
  static const Color secondaryLightColor = Color(0xFF3498DB);
  static const Color secondaryAccentColor = Color(0xFF2ECC71);

  // Background Colors
  static const Color backgroundColor = Color(0xFFF5F6FA);
  static const Color scaffoldBackgroundColor = Color(0xFFF5F6FA);

  // Text Colors
  static const Color textPrimaryColor = Color(0xFF2C3E50);
  static const Color textSecondaryColor = Color(0xFF7F8C8D);
  static const Color textHintColor = Color(0xff9ba09a);
  static const Color textPrimaryLightColor = Color(0xffaab3ab);

  // Status Colors
  static const Color successColor = Color(0xFF2ECC71);
  static const Color errorColor = Color(0xFFE74C3C);
  static const Color warningColor = Color(0xFFF1C40F);
  static const Color infoColor = Color(0xFF3498DB);

  // Utility Colors
  static const Color dividerColor = Color(0xFFE0E0E0);
  static const Color shadowColor = Color(0x1A000000);
  static const Color overlayColor = Color(0x80000000);
  static const Color unselectedBorderColor = Color(0xff555949);

  //textFiled colors
  static const Color textFiledColor = Color(0xff212a1a);

  //button color
  static const Color buttonColor = Color(0xffc6892f);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryDarkColor, primaryLightColor],
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [secondaryDarkColor, secondaryLightColor],
  );
}
