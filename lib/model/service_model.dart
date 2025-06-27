class ServiceModel {
  final int id;
  final String name;
  final int categoryId;
  final String description;
  final String price;
  final String providerableType;
  final int providerableId;
  final String? quantity;
  final String timeOfService;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  ServiceModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.description,
    required this.price,
    required this.providerableType,
    required this.providerableId,
    this.quantity,
    required this.timeOfService,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      name: json['name'],
      categoryId: json['category_id'],
      description: json['description'],
      price: json['price'],
      providerableType: json['providerable_type'],
      providerableId: json['providerable_id'],
      quantity: json['quantity']?.toString(),
      timeOfService: json['time_of_service'].toString(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt:
          json['deleted_at'] != null ? DateTime.tryParse(json['deleted_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category_id': categoryId,
      'description': description,
      'price': price,
      'providerable_type': providerableType,
      'providerable_id': providerableId,
      'quantity': quantity,
      'time_of_service': timeOfService,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
    };
  }
}
