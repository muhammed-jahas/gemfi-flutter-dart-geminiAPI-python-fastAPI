import 'package:flutter/material.dart';

class AppColors {
  static const int _primaryValue = 0xFF6C3188; // Updated with the new primary color

  static const MaterialColor primaryColor = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xFFF1E2F4),
      100: Color(0xFFD4B5E6),
      200: Color(0xFFB887D9),
      300: Color(0xFF9B59CC),
      400: Color(0xFF843DBF),
      500: Color(_primaryValue),
      600: Color(0xFF5B166A),
      700: Color(0xFF4E1460),
      800: Color(0xFF411257),
      900: Color(0xFF290F46),
    },
  );

  static const Color alertColor = Color(0xFFE01B1B);
  static const Color secondaryColor = Color(0xFF0E403D);
  static const Color yellowColor = Color(0xFFDBFF00);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color greyColor = Color(0xFFF2F6FF);
  static const Color scaffoldBackgroundColor= Color(0xFF1C1C1C);
  static const Color appBarColor1= Color(0xFF252525);
  static const Color borderColor= Color(0xFF3A3A3A);
  static const Color greydark= Color(0xFF242424);

  // static const Color accentColor = Color(0xFF9C27B0);
  // static const Color textColor = Color(0xFF333333);
}
