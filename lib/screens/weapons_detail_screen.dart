import 'package:flutter/material.dart';
import 'package:scary_teacher2/constant/appAppbar.dart';
import 'package:scary_teacher2/constant/color_constant.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/models/weapons_model.dart';

class WeaponsDetailScreen extends StatefulWidget {
  final WeaponsModel weapons;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const WeaponsDetailScreen({
    super.key,
    required this.weapons,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  State<WeaponsDetailScreen> createState() => _WeaponsDetailScreenState();
}

class _WeaponsDetailScreenState extends State<WeaponsDetailScreen> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.isFavorite;
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    widget.onFavoriteToggle();
  }

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
            children: [
              // const SizedBox(height: 40),
              AppAppbar(text: widget.weapons.name!),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: ColorConstant.appWhite,
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Image.asset(
                                  widget.weapons.image.toString(),
                                  height: 333,
                                  width: 250,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: Icon(
                                  Icons.favorite_rounded,
                                  color: isFavorite
                                      ? ColorConstant.appRed
                                      : ColorConstant.appBlack.withOpacity(0.2),
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.weapons.description!.toUpperCase(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: ColorConstant.appWhite,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'alexandriaFont',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Stats'.toUpperCase(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: ColorConstant.appWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'alexandriaFontBold',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Stack(
                        children: [
                          Image.asset(
                            ImageConstant.appstats,
                            /* width: double.infinity,
                            fit: BoxFit.cover,*/
                          ),
                          Positioned(
                            top: 20,
                            left: 20,
                            right: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildStatRow("Anger",
                                    widget.weapons.stats?.anger?.toInt() ?? 70),
                                _buildStatRow(
                                    "Stamina",
                                    widget.weapons.stats?.stamina?.toInt() ??
                                        50),
                                _buildStatRow("Humor",
                                    widget.weapons.stats?.humor?.toInt() ?? 80),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label.toUpperCase(),
              style: const TextStyle(
                color: ColorConstant.appWhite,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                fontFamily: 'alexandriaFontBold',
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: ColorConstant.appblue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: value / 100,
                  child: Container(
                    height: 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [
                          ColorConstant.apppink,
                          ColorConstant.applightpink
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                ColorConstant.appOrange,
                                ColorConstant.appDeepOrange
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
