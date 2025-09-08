import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'Views/app_main_screen.dart';


// TODO: Create and import your HomeScreen
// import 'app_main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
       Navigator.of(context).pushReplacement(
         MaterialPageRoute(builder: (context) => const AppMainScreen()
         ),
       );
      print("Navigate to home screen"); // Placeholder action
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // TODO: Replace with your app logo or a relevant image
            const Icon(Icons.food_bank, size: 100),
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 40.0,
                fontFamily: 'Horizon',
              ),
              child: AnimatedTextKit(
                totalRepeatCount: 1,
                repeatForever: false,
                animatedTexts: [
                  RotateAnimatedText(
                    'EASY',
                    textStyle: const TextStyle(color: Colors.blue),
                  ),
                  RotateAnimatedText(
                    'QUICK',
                    textStyle: const TextStyle(color: Colors.green),
                  ),
                  RotateAnimatedText(
                    'TASTY',
                    textStyle: const TextStyle(color: Colors.purple),
                  ),
                  RotateAnimatedText(
                    'Plate Up!',
                    textStyle: const TextStyle(color: Colors.purple),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
