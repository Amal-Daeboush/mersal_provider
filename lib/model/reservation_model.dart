// To parse this JSON data, do
//
//     final reservationModel = reservationModelFromJson(jsonString);

import 'dart:convert';

import 'package:provider_mersal/model/other_user_model.dart';

ReservationModel reservationModelFromJson(String str) => ReservationModel.fromJson(json.decode(str));

String reservationModelToJson(ReservationModel data) => json.encode(data.toJson());

class ReservationModel {
    final int id;
    final int userId;
    final int productId;
    final String status;
    final String totalPrice;
    final String originalPrice;
    final String note;
    final String productDiscountApplied;
    final String productDiscountValue;
    final dynamic productDiscountType;
    final String couponApplied;
    final String couponDiscount;
    final dynamic couponCode;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int laravelThroughKey;
    final Product product;
    final User user;
    OtherUserInfo? userInfo;

    ReservationModel({
        required this.id,
        required this.userId,
        required this.productId,
        required this.status,
        required this.totalPrice,
        required this.originalPrice,
        required this.note,
        required this.productDiscountApplied,
        required this.productDiscountValue,
        required this.productDiscountType,
        required this.couponApplied,
        required this.couponDiscount,
        required this.couponCode,
        required this.createdAt,
        required this.updatedAt,
        required this.laravelThroughKey,
        required this.product,
        required this.user,
          this.userInfo, 
    });

    factory ReservationModel.fromJson(Map<String, dynamic> json) => ReservationModel(
        id: json["id"],
        userId: json["user_id"],
        productId: json["product_id"],
        status: json["status"],
        totalPrice: json["total_price"],
        originalPrice: json["original_price"],
        note: json["note"],
        productDiscountApplied: json["product_discount_applied"],
        productDiscountValue: json["product_discount_value"],
        productDiscountType: json["product_discount_type"],
        couponApplied: json["coupon_applied"],
        couponDiscount: json["coupon_discount"],
        couponCode: json["coupon_code"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        laravelThroughKey: json["laravel_through_key"],
        product: Product.fromJson(json["product"]),
        user: User.fromJson(json["user"]),
          userInfo: null, 
        
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "product_id": productId,
        "status": status,
        "total_price": totalPrice,
        "original_price": originalPrice,
        "note": note,
        "product_discount_applied": productDiscountApplied,
        "product_discount_value": productDiscountValue,
        "product_discount_type": productDiscountType,
        "coupon_applied": couponApplied,
        "coupon_discount": couponDiscount,
        "coupon_code": couponCode,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "laravel_through_key": laravelThroughKey,
        "product": product.toJson(),
        "user": user.toJson(),
    };
}

class Product {
    final int id;
    final String name;
    final int categoryId;
    final String description;
    final String price;
    final String providerableType;
    final int providerableId;
    final dynamic quantity;
    final String timeOfService;
    final dynamic foodType;
    final DateTime createdAt;
    final DateTime updatedAt;
    final dynamic deletedAt;
    final List<Image> images;

    Product({
        required this.id,
        required this.name,
        required this.categoryId,
        required this.description,
        required this.price,
        required this.providerableType,
        required this.providerableId,
        required this.quantity,
        required this.timeOfService,
        required this.foodType,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
        required this.images,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        categoryId: json["category_id"],
        description: json["description"],
        price: json["price"],
        providerableType: json["providerable_type"],
        providerableId: json["providerable_id"],
        quantity: json["quantity"],
        timeOfService: json["time_of_service"],
        foodType: json["food_type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category_id": categoryId,
        "description": description,
        "price": price,
        "providerable_type": providerableType,
        "providerable_id": providerableId,
        "quantity": quantity,
        "time_of_service": timeOfService,
        "food_type": foodType,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
    };
}

class Image {
    final int id;
    final int productId;
    final String imag;
    final DateTime createdAt;
    final DateTime updatedAt;

    Image({
        required this.id,
        required this.productId,
        required this.imag,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        productId: json["product_id"],
        imag: json["imag"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "imag": imag,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class User {
    final int id;
    final String name;
    final dynamic googleId;
    final dynamic facebookId;
    final String otp;
    final String status;
    final String email;
    final String nationalId;
    final dynamic imagePath;
    final dynamic phone;
    final dynamic emailVerifiedAt;
    final String type;
    final DateTime createdAt;
    final DateTime updatedAt;

    User({
        required this.id,
        required this.name,
        required this.googleId,
        required this.facebookId,
        required this.otp,
        required this.status,
        required this.email,
        required this.nationalId,
        required this.imagePath,
        required this.phone,
        required this.emailVerifiedAt,
        required this.type,
        required this.createdAt,
        required this.updatedAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        googleId: json["google_id"],
        facebookId: json["facebook_id"],
        otp: json["otp"],
        status: json["status"],
        email: json["email"],
        nationalId: json["national_id"],
        imagePath: json["image_path"],
        phone: json["phone"],
        emailVerifiedAt: json["email_verified_at"],
        type: json["type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "google_id": googleId,
        "facebook_id": facebookId,
        "otp": otp,
        "status": status,
        "email": email,
        "national_id": nationalId,
        "image_path": imagePath,
        "phone": phone,
        "email_verified_at": emailVerifiedAt,
        "type": type,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
