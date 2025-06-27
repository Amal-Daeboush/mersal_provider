class SubscribeModel {
  final int id;
  final dynamic? userId;
  final String time;
  final String price;
  final DateTime createdAt;
  final DateTime updatedAt;

  SubscribeModel({
    required this.id,
    required this.userId,
    required this.time,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubscribeModel.fromJson(Map<String, dynamic> json) {
    return SubscribeModel(
      id: json['id'],
      userId: json['user_id'],
      time: json['time'].toString(),
      price: json['price'].toString(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'time': time,
      'price': price,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
