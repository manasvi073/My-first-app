// To parse this JSON data, do
//
//     final characterModel = characterModelFromJson(jsonString);

import 'dart:convert';

List<CharacterModel> characterModelFromJson(String str) =>
    List<CharacterModel>.from(
        json.decode(str).map((x) => CharacterModel.fromJson(x)));

String characterModelToJson(List<CharacterModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CharacterModel {
  String? name;
  String? image;
  String? largeImage;
  String? description;
  Stats? stats;

  CharacterModel({
    this.name,
    this.image,
    this.largeImage,
    this.description,
    this.stats,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) => CharacterModel(
        name: json["name"],
        image: json["image"],
        largeImage: json["largeImage"],
        description: json["description"],
        stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "largeImage": largeImage,
        "description": description,
        "stats": stats?.toJson(),
      };
}

class Stats {
  int? anger;
  int? stamina;
  int? humor;

  Stats({
    this.anger,
    this.stamina,
    this.humor,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        anger: json["anger"],
        stamina: json["stamina"],
        humor: json["humor"],
      );

  Map<String, dynamic> toJson() => {
        "anger": anger,
        "stamina": stamina,
        "humor": humor,
      };
}
