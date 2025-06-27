import 'dart:convert';

class MessagesModel {
    int id;
    String name;
    DateTime lastMessageAt;

    MessagesModel({
        required this.id,
        required this.name,
        required this.lastMessageAt,
    });

    factory MessagesModel.fromRawJson(String str) => MessagesModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MessagesModel.fromJson(Map<String, dynamic> json) => MessagesModel(
        id: json["id"],
        name: json["name"],
        lastMessageAt: DateTime.parse(json["last_message_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "last_message_at": lastMessageAt.toIso8601String(),
    };
}
