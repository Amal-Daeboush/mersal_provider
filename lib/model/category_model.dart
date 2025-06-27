import 'dart:convert';

class CategoryModel {
    int id;
    String name;
    String type;
    String price;
    dynamic imag;
    DateTime createdAt;
    DateTime updatedAt;

    CategoryModel({
        required this.id,
        required this.name,
        required this.type,
        required this.price,
        required this.imag,
        required this.createdAt,
        required this.updatedAt,
    });

    factory CategoryModel.fromRawJson(String str) => CategoryModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());
 @override
  String toString() {
    return 'CategoryModel(id: $id, name: $name, type: $type, price: $price, imag: $imag, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        price: json["price"],
        imag: json["imag"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "price": price,
        "imag": imag,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
