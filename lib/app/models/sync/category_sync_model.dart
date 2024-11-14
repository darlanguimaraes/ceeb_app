import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CategorySyncModel {
  String id;
  String name;
  num? price;
  int? quantity;
  bool fixedQuantity;
  bool fixedPrice;
  DateTime createdAt;
  DateTime updatedAt;
  int? mobileId;
  CategorySyncModel({
    required this.id,
    required this.name,
    this.price,
    this.quantity,
    required this.fixedQuantity,
    required this.fixedPrice,
    required this.createdAt,
    required this.updatedAt,
    this.mobileId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
      'fixedQuantity': fixedQuantity,
      'fixedPrice': fixedPrice,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'mobileId': mobileId,
    };
  }

  factory CategorySyncModel.fromMap(Map<String, dynamic> map) {
    return CategorySyncModel(
      id: map['id'] as String,
      name: map['name'] as String,
      price: map['price'] != null ? map['price'] as num : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      fixedQuantity: map['fixedQuantity'] as bool,
      fixedPrice: map['fixedPrice'] as bool,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      mobileId: map['mobileId'] != null ? map['mobileId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategorySyncModel.fromJson(String source) =>
      CategorySyncModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
