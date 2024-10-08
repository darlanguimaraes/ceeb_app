// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CategoryModel {
  int? id;
  String name;
  double? price;
  int? quantity;
  bool sync;
  bool fixedQuantity;
  bool fixedPrice;
  String? remoteId;
  String? nameDiacritics;
  CategoryModel({
    this.id,
    required this.name,
    this.price,
    this.quantity,
    required this.sync,
    required this.fixedQuantity,
    required this.fixedPrice,
    this.remoteId,
    this.nameDiacritics,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'name_diacritics': nameDiacritics,
      'price': price,
      'sync': sync ? 1 : 0,
      'quantity': quantity,
      'fixed_quantity': fixedQuantity ? 1 : 0,
      'fixed_price': fixedPrice ? 1 : 0,
      'remote_id': remoteId,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'] as String,
      nameDiacritics: map['name_diacritics'] as String,
      price: map['price'] != null ? map['price'] as double : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      sync: map['sync'] as int == 0 ? false : true,
      fixedQuantity: map['fixed_quantity'] as int == 0 ? false : true,
      fixedPrice: map['fixed_price'] as int == 0 ? false : true,
      remoteId: map['remote_id'] != null ? map['remote_id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
