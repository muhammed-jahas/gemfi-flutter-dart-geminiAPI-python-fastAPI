import 'package:flutter/material.dart';
import 'package:gemini_chat/views/home_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    gotoHomescreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              //  decoration: BoxDecoration(
              //       image: DecorationImage(image: AssetImage('assets/images/splash-background.png'),fit: BoxFit.cover)
              //     ),
              child: Center(
                child: Image.asset(
                  'assets/images/gemfy-logo.png',
                  height: 100,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  void gotoHomescreen() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeScreen(),));
  }
}
