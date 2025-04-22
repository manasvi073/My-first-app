import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scary_teacher2/constant/appAppbar.dart';
import 'package:scary_teacher2/constant/color_constant.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/controller/home_controller.dart';
import 'package:scary_teacher2/screens/costume_details.dart';

class CostumeScreen extends StatefulWidget {
  const CostumeScreen({super.key});

  @override
  State<CostumeScreen> createState() => _CostumeScreenState();
}

class _CostumeScreenState extends State<CostumeScreen> {
  final HomeController homeController = Get.put(HomeController());

  /*int? selectedIndex;
  List<CostumeModel> costumeList = [];
  final box = GetStorage();
  List<String> favoriteCharacters = [];*/

  /*
  @override
  void initState() {
    super.initState();
    loadCostumeData();
    loadFavorites();
  }

  Future<void> loadCostumeData() async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/costumes.json');
      log("JSON Data Loaded: $response");
      final List<dynamic> data = json.decode(response);
      setState(() {
        costumeList = data.map((json) => CostumeModel.fromJson(json)).toList();
      });
    } catch (e) {
      log('Error loading JSON: $e');
    }
  }

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

    setState(() {});
  }

  void toggleFavorite(CostumeModel costumeFav) {
    Map<String, dynamic> favoriteItem = {
      "name": costumeFav.name,
      "image": costumeFav.image,
    };

    List<Map<String, dynamic>> favorites =
        (box.read<List<dynamic>>('favorites') ?? [])
            .map((e) => Map<String, dynamic>.from(e))
            .toList();

    int index = favorites.indexWhere((item) => item['name'] == costumeFav.name);

    setState(() {
      if (index != -1) {
        favorites.removeAt(index);
        favoriteCharacters.remove(costumeFav.name);
      } else {
        favorites.add(favoriteItem);
        favoriteCharacters.add(costumeFav.name!);
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
              const AppAppbar(text: 'Costume'),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: homeController.costumeList.isEmpty
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
                          itemCount: homeController.costumeList.length,
                          itemBuilder: (context, index) {
                            final costumedata =
                                homeController.costumeList[index];
                            final isFavorite = homeController.favoriteCharacters
                                .contains(costumedata.name);

                            return GestureDetector(
                              onTap: () {
                                setState(
                                  () {
                                    homeController.selectedIndex.value = index;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CostumeDetails(
                                          costumeModel: costumedata,
                                          isFavorite: homeController
                                              .favoriteCharacters
                                              .contains(costumedata.name),
                                          onFavoriteToggle: () => homeController
                                              .toggleFavoriteCostume(
                                                  costumedata),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: _buildGridItem(
                                costumedata.image.toString(),
                                costumedata.name ?? '',
                                index == homeController.selectedIndex.value,
                                isFavorite,
                                () => homeController
                                    .toggleFavoriteCostume(costumedata),
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
    bool isFavorite,
    VoidCallback onFavoritePressed,
  ) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Obx(() {
        final isFav = homeController.favoriteCharacters.contains(title);
        return Container(
          decoration: BoxDecoration(
            color: isFav
                ? ColorConstant.appWhite
                : ColorConstant.appWhite.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              isSelected || isFav
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
                          color: /* isSelected
                            ? ColorConstant.appBlack
                            : */
                              isFav
                                  ? ColorConstant.appBlack
                                  : ColorConstant.appWhite,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: onFavoritePressed,
                      child: Icon(
                        Icons.favorite_rounded,
                        color: isFav
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
                  child: AspectRatio(
                    aspectRatio: 1.0,
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
