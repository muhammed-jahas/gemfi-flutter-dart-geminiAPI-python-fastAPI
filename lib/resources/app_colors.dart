import 'package:flutter/material.dart';

class AppColors {
  static const int _primaryValue =
      0xFF8F00FF; // Updated with the new primary color

  static const MaterialColor primaryColor = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xFFF2E4FF),
      100: Color(0xFFD5B3FF),
      200: Color(0xFFB882FF),
      300: Color(0xFF9B51FF),
      400: Color(0xFF8433FF),
      500: Color(_primaryValue),
      600: Color(0xFF5A00E6),
      700: Color(0xFF4E00CC),
      800: Color(0xFF4100B3),
      900: Color(0xFF29008C),
    },
  );

  static const Color alertColor = Color(0xFFE01B1B);
  static const Color secondaryColor = Color(0xFF0E403D);
  static const Color yellowColor = Color(0xFFDBFF00);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color greyColor = Color(0xFFF2F6FF);
  static const Color scaffoldBackgroundColor = Color(0xFF1C1C1C);
  static const Color appBarColor1 = Color(0xFF252525);
  static const Color borderColor = Color(0xFF3A3A3A);
  static const Color greydark = Color(0xFF242424);

  // static const Color accentColor = Color(0xFF9C27B0);
  // static const Color textColor = Color(0xFF333333);
}
