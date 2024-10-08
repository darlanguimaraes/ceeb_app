import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class InvoiceModel {
  int? id;
  DateTime date;
  int quantity;
  double price;
  double value;
  bool credit;
  String paymentType;
  int categoryId;
  String? categoryName;
  bool sync;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? remoteId;
  InvoiceModel({
    this.id,
    required this.date,
    required this.quantity,
    required this.price,
    required this.value,
    required this.credit,
    required this.paymentType,
    required this.categoryId,
    this.categoryName,
    required this.sync,
    this.createdAt,
    this.updatedAt,
    this.remoteId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.toIso8601String(),
      'quantity': quantity,
      'price': price,
      'value': value,
      'credit': credit,
      'payment_type': paymentType,
      'category_id': categoryId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'remote_id': remoteId,
    };
  }

  factory InvoiceModel.fromMap(Map<String, dynamic> map) {
    return InvoiceModel(
      id: map['id'] != null ? map['id'] as int : null,
      date: DateTime.parse(map['date']),
      quantity: map['quantity'] as int,
      price: map['price'] as double,
      value: map['value'] as double,
      credit: map['credit'] == 1,
      paymentType: map['payment_type'] as String,
      categoryId: map['category_id'] as int,
      categoryName:
          map['category_name'] != null ? map['category_name'] as String : null,
      sync: map['sync'] == 1,
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
      remoteId: map['remote_id'] != null ? map['remote_id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InvoiceModel.fromJson(String source) =>
      InvoiceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
