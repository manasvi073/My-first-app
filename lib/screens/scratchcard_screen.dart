import 'package:flutter/material.dart';
import 'package:scary_teacher2/constant/appappbar.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/models/reward_model.dart';


class ScratchcardScreen extends StatelessWidget {
  final RewardModel rewardData;

  const ScratchcardScreen({super.key, required this.rewardData});

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
              AppAppbar(text: rewardData.name!),
              const SizedBox(height: 20),
              Center(
                child: Image.asset(
                  rewardData.image ?? '',
                  height: 250,
                  width: 250,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
