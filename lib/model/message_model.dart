import 'dart:convert';

class MessageModel {
    String message;
    int senderId;
    int receiverId;
    DateTime createdAt;

    MessageModel({
        required this.message,
        required this.senderId,
        required this.receiverId,
        required this.createdAt,
    });

    factory MessageModel.fromRawJson(String str) => MessageModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        message: json["message"],
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "sender_id": senderId,
        "receiver_id": receiverId,
        "created_at": createdAt.toIso8601String(),
    };
}
