// To parse this JSON data, do
//
//     final commiessionModel = commiessionModelFromJson(jsonString);

import 'dart:convert';

CommiessionModel commiessionModelFromJson(String str) => CommiessionModel.fromJson(json.decode(str));

String commiessionModelToJson(CommiessionModel data) => json.encode(data.toJson());

class CommiessionModel {
    int? vendorId;
    String? vendorName;
    int? totalSales;
    int? totalCommission;
    List<CommissionDetail>? commissionDetails;
    Period? period;
    Filter? filter;

    CommiessionModel({
        this.vendorId,
        this.vendorName,
        this.totalSales,
        this.totalCommission,
        this.commissionDetails,
        this.period,
        this.filter,
    });

    CommiessionModel copyWith({
        int? vendorId,
        String? vendorName,
        int? totalSales,
        int? totalCommission,
        List<CommissionDetail>? commissionDetails,
        Period? period,
        Filter? filter,
    }) => 
        CommiessionModel(
            vendorId: vendorId ?? this.vendorId,
            vendorName: vendorName ?? this.vendorName,
            totalSales: totalSales ?? this.totalSales,
            totalCommission: totalCommission ?? this.totalCommission,
            commissionDetails: commissionDetails ?? this.commissionDetails,
            period: period ?? this.period,
            filter: filter ?? this.filter,
        );

    factory CommiessionModel.fromJson(Map<String, dynamic> json) => CommiessionModel(
        vendorId: json["vendor_id"],
        vendorName: json["vendor_name"],
        totalSales: json["total_sales"],
        totalCommission: json["total_commission"],
        commissionDetails: json["commission_details"] == null ? [] : List<CommissionDetail>.from(json["commission_details"]!.map((x) => CommissionDetail.fromJson(x))),
        period: json["period"] == null ? null : Period.fromJson(json["period"]),
        filter: json["filter"] == null ? null : Filter.fromJson(json["filter"]),
    );

    Map<String, dynamic> toJson() => {
        "vendor_id": vendorId,
        "vendor_name": vendorName,
        "total_sales": totalSales,
        "total_commission": totalCommission,
        "commission_details": commissionDetails == null ? [] : List<dynamic>.from(commissionDetails!.map((x) => x.toJson())),
        "period": period?.toJson(),
        "filter": filter?.toJson(),
    };
}

class CommissionDetail {
    String? orderId;
    int? productId;
    String? productName;
    int? categoryId;
    dynamic categoryName;
    String? commissionRate;
    String? orderAmount;
    int? commission;
    String? date;
    String? status;

    CommissionDetail({
        this.orderId,
        this.productId,
        this.productName,
        this.categoryId,
        this.categoryName,
        this.commissionRate,
        this.orderAmount,
        this.commission,
        this.date,
        this.status,
    });

    CommissionDetail copyWith({
        String? orderId,
        int? productId,
        String? productName,
        int? categoryId,
        dynamic categoryName,
        String? commissionRate,
        String? orderAmount,
        int? commission,
        String? date,
        String? status,
    }) => 
        CommissionDetail(
            orderId: orderId ?? this.orderId,
            productId: productId ?? this.productId,
            productName: productName ?? this.productName,
            categoryId: categoryId ?? this.categoryId,
            categoryName: categoryName ?? this.categoryName,
            commissionRate: commissionRate ?? this.commissionRate,
            orderAmount: orderAmount ?? this.orderAmount,
            commission: commission ?? this.commission,
            date: date ?? this.date,
            status: status ?? this.status,
        );

    factory CommissionDetail.fromJson(Map<String, dynamic> json) => CommissionDetail(
        orderId: json["order_id"],
        productId: json["product_id"],
        productName: json["product_name"],
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        commissionRate: json["commission_rate"],
        orderAmount: json["order_amount"],
        commission: json["commission"],
       // date: json["date"] == null ? null : DateTime.parse(json["date"]),
        status: json["status"],
        date: json["date"]
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "product_id": productId,
        "product_name": productName,
        "category_id": categoryId,
        "category_name": categoryName,
        "commission_rate": commissionRate,
        "order_amount": orderAmount,
        "commission": commission,
     //   "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "status": status,
        "date":date
    };
}

class Filter {
    String? status;
    int? ordersCount;

    Filter({
        this.status,
        this.ordersCount,
    });

    Filter copyWith({
        String? status,
        int? ordersCount,
    }) => 
        Filter(
            status: status ?? this.status,
            ordersCount: ordersCount ?? this.ordersCount,
        );

    factory Filter.fromJson(Map<String, dynamic> json) => Filter(
        status: json["status"],
        ordersCount: json["orders_count"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "orders_count": ordersCount,
    };
}

class Period {
    dynamic startDate;
    dynamic endDate;

    Period({
        this.startDate,
        this.endDate,
    });

    Period copyWith({
        dynamic startDate,
        dynamic endDate,
    }) => 
        Period(
            startDate: startDate ?? this.startDate,
            endDate: endDate ?? this.endDate,
        );

    factory Period.fromJson(Map<String, dynamic> json) => Period(
        startDate: json["start_date"],
        endDate: json["end_date"],
    );

    Map<String, dynamic> toJson() => {
        "start_date": startDate,
        "end_date": endDate,
    };
}
