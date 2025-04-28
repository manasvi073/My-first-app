import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scary_teacher2/constant/appAppbar.dart';
import 'package:scary_teacher2/constant/color_constant.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/controller/home_controller.dart';
import 'package:scary_teacher2/screens/favorite_screen.dart';
import 'package:scary_teacher2/screens/privacy_policy_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            ImageConstant.appBackground,
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppAppbar(text: 'settings'),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: homeController.settingsOptions.length,
                  itemBuilder: (context, index) {
                    bool isSelected =
                        index == homeController.selectedIndex.value;
                    return GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            homeController.selectedIndex.value = index;
                            if (homeController.settingsOptions[index]
                                    ['isToggle'] ==
                                true) {
                              homeController.isNotificationOn =
                                  !homeController.isNotificationOn;
                            } else if (homeController.settingsOptions[index]
                                    ['title'] ==
                                'Favorites') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FavoriteScreen(),
                                ),
                              );
                            } else if (homeController.settingsOptions[index]
                                    ['title'] ==
                                'Privacy Policy') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PrivacyPolicyScreen()),
                              );
                            }
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(10),
                        height: 60,
                        width: 320,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? ColorConstant.appWhite
                              : ColorConstant.appWhite.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            isSelected
                                ? BoxShadow(
                                    blurRadius: 15,
                                    color:
                                        ColorConstant.appBlack.withOpacity(0.1),
                                    spreadRadius: 0,
                                    offset: const Offset(0, 7),
                                  )
                                : const BoxShadow(
                                    color: Colors.transparent,
                                  ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  homeController.settingsOptions[index]['icon'],
                                  height: 50,
                                  width: 50,
                                ),
                                const Padding(
                                    padding: EdgeInsets.only(left: 5)),
                                Text(
                                  homeController.settingsOptions[index]['title']
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontFamily: 'alexandriaFontBold',
                                    fontSize: 14,
                                    color: isSelected
                                        ? ColorConstant.appBlack
                                        : ColorConstant.appWhite,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            if (homeController.settingsOptions[index]
                                    ['isToggle'] ==
                                true)
                              Container(
                                width: 55,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: homeController.isNotificationOn
                                        ? ColorConstant.appSkyBlue
                                        : Colors.grey,
                                    width: 5,
                                  ),
                                ),
                                child: Switch(
                                  value: homeController.isNotificationOn,
                                  onChanged: (value) {
                                    setState(() {
                                      homeController.isNotificationOn = value;
                                    });
                                  },
                                  activeColor: ColorConstant.appgreen,
                                  inactiveThumbColor: Colors.grey,
                                  activeTrackColor: Colors.transparent,
                                  inactiveTrackColor: Colors.transparent,
                                  trackOutlineColor:
                                      WidgetStateProperty.resolveWith<Color>(
                                    (Set<WidgetState> states) {
                                      return homeController.isNotificationOn
                                          ? ColorConstant.appSkyBlue
                                          : Colors.grey;
                                    },
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
