// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:isar/isar.dart';

part 'category_model.g.dart';

@collection
class CategoryModel {
  Id? id;

  String name;

  double price;

  bool sync;

  String? remoteId;

  DateTime? updatedAt;
  CategoryModel({
    this.id,
    required this.name,
    required this.price,
    required this.sync,
    this.remoteId,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
      'sync': sync,
      'remoteId': remoteId,
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'] as String,
      price: map['price'] as double,
      sync: map['sync'] as bool,
      remoteId: map['remoteId'] != null ? map['remoteId'] as String : null,
      updatedAt:
          map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
