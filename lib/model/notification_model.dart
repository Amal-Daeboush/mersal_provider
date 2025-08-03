// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
    int? id;
    int? userId;
    String? notification;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    NotificationModel({
        this.id,
        this.userId,
        this.notification,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    NotificationModel copyWith({
        int? id,
        int? userId,
        String? notification,
        String? status,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        NotificationModel(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            notification: notification ?? this.notification,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json["id"],
        userId: json["user_id"],
        notification: json["notification"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "notification": notification,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
