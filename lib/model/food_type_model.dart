// To parse this JSON data, do
//
//     final foodTypeModel = foodTypeModelFromJson(jsonString);

import 'dart:convert';

FoodTypeModel foodTypeModelFromJson(String str) => FoodTypeModel.fromJson(json.decode(str));

String foodTypeModelToJson(FoodTypeModel data) => json.encode(data.toJson());

class FoodTypeModel {
    final int id;
    final String title;
    final DateTime createdAt;
    final DateTime updatedAt;

    FoodTypeModel({
        required this.id,
        required this.title,
        required this.createdAt,
        required this.updatedAt,
    });

    factory FoodTypeModel.fromJson(Map<String, dynamic> json) => FoodTypeModel(
        id: json["id"],
        title: json["title"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
