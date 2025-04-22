import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scary_teacher2/constant/appappbar.dart';
import 'package:scary_teacher2/constant/color_constant.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/controller/home_controller.dart';
import 'dart:convert';
import 'package:scary_teacher2/models/character_model.dart';
import 'package:scary_teacher2/screens/characters_details_screen.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  // int? selectedIndex;
  // List<CharacterModel> characterList = [];
  // final box = GetStorage();
  // List<String> favoriteCharacters = [];
  final HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    // loadCharacters();
    // loadFavorites();
  }

  /*Future<void> loadCharacters() async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/character.json');
      log("JSON Data Loaded: $response");
      final List<dynamic> data = json.decode(response);
      setState(() {
        characterList =
            data.map((json) => CharacterModel.fromJson(json)).toList();
      });
    } catch (e) {
      log('Error loading JSON: $e');
    }
  }
*/

/*
  void loadFavorites() {
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
  }

  void toggleFavorite(CharacterModel weapon) {
    Map<String, dynamic> favoriteItem = {
      "name": weapon.name,
      "image": weapon.image,
    };

    List<Map<String, dynamic>> favorites =
        (box.read<List<dynamic>>('favorites') ?? [])
            .map((e) => Map<String, dynamic>.from(e))
            .toList();

    int index = favorites.indexWhere((item) => item['name'] == weapon.name);

    setState(() {
      if (index != -1) {
        favorites.removeAt(index);
        favoriteCharacters.remove(weapon.name);
      } else {
        favorites.add(favoriteItem);
        favoriteCharacters.add(weapon.name!);
      }

      box.write('favorites', favorites);
      log('Favorites Data -> $favorites');
    });
  }
*/

  @override
  Widget build(BuildContext context) {
/*

     String userType = 'neighbors and delivery people';
    int crossAxisCount = userType == 'Neighbors and Delivery People' ? 1 : 2;
    double childAspectRatio =
        userType == 'Neighbors and Delivery People' ? 1.35 : 0.75;
*/
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
                            // crossAxisCount: crossAxisCount,
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
                                // index == selectedIndex,
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
                      /*GestureDetector(
                    onTap: onFavoritePressed,
                    child: Icon(
                      Icons.favorite_rounded,
                      color: isFavorite
                          ? ColorConstant.appRed
                          : ColorConstant.appWhite.withOpacity(0.6),
                      size: 24,
                    ),
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
