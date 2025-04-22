import 'dart:async';
import 'package:flutter/material.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/screens/onboarding_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            ImageConstant.appSplashBackground,
            fit: BoxFit.cover,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 40, top: 105),
              child: Image.asset(
                ImageConstant.appScaryTeacherLogo,
                width: 300,
                height: 400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
