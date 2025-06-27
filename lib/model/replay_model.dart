import 'dart:convert';

class ReplayModel {
    int id;
    int rating_id;
    int userId;
    String comment;
    DateTime createdAt;
    DateTime updatedAt;

    ReplayModel({
        required this.id,
        required this.rating_id,
        required this.userId,
        required this.comment,
        required this.createdAt,
        required this.updatedAt,
    });

    factory ReplayModel.fromRawJson(String str) => ReplayModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ReplayModel.fromJson(Map<String, dynamic> json) => ReplayModel(
        id: json["id"],
        rating_id: json["rating_id"],
        userId: json["user_id"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "rating_id": rating_id,
        "user_id": userId,
        "comment": comment,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
