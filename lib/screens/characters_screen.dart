import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scary_teacher2/constant/appAppbar.dart';
import 'package:scary_teacher2/constant/color_constant.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/controller/home_controller.dart';
import 'package:scary_teacher2/screens/characters_details_screen.dart';

class CharactersScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  CharactersScreen({super.key});

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
              const AppAppbar(text: 'characters'),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Obx(
                    () {
                      if (homeController.characterList.isEmpty) {
                        return Center(
                            child: LoadingAnimationWidget.hexagonDots(
                                color: ColorConstant.appWhite, size: 24));
                      } else {
                        return GridView.builder(
                          padding: const EdgeInsets.only(top: 5, bottom: 10),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: homeController.characterList.length,
                          itemBuilder: (context, index) {
                            final character =
                                homeController.characterList[index];
                            final isFavorite = homeController.favoriteCharacters
                                .contains(character.name);

                            return GestureDetector(
                              onTap: () {
                                homeController.selectedIndex.value = index;

                                Get.to(() => CharactersDetailsScreen(
                                    character: character,
                                    isFavorite: homeController
                                        .favoriteCharacters
                                        .contains(character.name),
                                    onFavoriteToggle: () => homeController
                                        .toggleFavorite(character)));
                              },
                              child: _buildGridItem(
                                character.image ?? '',
                                character.name ?? '',
                                index == homeController.selectedIndex.value,
                                isFavorite,
                                () => homeController.toggleFavorite(character),
                              ),
                            );
                          },
                        );
                      }
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

  Widget _buildGridItem(String imagePath, String title, bool isSelected,
      bool isFavorite, VoidCallback onFavoritePressed) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Obx(
        () {
          return Container(
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
                    : const BoxShadow(color: Colors.transparent),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title.toUpperCase(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 14,
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
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: Image.asset(
                      imagePath,
                      fit: (title.toLowerCase() ==
                              'neighbors and delivery people'
                          ? BoxFit.contain
                          : BoxFit.fill),
                      // fit: BoxFit.fill,
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
