import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:scary_teacher2/constant/appAppbar.dart';
import 'package:scary_teacher2/constant/color_constant.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/controller/home_controller.dart';
import 'package:scary_teacher2/screens/reward_details.dart';
import 'package:scary_teacher2/screens/scratchcard_screen.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  final HomeController homeController = Get.put(HomeController());

/*
  int? selectedIndex;
  List<RewardModel> rewardList = [];

  @override
  void initState() {
    super.initState();
    loadRewardData();
  }

  Future<void> loadRewardData() async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/rewards.json');
      final List<dynamic> data = json.decode(response);
      setState(() {
        rewardList = data.map((json) => RewardModel.fromJson(json)).toList();
      });
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error loading JSON: $e');
    }
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
              const AppAppbar(text: 'Rewards'),
              Expanded(
                child: homeController.rewardList.isEmpty
                    ? Center(
                        child: LoadingAnimationWidget.hexagonDots(
                            color: ColorConstant.appWhite, size: 24))
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: homeController.rewardList.length,
                        itemBuilder: (context, index) {
                          final rewards = homeController.rewardList[index];

                          bool isSelected =
                              homeController.selectedIndex.value == index;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                homeController.selectedIndex.value = index;
                                if (homeController.rewardList[index].name ==
                                    "Spin & Win") {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RewardDetails(rewardData: rewards),
                                      /*builder: (context) =>
                                        rewardList[index]['screen'],*/
                                    ),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ScratchcardScreen(
                                        rewardData: rewards,
                                      ),
                                    ),
                                  );
                                }
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              height: 150,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? ColorConstant.appWhite
                                    : ColorConstant.appWhite.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  isSelected
                                      ? BoxShadow(
                                          blurRadius: 15,
                                          color: ColorConstant.appBlack
                                              .withOpacity(0.1),
                                          spreadRadius: 0,
                                          // blurStyle: BlurStyle.normal,
                                          offset: const Offset(0, 7))
                                      : const BoxShadow(
                                          color: Colors.transparent,
                                        ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 1),
                                  Text(
                                    rewards.name!.toUpperCase(),
                                    // rewardList[index]['title']!.toUpperCase(),
                                    style: TextStyle(
                                      color: isSelected
                                          ? ColorConstant.appBlack
                                          : ColorConstant.appWhite,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'alexandriaFontBold',
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: 0.9,
                                      child: Image.asset(
                                        rewards.image ?? '',
                                        fit: BoxFit.cover,
                                        width: 135,
                                      ),
                                    ),
                                  ),
                                ],
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
