import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scary_teacher2/constant/color_constant.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/controller/home_controller.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final HomeController homeController = Get.put(HomeController());

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
            controller: homeController.pageController,
            itemCount: homeController.onboardingData.length,
            onPageChanged: (index) {
              setState(() {
                homeController.currentIndex.value = index;
              });
            },
            itemBuilder: (context, index) {
              final data = homeController.onboardingData[index];
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
                      onTap: () => homeController.nextPage(),
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
