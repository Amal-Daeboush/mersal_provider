import 'dart:convert';

class NotificationModel {
  String text;
  DateTime date;
//  String redirection;
  bool isRead;
  final String status;
  NotificationModel(
      {required this.text,
      required this.date,
      required this.status,
      required this.isRead});

  factory NotificationModel.fromRawJson(String str) =>
      NotificationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
          //image: json["image"],
          text: json["text"],
          status: json['status'],
          date: DateTime.parse(json["data"]), // Convert string to DateTime
          //  redirection: json["redirection"],
          isRead: json['isRead']);

  Map<String, dynamic> toJson() => {
        //     "image": image,
        "text": text,
        "data": date,
        "status": status,
        'isread': isRead
      };
}
