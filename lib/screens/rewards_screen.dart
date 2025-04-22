import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:scary_teacher2/constant/appappbar.dart';
import 'package:scary_teacher2/constant/color_constant.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/models/reward_model.dart';
import 'package:scary_teacher2/screens/reward_details.dart';
import 'package:scary_teacher2/screens/scratchcard_screen.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({super.key});

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  int? selectedIndex;

  /*List<RewardModel> rewardList = [];

  @override
  void initState() {
    super.initState();
    rewardData();
  }

  Future<void> rewardData() async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/rewards.json');
      log("JSON Data Loaded: $response");
      final List<dynamic> data = json.decode(response);
      setState(() {
        rewardList = data.map((json) => RewardModel.fromJson(json)).toList();
      });
    } catch (e) {
      log('Error loading JSON: $e');
    }
  }
*/

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

  /*final List<Map<String, dynamic>> rewardList = [
    {
      'title': 'Spin & Win',
      'image': ImageConstant.appspin,
      'screen': SpinwinScreen(),
    },
    {
      'title': 'Scratch Card',
      'image': ImageConstant.appscratchcard,
      'screen': ScratchcardScreen(),
    },
  ];*/

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
              AppAppbar(text: 'Rewards'),
              // const SizedBox(height: 20),
              Expanded(
                child: rewardList.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: ColorConstant.appWhite,
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemCount: rewardList.length,
                        itemBuilder: (context, index) {
                          final rewards = rewardList[index];

                          bool isSelected = selectedIndex == index;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                                if (rewardList[index].name == "Spin & Win") {
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
