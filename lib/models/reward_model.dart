// To parse this JSON data, do
//
//     final rewardModel = rewardModelFromJson(jsonString);

import 'dart:convert';

List<RewardModel> rewardModelFromJson(String str) => List<RewardModel>.from(json.decode(str).map((x) => RewardModel.fromJson(x)));

String rewardModelToJson(List<RewardModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RewardModel {
  String? name;
  String? image;
  List<RewardData>? data;

  RewardModel({
    this.name,
    this.image,
    this.data,
  });

  factory RewardModel.fromJson(Map<String, dynamic> json) => RewardModel(
    name: json["name"],
    image: json["image"],
    data: json["Data"] == null ? [] : List<RewardData>.from(json["Data"]!.map((x) => RewardData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class RewardData {
  String? categoryName;
  String? categoryImage;

  RewardData({
    this.categoryName,
    this.categoryImage,
  });

  factory RewardData.fromJson(Map<String, dynamic> json) => RewardData(
    categoryName: json["categoryName"],
    categoryImage: json["categoryImage"],
  );

  Map<String, dynamic> toJson() => {
    "categoryName": categoryName,
    "categoryImage": categoryImage,
  };
}
