/*// To parse this JSON data, do
//
//     final chaptersModel = chaptersModelFromJson(jsonString);

import 'dart:convert';

List<ChaptersModel> chaptersModelFromJson(String str) => List<ChaptersModel>.from(json.decode(str).map((x) => ChaptersModel.fromJson(x)));

String chaptersModelToJson(List<ChaptersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChaptersModel {
  String? name;
  String? image;
  List<ChapterModelData>? data;

  ChaptersModel({
    this.name,
    this.image,
    this.data,
  });

  factory ChaptersModel.fromJson(Map<String, dynamic> json) => ChaptersModel(
    name: json["name"],
    image: json["image"],
    data: json["Data"] == null ? [] : List<ChapterModelData>.from(json["Data"]!.map((x) => ChapterModelData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ChapterModelData {
  String? image;
  String? name;
  String? description;
  String? description1;

  ChapterModelData({
    this.image,
    this.name,
    this.description,
    this.description1,
  });

  factory ChapterModelData.fromJson(Map<String, dynamic> json) => ChapterModelData(
    image: json["image"],
    name: json["name"],
    description: json["description"],
    description1: json["description1"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "name": name,
    "description": description,
    "description1": description1,
  };
}

*/
// To parse this JSON data, do
//
//     final chaptersModel = chaptersModelFromJson(jsonString);

import 'dart:convert';

List<ChaptersModel> chaptersModelFromJson(String str) => List<ChaptersModel>.from(json.decode(str).map((x) => ChaptersModel.fromJson(x)));

String chaptersModelToJson(List<ChaptersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChaptersModel {
  String? name;
  String? image;
  List<ChapterModelData>? data;

  ChaptersModel({
    this.name,
    this.image,
    this.data,
  });

  factory ChaptersModel.fromJson(Map<String, dynamic> json) => ChaptersModel(
    name: json["name"],
    image: json["image"],
    data: json["Data"] == null ? [] : List<ChapterModelData>.from(json["Data"]!.map((x) => ChapterModelData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ChapterModelData {
  String? image;
  String? name;
  String? description;
  String? description1;
  String? subDescription2;
  String? subDescription3;
  String? subDescription1;

  ChapterModelData({
    this.image,
    this.name,
    this.description,
    this.description1,
    this.subDescription2,
    this.subDescription3,
    this.subDescription1,
  });

  factory ChapterModelData.fromJson(Map<String, dynamic> json) => ChapterModelData(
    image: json["image"],
    name: json["name"],
    description: json["description"],
    description1: json["description1"],
    subDescription2: json["subDescription2"],
    subDescription3: json["subDescription3"],
    subDescription1: json["subDescription1"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
    "name": name,
    "description": description,
    "description1": description1,
    "subDescription2": subDescription2,
    "subDescription3": subDescription3,
    "subDescription1": subDescription1,
  };
}
