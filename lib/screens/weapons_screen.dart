import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scary_teacher2/constant/appAppbar.dart';
import 'package:scary_teacher2/constant/color_constant.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/controller/home_controller.dart';
import 'package:scary_teacher2/screens/weapons_detail_screen.dart';

class WeaponsScreen extends StatefulWidget {
  const WeaponsScreen({super.key});

  @override
  State<WeaponsScreen> createState() => _WeaponsScreenState();
}

class _WeaponsScreenState extends State<WeaponsScreen> {
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
              const AppAppbar(text: 'weapons'),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Obx(() {
                    return homeController.weaponsList.isEmpty
                        ? Center(
                            child: LoadingAnimationWidget.hexagonDots(
                                color: ColorConstant.appWhite, size: 24))
                        : GridView.builder(
                            padding: const EdgeInsets.only(top: 5, bottom: 10),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.75,
                            ),
                            itemCount: homeController.weaponsList.length,
                            itemBuilder: (context, index) {
                              final weapon = homeController.weaponsList[index];
                              final isFavorite = homeController
                                  .favoriteCharacters
                                  .contains(weapon.name);
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    homeController.selectedIndex.value = index;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            WeaponsDetailScreen(
                                          weapons: weapon,
                                          isFavorite: homeController
                                              .favoriteCharacters
                                              .contains(weapon.name),
                                          onFavoriteToggle: () => homeController
                                              .toggleFavorites(weapon),
                                        ),
                                      ),
                                    );
                                  });
                                },
                                child: _buildGridItem(
                                  weapon.image ?? '',
                                  weapon.name ?? '',
                                  index == homeController.selectedIndex.value,
                                  isFavorite,
                                  () => homeController.toggleFavorites(weapon),
                                ),
                              );
                            },
                          );
                  }),
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
    bool isFavorite,
    VoidCallback onFavoritePressed,
  ) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Obx(
        () {
          return Container(
            height: 200,
            width: 100,
            decoration: BoxDecoration(
              color: homeController.favoriteCharacters.contains(title)
                  ? ColorConstant.appWhite
                  : ColorConstant.appWhite.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                isSelected || homeController.favoriteCharacters.contains(title)
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title.toUpperCase(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'alexandriaFontBold',
                            color: homeController.favoriteCharacters
                                    .contains(title)
                                ? ColorConstant.appBlack
                                : ColorConstant.appWhite,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: onFavoritePressed,
                        child: Icon(
                          Icons.favorite_rounded,
                          color:
                              homeController.favoriteCharacters.contains(title)
                                  ? ColorConstant.appRed
                                  : ColorConstant.appWhite.withOpacity(0.6),
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
