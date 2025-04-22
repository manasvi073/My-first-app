import 'package:flutter/material.dart';
import 'package:scary_teacher2/constant/color_constant.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/screens/getstarted_screen.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'image': ImageConstant.appOnboarding1Logo,
      'title': 'Meet the Cast!',
      'description':
          'Discover the mischievous teacher and her tricky students. Each character has unique skills—use them wisely!',
    },
    {
      'image': ImageConstant.appOnboarding2Logo,
      'title': 'Gadgets & Traps!',
      'description':
          'From slingshots to stink bombs, explore fun weapons to prank the scary teacher. Choose the best tool for the job!',
    },
    {
      'image': ImageConstant.appOnboarding3Logo,
      'title': 'Dress to Trick!',
      'description':
          'Unlock crazy costumes to disguise yourself. Blend in or stand out-your choice, your prank!',
    },
  ];

  void _nextPage() {
    if (_currentIndex < onboardingData.length - 1) {
      _pageController.animateToPage(
        _currentIndex + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const GetStartedScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/onboarding_background.png',
            fit: BoxFit.cover,
          ),
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingData.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              final data = onboardingData[index];
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Image.asset(
                        data['image']!,
                        height: 290,
                        width: 250,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      data['title']!.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: 'alexandriaFontBold',
                        color: ColorConstant.appWhite,
                        fontWeight: FontWeight.w800,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        data['description']!.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: 'alexandriaFont',
                          color: ColorConstant.appWhite,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: _nextPage,
                      child: Image.asset(
                        ImageConstant.appNextButton,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
