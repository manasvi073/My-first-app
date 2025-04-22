import 'package:flutter/material.dart';
import 'package:scary_teacher2/constant/appAppbar.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/models/reward_model.dart';

class SpinDetailsScreen extends StatelessWidget {
  final RewardData rewardData;

  const SpinDetailsScreen({super.key, required this.rewardData});

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
              AppAppbar(
                text: rewardData.categoryName!,
              ),
              const SizedBox(height: 20),
              Center(
                child: Image.asset(
                  rewardData.categoryImage ?? '',
                  height: 250,
                  width: 250,
                ),
              ),
              const SizedBox(height: 25),
              Image.asset(ImageConstant.appSpinButton)
            ],
          ),
        ],
      ),
    );
  }
}
