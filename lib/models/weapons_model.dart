// To parse this JSON data, do
//
//     final weaponsModel = weaponsModelFromJson(jsonString);

import 'dart:convert';

List<WeaponsModel> weaponsModelFromJson(String str) => List<WeaponsModel>.from(json.decode(str).map((x) => WeaponsModel.fromJson(x)));

String weaponsModelToJson(List<WeaponsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WeaponsModel {
  String? name;
  String? image;
  String? description;
  Stats? stats;

  WeaponsModel({
    this.name,
    this.image,
    this.description,
    this.stats,
  });

  factory WeaponsModel.fromJson(Map<String, dynamic> json) => WeaponsModel(
    name: json["name"],
    image: json["image"],
    description: json["description"],
    stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
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
