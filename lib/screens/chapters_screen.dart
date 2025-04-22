import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scary_teacher2/constant/appappbar.dart';
import 'package:scary_teacher2/constant/color_constant.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/controller/home_controller.dart';
import 'package:scary_teacher2/models/chapter_model.dart';
import 'package:scary_teacher2/screens/chapter_detail_screen.dart';

class ChaptersScreen extends StatefulWidget {
  const ChaptersScreen({super.key});

  @override
  State<ChaptersScreen> createState() => _ChaptersScreenState();
}

class _ChaptersScreenState extends State<ChaptersScreen> {
  final HomeController homeController = Get.put(HomeController());

  // int? selectedIndex;

  // List<ChaptersModel> chapterList = [];
  // final box = GetStorage();
  // List<String> favoriteCharacters = [];

  @override
  void initState() {
    super.initState();
    // loadChapters();
    // loadFavorites();
  }

  /* Future<void> loadChapters() async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/chapters.json');
      log("JSON Data Loaded: $response");
      final List<dynamic> data = json.decode(response);
      setState(() {
        chapterList = data.map((json) => ChaptersModel.fromJson(json)).toList();
      });
    } catch (e) {
      log('Error loading JSON: $e');
    }
  }*/

  /*void loadFavorites() {
    List<dynamic>? storedFavorites = box.read<List<dynamic>>('favorites');

    if (storedFavorites != null) {
      favoriteCharacters = storedFavorites.map((e) {
        if (e is Map<String, dynamic>) {
          return e['name'] as String;
        } else if (e is String) {
          return e;
        }
        return '';
      }).toList();
    } else {
      favoriteCharacters = [];
    }
    setState(() {});
  }
*/

/*
  void toggleFavorite(ChaptersModel chapter) {
    Map<String, dynamic> favoriteItem = {
      "name": chapter.name,
      "image": chapter.image,
    };

    List<Map<String, dynamic>> favorites =
        (box.read<List<dynamic>>('favorites') ?? [])
            .map((e) => Map<String, dynamic>.from(e))
            .toList();

    int index = favorites.indexWhere((item) => item['name'] == chapter.name);

    setState(() {
      if (index != -1) {
        favorites.removeAt(index);
        favoriteCharacters.remove(chapter.name);
      } else {
        favorites.add(favoriteItem);
        favoriteCharacters.add(chapter.name!);
      }

      box.write('favorites', favorites);
      log('Favorites Data -> $favorites');
    });
  }
*/

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
                                    /*items[index]['image']!,
                                  items[index]['title']!,*/
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
          final isFav = homeController.favoriteCharacters.contains(title);


          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                isSelected || isFav
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
                Positioned(
                  top: 2,
                  right: 2,
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite_rounded,
                      color: isFav
                          ? ColorConstant.appRed
                          : ColorConstant.appWhite.withOpacity(0.6),
                      size: 24,
                    ),
                    onPressed: onFavoritePressed,
                  ),
                ),
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
                            color: isFav
                                ? ColorConstant.appWhite
                                : ColorConstant.appWhite.withOpacity(0.5),
                            style: BorderStyle.solid,
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              isFav
                                  ? ColorConstant.appWhite
                                  : ColorConstant.appWhite.withOpacity(0.2),
                              isFav
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
                              color: isFav
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