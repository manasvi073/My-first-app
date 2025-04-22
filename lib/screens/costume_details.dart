import 'package:flutter/material.dart';
import 'package:scary_teacher2/constant/appAppbar.dart';
import 'package:scary_teacher2/constant/color_constant.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/models/costume_model.dart';

class CostumeDetails extends StatefulWidget {
  final CostumeModel costumeModel;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;

  const CostumeDetails({
    super.key,
    required this.costumeModel,
    required this.isFavorite,
    required this.onFavoriteToggle,
  });

  @override
  State<CostumeDetails> createState() => _CostumeDetailsState();
}

class _CostumeDetailsState extends State<CostumeDetails> {
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
              AppAppbar(text: widget.costumeModel.name!),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: ColorConstant.appWhite,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 15,
                                  color:
                                      ColorConstant.appBlack.withOpacity(0.1),
                                  spreadRadius: 0,
                                  offset: const Offset(0, 7),
                                ),
                              ],
                            ),
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 40),
                                    child: Image.asset(
                                      widget.costumeModel.image ?? '',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Icon(
                                    Icons.favorite_rounded,
                                    color: isFavorite
                                        ? ColorConstant.appRed
                                        : ColorConstant.appBlack
                                            .withOpacity(0.2),
                                    size: 26,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          widget.costumeModel.description1!.toUpperCase(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: ColorConstant.appWhite,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'alexandriaFont',
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          widget.costumeModel.description2!.toUpperCase(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: ColorConstant.appWhite,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'alexandriaFont',
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          widget.costumeModel.description3!.toUpperCase(),
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: ColorConstant.appWhite,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'alexandriaFont',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
