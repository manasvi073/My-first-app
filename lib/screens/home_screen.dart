import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scary_teacher2/constant/color_constant.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/controller/home_controller.dart';
import 'package:scary_teacher2/screens/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            ImageConstant.appHomeBackground,
            fit: BoxFit.fill,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Scary\nTeacher'.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: 'alexandriaFontBold',
                        color: ColorConstant.appWhite,
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        height: 1.2,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.to(() => const SettingScreen()),
                          child: Image.asset(
                            ImageConstant.appSettingLogo,
                            height: 60,
                            width: 60,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GridView.builder(
                    padding: const EdgeInsets.only(top: 9, bottom: 20),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: homeController.items.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            homeController.selectedIndex.value = index;
                          });
                          homeController.onItemTap(index);
                        },
                        child: _buildGridItem(
                          homeController.items[index]['image']!,
                          homeController.items[index]['title']!,
                          index == homeController.selectedIndex.value,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(
    String imagePath,
    String title,
    bool isSelected,
  ) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? ColorConstant.appWhite
              : ColorConstant.appWhite.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            isSelected
                ? BoxShadow(
                    blurRadius: 15,
                    color: ColorConstant.appBlack.withOpacity(0.1),
                    spreadRadius: 0,
                    offset: const Offset(0, 7),
                  )
                : const BoxShadow(
                    color: Colors.transparent,
                  ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                title.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'alexandriaFontBold',
                  color: isSelected
                      ? ColorConstant.appBlack
                      : ColorConstant.appWhite,
                ),
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                child: Align(
                  alignment: (title.toLowerCase() == 'chapters' ||
                          title.toLowerCase() == 'hidden secrets')
                      ? Alignment.centerRight
                      : Alignment.center,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    height: (title.toLowerCase() == 'weapons' ? 130 : null),
                    width: (title.toLowerCase() == 'weapons' ? 160 : null),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
