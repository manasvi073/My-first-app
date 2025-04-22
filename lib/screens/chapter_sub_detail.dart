import 'package:flutter/material.dart';
import 'package:scary_teacher2/constant/appAppbar.dart';
import 'package:scary_teacher2/constant/color_constant.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/models/chapter_model.dart';

class ChapterSubDetail extends StatelessWidget {
  final ChapterModelData chapterDetail;

  const ChapterSubDetail({super.key, required this.chapterDetail});

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
              AppAppbar(text: chapterDetail.name!.toUpperCase()),
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
                                  child: Image.asset(
                                    chapterDetail.image ?? '',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: Icon(
                                    Icons.favorite_rounded,
                                    color:
                                        ColorConstant.appWhite.withOpacity(0.5),
                                    size: 26,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          chapterDetail.subDescription1!.toUpperCase(),
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
                          chapterDetail.subDescription2!.toUpperCase(),
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
                          chapterDetail.subDescription3!.toUpperCase(),
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
