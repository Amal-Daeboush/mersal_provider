import 'dart:convert';

class RatingModel {
    int id;
    String num;
    String comment;
    DateTime createdAt;
    User user;
    List<Answer> answers;

    RatingModel({
        required this.id,
        required this.num,
        required this.comment,
        required this.createdAt,
        required this.user,
        required this.answers,
    });

    factory RatingModel.fromRawJson(String str) => RatingModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        id: json["id"],
        num: json["num"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["created_at"]),
        user: User.fromJson(json["user"]),
        answers: List<Answer>.from(json["answers"].map((x) => Answer.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "num": num,
        "comment": comment,
        "created_at": createdAt.toIso8601String(),
        "user": user.toJson(),
        "answers": List<dynamic>.from(answers.map((x) => x.toJson())),
    };
  @override
  String toString() {
    return 'RatingsModel(id: $id, num: $num, comment: $comment, createdAt: $createdAt, user: $user, answers: $answers)';
  }
}

class Answer {
    int id;
    int ratingId;
    int userId;
    String comment;
    DateTime createdAt;
    DateTime updatedAt;

    Answer({
        required this.id,
        required this.ratingId,
        required this.userId,
        required this.comment,
        required this.createdAt,
        required this.updatedAt,
    });

  @override
  String toString() {
    return 'Answer(id: $id, ratingId: $ratingId, userId: $userId, comment: $comment, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
    factory Answer.fromRawJson(String str) => Answer.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        id: json["id"],
        ratingId: json["rating_id"],
        userId: json["user_id"],
        comment: json["comment"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "rating_id": ratingId,
        "user_id": userId,
        "comment": comment,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
    
}

class User {
    int id;
    String name;
    dynamic image;

    User({
        required this.id,
        required this.name,
        required this.image,
    });

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        image: json["image"],
    );

  @override
  String toString() {
    return 'User(id: $id, name: $name, image: $image)';
  }
    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
    };
}
