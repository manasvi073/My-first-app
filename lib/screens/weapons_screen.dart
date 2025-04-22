import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scary_teacher2/constant/appappbar.dart';
import 'package:scary_teacher2/constant/color_constant.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/controller/home_controller.dart';
import 'package:scary_teacher2/models/weapons_model.dart';
import 'package:scary_teacher2/screens/weapons_detail_screen.dart';

class WeaponsScreen extends StatefulWidget {
  const WeaponsScreen({super.key});

  @override
  State<WeaponsScreen> createState() => _WeaponsScreenState();
}

class _WeaponsScreenState extends State<WeaponsScreen> {
  final HomeController homeController = Get.put(HomeController());

  // int? selectedIndex;
  // List<WeaponsModel> weaponsList = [];
  // final box = GetStorage();
  // List<String> favoriteCharacters = [];

  @override
  void initState() {
    super.initState();
    // loadWeapons();
    // loadFavorites();
  }

  /*Future<void> loadWeapons() async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/weapons.json');
      log("JSON Data Loaded: $response");
      final List<dynamic> data = json.decode(response);
      setState(() {
        weaponsList = data.map((json) => WeaponsModel.fromJson(json)).toList();
      });
    } catch (e) {
      log('Error loading JSON: $e');
    }
  }
*/
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

  void toggleFavorite(WeaponsModel weaponFav) {
    Map<String, dynamic> favoriteItem = {
      "name": weaponFav.name,
      "image": weaponFav.image,
    };

    List<Map<String, dynamic>> favorites =
        (box.read<List<dynamic>>('favorites') ?? [])
            .map((e) => Map<String, dynamic>.from(e))
            .toList();

    int index = favorites.indexWhere((item) => item['name'] == weaponFav.name);

    setState(() {
      if (index != -1) {
        favorites.removeAt(index);
        favoriteCharacters.remove(weaponFav.name);
      } else {
        favorites.add(favoriteItem);
        favoriteCharacters.add(weaponFav.name!);
      }

      box.write('favorites', favorites);
      log('Favorites Data -> $favorites');
    });
  }*/

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
                              final isFavorite =
                                homeController.favoriteCharacters.contains(weapon.name);
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
                                          isFavorite:homeController.favoriteCharacters
                                              .contains(weapon.name),
                                          onFavoriteToggle: () => homeController
                                              .toggleFavorites(weapon),
                                        ),
                                      ),
                                    );
                                  });
                                },
                                child: _buildGridItem(
                                  /*items[index]['image']!,
                                items[index]['title']!,
                                items[index]['width']!,
                                items[index]['height']!,*/
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
              color: /*isSelected
              ? ColorConstant.appWhite.withOpacity(0.9)
              :*/
                  homeController.favoriteCharacters.contains(title)
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
                            color: /*isSelected
                            ? ColorConstant.appBlack
                            :*/
                                homeController.favoriteCharacters
                                        .contains(title)
                                    ? ColorConstant.appBlack
                                    : ColorConstant.appWhite,
                          ),
                        ),
                      ),
                      /*IconButton(
                    icon: Icon(
                      Icons.favorite_rounded,
                      color: isFavorite
                          ? ColorConstant.appRed
                          : ColorConstant.appWhite.withOpacity(0.5),
                      size: 24,
                    ),
                    onPressed: onFavoritePressed,
                  ),*/
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
                      // width: 150,
                      // height: 160,
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
