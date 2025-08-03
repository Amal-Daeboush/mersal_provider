class UserSubscribeModel {
  final int? id;
  final String? providerServiceId;
  final String? webSubId;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? status;
  final String? price;
  final String? time;

  UserSubscribeModel({
    this.id,
    this.providerServiceId,
    this.webSubId,
    this.startDate,
    this.endDate,
    this.status,
    this.price,
    this.time,
  });

  factory UserSubscribeModel.fromJson(Map<String, dynamic> json) {
    return UserSubscribeModel(
      id: json['id'] as int?,
      providerServiceId: json['provider__service_id'],
      webSubId: json['web_sub_id'] ,
      startDate: json['start_date'] != null
          ? DateTime.tryParse(json['start_date'])
          : null,
      endDate: json['end_date'] != null
          ? DateTime.tryParse(json['end_date'])
          : null,
      status: json['status']?.toString(),
      price: json['price']?.toString(),
      time: json['time']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'provider__service_id': providerServiceId,
      'web_sub_id': webSubId,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'status': status,
      'price': price,
      'time': time,
    };
  }
}
