import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scary_teacher2/constant/appappbar.dart';
import 'package:scary_teacher2/constant/color_constant.dart';
import 'package:scary_teacher2/constant/image_constant.dart';
import 'package:scary_teacher2/models/hedden_secret_model.dart';
import 'package:scary_teacher2/screens/hedden_secrets_detail.dart';

class HeddenSecretScreen extends StatefulWidget {
  const HeddenSecretScreen({super.key});

  @override
  State<HeddenSecretScreen> createState() => _HeddenSecretScreenState();
}

class _HeddenSecretScreenState extends State<HeddenSecretScreen> {
  int? selectedIndex;
  List<HeddensecretModel> heddensecretList = [];

  @override
  void initState() {
    super.initState();
    loadheddendata();
  }

  Future<void> loadheddendata() async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/hedden_secrets.json');
      log("JSON Data Loaded: $response");
      final List<dynamic> data = json.decode(response);
      setState(() {
        heddensecretList =
            data.map((json) => HeddensecretModel.fromJson(json)).toList();
      });
    } catch (e) {
      log('Error loading JSON: $e');
    }
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 40),
              AppAppbar(text: 'Hedden Secrets'),
              const SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: heddensecretList.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: ColorConstant.appWhite,
                          ),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.only(top: 5, bottom: 10),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: heddensecretList.length,
                          itemBuilder: (context, index) {
                            final heddendata = heddensecretList[index];

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HeddensecretsDetail(
                                        heddensecretModel: heddendata,
                                      ),
                                    ),
                                  );
                                });
                              },
                              child: _buildGridItem(
                                heddendata.image ?? '',
                                heddendata.name ?? '',
                                index == selectedIndex,
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(
    String imagePath,
    String title,
    bool isSelected,
  ) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? ColorConstant.appWhite.withOpacity(0.9)
              : ColorConstant.appWhite.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            isSelected
                ? BoxShadow(
                    blurRadius: 15,
                    color: ColorConstant.appBlack.withOpacity(0.1),
                    spreadRadius: 0,
                    offset: const Offset(0, 7),
                  )
                : const BoxShadow(
                    color: Colors.transparent,
                  ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 12),
              child: Center(
                child: Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'alexandriaFontBold',
                    color: isSelected
                        ? ColorConstant.appBlack
                        : ColorConstant.appWhite,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    imagePath,
                    // height: 200,
                    // width: 280,
                    // width: double.infinity,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
