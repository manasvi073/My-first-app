// To parse this JSON data, do
//
//     final costumeModel = costumeModelFromJson(jsonString);

import 'dart:convert';

List<CostumeModel> costumeModelFromJson(String str) => List<CostumeModel>.from(
    json.decode(str).map((x) => CostumeModel.fromJson(x)));

String costumeModelToJson(List<CostumeModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CostumeModel {
  String? name;
  String? image;
  String? description1;
  String? description2;
  String? description3;

  CostumeModel({
    this.name,
    this.image,
    this.description1,
    this.description2,
    this.description3,
  });

  factory CostumeModel.fromJson(Map<String, dynamic> json) => CostumeModel(
        name: json["name"],
        image: json["image"],
        description1: json["description1"],
        description2: json["description2"],
        description3: json["description3"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "description1": description1,
        "description2": description2,
        "description3": description3,
      };
}
