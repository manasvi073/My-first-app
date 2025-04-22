import 'package:flutter/material.dart';
import 'package:scary_teacher2/constant/appAppbar.dart';
import 'package:scary_teacher2/constant/color_constant.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/models/hedden_secret_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class HeddensecretsDetail extends StatefulWidget {
  final HeddensecretModel heddensecretModel;

  const HeddensecretsDetail({super.key, required this.heddensecretModel});

  @override
  State<HeddensecretsDetail> createState() => _HeddensecretsDetailState();
}

class _HeddensecretsDetailState extends State<HeddensecretsDetail> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    String videoUrl = widget.heddensecretModel.videoLink!;

    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoUrl) ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              AppAppbar(text: widget.heddensecretModel.name!),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          height: 200,
                          width: 320,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: ColorConstant.appWhite,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 15,
                                color: ColorConstant.appBlack.withOpacity(0.1),
                                spreadRadius: 0,
                                offset: const Offset(0, 7),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Image.asset(
                                  widget.heddensecretModel.largeImage
                                      .toString(),
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: Icon(
                                  Icons.favorite_rounded,
                                  color:
                                      ColorConstant.appBlack.withOpacity(0.2),
                                  size: 27,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Location'.toUpperCase(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: ColorConstant.appWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'alexandriaFontBold',
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.heddensecretModel.description!.toUpperCase(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: ColorConstant.appWhite,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'alexandriaFont',
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        // height: 200,
                        // width: 320,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: ColorConstant.appWhite, width: 4),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 15,
                              color: ColorConstant.appBlack.withOpacity(0.1),
                              spreadRadius: 0,
                              offset: const Offset(0, 7),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: YoutubePlayer(
                            controller: _controller,
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: ColorConstant.appRed,
                          ),
                        ),
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
}
