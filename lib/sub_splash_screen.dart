import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Import Lottie package
import 'package:plate_up/splash_screen.dart';

class SubSplashScreen extends StatefulWidget {
  const SubSplashScreen({super.key});

  @override
  State<SubSplashScreen> createState() => _SubSplashScreenState();
}

class _SubSplashScreenState extends State<SubSplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SplashScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Lottie Animation Added Here
            Lottie.asset(
              "assets/images/animated_icons/lottie/Food_animation.json",
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            const Text(
              "Loading...",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
