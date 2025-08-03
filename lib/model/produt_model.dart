// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
    final int id;
    final String name;
    final String description;
    final String price;
    final String categoryId;
    final dynamic providerableType;
    final dynamic providerableId;
    final String? quantity;
    final String? foodType;
    final dynamic timeOfService;
    final DateTime createdAt;
    final DateTime updatedAt;
    final List<Image> images;
    final List<Rating> rating;
    final DiscountInfo discountInfo;

    ProductModel({
        required this.id,
        required this.name,
        required this.description,
        required this.price,
        required this.categoryId,
        required this.providerableType,
        required this.providerableId,
        required this.quantity,
        required this.foodType,
        required this.timeOfService,
        required this.createdAt,
        required this.updatedAt,
        required this.images,
        required this.rating,
        required this.discountInfo,
    });

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        categoryId: json["category_id"],
        providerableType: json["providerable_type"],
        providerableId: json["providerable_id"],
        quantity: json["quantity"],
        foodType: json["food_type"],
        timeOfService: json["time_of_service"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        rating: List<Rating>.from(json["rating"].map((x) => Rating.fromJson(x))),
        discountInfo: DiscountInfo.fromJson(json["discount_info"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "category_id": categoryId,
        "providerable_type": providerableType,
        "providerable_id": providerableId,
        "quantity": quantity,
        "food_type": foodType,
        "time_of_service": timeOfService,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "rating": List<dynamic>.from(rating.map((x) => x.toJson())),
        "discount_info": discountInfo.toJson(),
    };
}

class DiscountInfo {
    final bool hasDiscount;
    final String? discountValue;
    final dynamic discountType;
    final String originalPrice;
    final dynamic finalPrice;
    final DateTime? discountStartDate;
    final DateTime? discountEndDate;

    DiscountInfo({
        required this.hasDiscount,
        this.discountValue,
        this.discountType,
        required this.originalPrice,
        required this.finalPrice,
        this.discountStartDate,
        this.discountEndDate,
    });

    factory DiscountInfo.fromJson(Map<String, dynamic> json) => DiscountInfo(
        hasDiscount: json["has_discount"],
        discountValue: json["discount_value"],
        discountType: json["discount_type"],
        originalPrice: json["original_price"],
        finalPrice: json["final_price"],
        discountStartDate: json["discount_start_date"] == null ? null : DateTime.parse(json["discount_start_date"]),
        discountEndDate: json["discount_end_date"] == null ? null : DateTime.parse(json["discount_end_date"]),
    );

    Map<String, dynamic> toJson() => {
        "has_discount": hasDiscount,
        "discount_value": discountValue,
        "discount_type": discountType,
        "original_price": originalPrice,
        "final_price": finalPrice,
        "discount_start_date": discountStartDate?.toIso8601String(),
        "discount_end_date": discountEndDate?.toIso8601String(),
    };
}

class Image {
    final String url;

    Image({
        required this.url,
    });

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
    };
}

class Rating {
    final int id;
    final String num;
    final String comment;
    final DateTime createdAt;
    final User user;
    final List<Answer> answers;

    Rating({
        required this.id,
        required this.num,
        required this.comment,
        required this.createdAt,
        required this.user,
        required this.answers,
    });

    factory Rating.fromJson(Map<String, dynamic> json) => Rating(
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
}

class Answer {
    final int id;
    final int ratingId;
    final int userId;
    final String comment;
    final DateTime createdAt;
    final DateTime updatedAt;

    Answer({
        required this.id,
        required this.ratingId,
        required this.userId,
        required this.comment,
        required this.createdAt,
        required this.updatedAt,
    });

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
    final int id;
    final String name;
    final String? image;

    User({
        required this.id,
        required this.name,
         this.image,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        image: json["image"]??'',
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
    };
}
