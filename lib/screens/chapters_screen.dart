import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scary_teacher2/constant/appAppbar.dart';
import 'package:scary_teacher2/constant/color_constant.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/controller/home_controller.dart';
import 'package:scary_teacher2/screens/chapter_detail_screen.dart';

class ChaptersScreen extends StatefulWidget {
  const ChaptersScreen({super.key});

  @override
  State<ChaptersScreen> createState() => _ChaptersScreenState();
}

class _ChaptersScreenState extends State<ChaptersScreen> {
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
              const AppAppbar(text: 'chapters'),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Obx(
                    () {
                      return homeController.chapterList.isEmpty
                          ? Center(
                              child: LoadingAnimationWidget.hexagonDots(
                                  color: ColorConstant.appWhite, size: 24))
                          : GridView.builder(
                              padding:
                                  const EdgeInsets.only(top: 5, bottom: 10),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.75,
                              ),
                              itemCount: homeController.chapterList.length,
                              itemBuilder: (context, index) {
                                final chapterdata =
                                    homeController.chapterList[index];

                                final isFavorite = homeController
                                    .favoriteCharacters
                                    .contains(chapterdata.name);

                                return GestureDetector(
                                  onTap: () {
                                    setState(
                                      () {
                                        homeController.selectedIndex.value =
                                            index;
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ChapterDetailScreen(
                                              chaptersModel: chapterdata,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: _buildGridItem(
                                    chapterdata.image.toString(),
                                    chapterdata.name!.toUpperCase(),
                                    index == homeController.selectedIndex.value,
                                    isFavorite,
                                    () => homeController
                                        .toggleFavoriteChapter(chapterdata),
                                  ),
                                );
                              },
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
    bool isFavorite,
    VoidCallback onFavoritePressed,
  ) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Obx(
        () {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                isSelected || homeController.favoriteCharacters.contains(title)
                    ? BoxShadow(
                        blurRadius: 15,
                        color: ColorConstant.appBlack.withOpacity(0.1),
                        spreadRadius: 0,
                        offset: const Offset(0, 7))
                    : const BoxShadow(
                        color: Colors.transparent,
                      ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
                Obx(() {
                  return Positioned(
                    top: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: onFavoritePressed,
                      child: Icon(
                        Icons.favorite_rounded,
                        color: homeController.favoriteCharacters.contains(title)
                            ? ColorConstant.appRed
                            : ColorConstant.appWhite.withOpacity(0.6),
                        size: 24,
                      ),
                    ),
                  );
                }),
                Positioned(
                  bottom: 10,
                  right: 5,
                  left: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        height: 45,
                        width: 140,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: homeController.favoriteCharacters
                                    .contains(title)
                                ? ColorConstant.appWhite
                                : ColorConstant.appWhite.withOpacity(0.5),
                            style: BorderStyle.solid,
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              homeController.favoriteCharacters.contains(title)
                                  ? ColorConstant.appWhite
                                  : ColorConstant.appWhite.withOpacity(0.2),
                              homeController.favoriteCharacters.contains(title)
                                  ? ColorConstant.appWhite
                                  : ColorConstant.appWhite.withOpacity(0.5),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            title.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: homeController.favoriteCharacters
                                      .contains(title)
                                  ? ColorConstant.appBlack
                                  : ColorConstant.appWhite,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'alexandriaFontBold',
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
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
