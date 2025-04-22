import 'package:flutter/material.dart';
import 'package:scary_teacher2/constant/appAppbar.dart';
import 'package:scary_teacher2/constant/color_constant.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/controller/favorite_controller.dart';

class FavoriteScreen extends StatelessWidget {
  final FavoriteHelper favoriteHelper = FavoriteHelper();

  FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteList = favoriteHelper.favorites;

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
              const AppAppbar(text: 'Favorites'),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: favoriteList.isEmpty
                      ? const Center(
                          child: Text(
                            "No favorites Data added",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: ColorConstant.appWhite,
                            ),
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.only(top: 5, bottom: 10),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: favoriteList.length,
                          itemBuilder: (context, index) {
                            final favoriteItem = favoriteList[index];
                            return _buildGridItem(favoriteItem);
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

  Widget _buildGridItem(Map<String, dynamic> favoriteItem) {
    String imagePath = favoriteItem['image'] ?? '';

    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstant.appWhite,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              color: ColorConstant.appBlack.withOpacity(0.1),
              spreadRadius: 0,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      favoriteItem['name'].toString().toUpperCase(),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'alexandriaFontBold',
                        color: ColorConstant.appBlack,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.favorite_rounded,
                    color: ColorConstant.appRed,
                    size: 24,
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
      ),
    );
  }
}
