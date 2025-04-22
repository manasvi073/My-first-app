import 'package:flutter/material.dart';
import 'package:scary_teacher2/constant/appappbar.dart';
import 'package:scary_teacher2/constant/color_constant.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/screens/favorite_screen.dart';
import 'package:scary_teacher2/screens/privacy_policy_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  int? selectedIndex;
  bool isNotificationOn = true;

  final List<Map<String, dynamic>> settingsOptions = [
    {
      'icon': ImageConstant.appNotifications,
      'title': 'Notifications',
      'isToggle': true,
    },
    {
      'icon': ImageConstant.appFavorite,
      'title': 'Favorites',
      // 'screen': const FavoriteScreen(),
    },
    {
      'icon': ImageConstant.appShare,
      'title': 'Share Us',
    },
    {
      'icon': ImageConstant.appRate,
      'title': 'Rate Us',
    },
    {
      'icon': ImageConstant.appPrivacy,
      'title': 'Privacy Policy',
    }
  ];

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
              // const SizedBox(height: 40),
              const AppAppbar(text: 'settings'),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: settingsOptions.length,
                  itemBuilder: (context, index) {
                    bool isSelected = index == selectedIndex;
                    return GestureDetector(
                      onTap: () {
                        setState(
                          () {
                            selectedIndex = index;
                            if (settingsOptions[index]['isToggle'] == true) {
                              isNotificationOn = !isNotificationOn;
                            } else if (settingsOptions[index]['title'] ==
                                'Favorites') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FavoriteScreen(),
                                ),
                              );
                            } else if (settingsOptions[index]['title'] ==
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
                                    // blurStyle: BlurStyle.normal,
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
                                  settingsOptions[index]['icon'],
                                  height: 50,
                                  width: 50,
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(left: 5)),
                                Text(
                                  settingsOptions[index]['title'].toUpperCase(),
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
                            if (settingsOptions[index]['isToggle'] == true)
                              Container(
                                width: 55,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: isNotificationOn
                                        ? ColorConstant.appSkyBlue
                                        : Colors.grey,
                                    width: 5,
                                  ),
                                ),
                                child: Switch(
                                  value: isNotificationOn,
                                  onChanged: (value) {
                                    setState(() {
                                      isNotificationOn = value;
                                    });
                                  },
                                  activeColor: ColorConstant.appgreen,
                                  inactiveThumbColor: Colors.grey,
                                  activeTrackColor: Colors.transparent,
                                  inactiveTrackColor: Colors.transparent,
                                  trackOutlineColor:
                                      WidgetStateProperty.resolveWith<Color>(
                                    (Set<WidgetState> states) {
                                      return isNotificationOn
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
