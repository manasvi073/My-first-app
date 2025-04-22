// To parse this JSON data, do
//
//     final heddensecretModel = heddensecretModelFromJson(jsonString);

import 'dart:convert';

List<HeddensecretModel> heddensecretModelFromJson(String str) => List<HeddensecretModel>.from(json.decode(str).map((x) => HeddensecretModel.fromJson(x)));

String heddensecretModelToJson(List<HeddensecretModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HeddensecretModel {
  String? name;
  String? image;
  String? largeImage;
  String? description;
  String? videoLink;

  HeddensecretModel({
    this.name,
    this.image,
    this.largeImage,
    this.description,
    this.videoLink,
  });

  factory HeddensecretModel.fromJson(Map<String, dynamic> json) => HeddensecretModel(
    name: json["name"],
    image: json["image"],
    largeImage: json["largeImage"],
    description: json["description"],
    videoLink: json["videoLink"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "largeImage": largeImage,
    "description": description,
    "videoLink": videoLink,
  };
}
