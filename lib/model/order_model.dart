// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

import 'package:provider_mersal/model/other_user_model.dart';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
    final String orderId;
    final OrderDetails orderDetails;
    final List<Product> products;
    OtherUserInfo? userInfo;


    OrderModel({
        required this.orderId,
        required this.orderDetails,
        required this.products,
            this.userInfo, 
    });

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        orderId: json["order_id"],
        orderDetails: OrderDetails.fromJson(json["order_details"]),
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
         userInfo: null, 
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "order_details": orderDetails.toJson(),
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
    };
}

class OrderDetails {
    final int id;
    final String userId;
    final String status;
      final String delivery_fee;
    final DateTime createdAt;

    OrderDetails({required this.delivery_fee, 
        required this.id,
        required this.userId,
        required this.status,
        required this.createdAt,
    });

    factory OrderDetails.fromJson(Map<String, dynamic> json) => OrderDetails(
        id: json["id"],
        delivery_fee:json["delivery_fee"],
        userId: json["user_id"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "delivery_fee":delivery_fee,
        "status": status,
        "created_at": createdAt.toIso8601String(),
    };
}

class Product {
    final int orderProductId;
    final String productId;
    final String productName;
    final String totalPrice;
    final String quantity;
    final String status;
    final DateTime createdAt;

    Product({
        required this.orderProductId,
        required this.productId,
        required this.productName,
        required this.totalPrice,
        required this.quantity,
        required this.status,
        required this.createdAt,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        orderProductId: json["order_product_id"],
        productId: json["product_id"],
        productName: json["product_name"],
        totalPrice: json["total_price"],
        quantity: json["quantity"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "order_product_id": orderProductId,
        "product_id": productId,
        "product_name": productName,
        "total_price": totalPrice,
        "quantity": quantity,
        "status": status,
        "created_at": createdAt.toIso8601String(),
    };
}
