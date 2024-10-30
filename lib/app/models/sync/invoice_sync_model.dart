import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class InvoiceSyncModel {
  String id;
  DateTime date;
  int quantity;
  num price;
  num value;
  bool credit;
  String paymentType;
  String categoryId;
  DateTime createdAt;
  DateTime updatedAt;
  int? mobileId;
  InvoiceSyncModel({
    required this.id,
    required this.date,
    required this.quantity,
    required this.price,
    required this.value,
    required this.credit,
    required this.paymentType,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    this.mobileId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.toIso8601String(),
      'quantity': quantity,
      'price': price,
      'value': value,
      'credit': credit,
      'paymentType': paymentType,
      'categoryId': categoryId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'mobileId': mobileId,
    };
  }

  factory InvoiceSyncModel.fromMap(Map<String, dynamic> map) {
    return InvoiceSyncModel(
      id: map['id'] as String,
      date: DateTime.parse(map['date']),
      quantity: map['quantity'] as int,
      price: map['price'] as num,
      value: map['value'] as num,
      credit: map['credit'] as bool,
      paymentType: map['paymentType'] as String,
      categoryId: map['categoryId'] as String,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      mobileId: map['mobileId'] != null ? map['mobileId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InvoiceSyncModel.fromJson(String source) =>
      InvoiceSyncModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
