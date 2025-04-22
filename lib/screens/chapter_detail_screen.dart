import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scary_teacher2/constant/appAppbar.dart';
import 'package:scary_teacher2/constant/color_constant.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/controller/home_controller.dart';
import 'package:scary_teacher2/models/chapter_model.dart';
import 'package:scary_teacher2/screens/chapter_sub_detail.dart';

class ChapterDetailScreen extends StatefulWidget {
  final ChaptersModel chaptersModel;

  const ChapterDetailScreen({super.key, required this.chaptersModel});

  @override
  State<ChapterDetailScreen> createState() => _ChapterDetailScreenState();
}

class _ChapterDetailScreenState extends State<ChapterDetailScreen> {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final List<ChapterModelData> chapterDetails =
        widget.chaptersModel.data ?? [];

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
              AppAppbar(text: widget.chaptersModel.name?.toUpperCase() ?? ''),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: chapterDetails.length,
                  itemBuilder: (context, index) {
                    final details = chapterDetails[index];

                    bool isSelected =
                        homeController.selectedIndex.value == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          homeController.selectedIndex.value = index;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChapterSubDetail(
                              chapterDetail: details,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            boxShadow: [
                              isSelected
                                  ? BoxShadow(
                                      blurRadius: 15,
                                      color: ColorConstant.appBlack
                                          .withOpacity(0.1),
                                      spreadRadius: 0,
                                      offset: const Offset(0, 7),
                                    )
                                  : const BoxShadow(
                                      color: Colors.transparent,
                                    ),
                            ],
                            color: isSelected
                                ? Colors.white.withOpacity(0.9)
                                : ColorConstant.appWhite.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    // troubledwaters['image']!,
                                    details.image.toString(),
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        // troubledwaters['title']!.toUpperCase(),
                                        details.name?.toUpperCase() ?? '',
                                        style: TextStyle(
                                          color: isSelected
                                              ? ColorConstant.appBlack
                                              : ColorConstant.appWhite,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'alexandriaFontBold',
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 35,
                                            width: 35,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? ColorConstant.appSkyBlue
                                                      .withOpacity(0.2)
                                                  : ColorConstant.appWhite,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Image.asset(
                                              ImageConstant.appGroup,
                                              height: 21,
                                              width: 21,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              // troubledwaters['description']!
                                              //     .toUpperCase(),
                                              details.description
                                                      ?.toUpperCase() ??
                                                  '',

                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                color: isSelected
                                                    ? ColorConstant.appBlack
                                                    : ColorConstant.appWhite,
                                                fontFamily: 'alexandriaFont',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
