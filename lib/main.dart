import 'package:flutter/material.dart';
import 'package:gemini_chat/resources/app_colors.dart';
import 'package:gemini_chat/views/chat_page.dart';
import 'package:gemini_chat/views/home_screen.dart';
import 'package:gemini_chat/views/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gemfi',
      theme: ThemeData(
          fontFamily: 'outfit',
          primaryColor: AppColors.primaryColor,
          primaryColorDark: AppColors.primaryColor,
          appBarTheme: AppBarTheme(
              backgroundColor: AppColors.appBarColor1, elevation: 0),
          brightness: Brightness.dark,
          scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
