import 'package:flutter/material.dart';
import 'package:scary_teacher2/constant/appappbar.dart';
import 'package:scary_teacher2/constant/color_constant.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/models/reward_model.dart';
import 'package:scary_teacher2/screens/spin_details_screen.dart';

class RewardDetails extends StatefulWidget {
  final RewardModel rewardData;

  const RewardDetails({super.key, required this.rewardData});

  @override
  State<RewardDetails> createState() => _RewardDetailsState();
}

class _RewardDetailsState extends State<RewardDetails> {
  int? selectedIndex;
  List<RewardData> rewardList = [];

  @override
  void initState() {
    super.initState();
    rewardList = widget.rewardData.data ?? [];
  }

  /*final List<Map<String, dynamic>> rewardList = [
    {
      'title': 'Characters',
      'image': ImageConstant.appcharacter,
      'screen': const SpinCharacterScreen(),
    },
    {
      'title': 'Weapons',
      'image': ImageConstant.appweaponsgroup,
      'screen': const SpinCharacterScreen(),
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
              AppAppbar(text: '${widget.rewardData.name}'),
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
                        // itemCount: rewardList.length,
                        itemBuilder: (context, index) {
                          final rewards = rewardList[index];

                          bool isSelected = selectedIndex == index;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SpinDetailsScreen(
                                      rewardData: rewards,
                                    ),
                                  ),
                                );
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
                                  const SizedBox(width: 5),
                                  Text(
                                    // rewardList[index]['title']!.toUpperCase(),
                                    rewards.categoryName!.toUpperCase(),
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

                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: 0.9,
                                      child: Image.asset(
                                        rewards.categoryImage ?? '',
                                        fit: BoxFit.cover,
                                        width: 135,
                                      ),
                                    ),
                                  )
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
