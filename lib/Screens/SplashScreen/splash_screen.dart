import 'dart:async';
import 'package:flutter/material.dart';
import '../../Constants/constant.dart';
import '../OnboardingScreen/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/Images/logo.png',
              height: 100,
              width: 100,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Leaf Flow',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: AppColors.backgroundColor,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
