// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

part 'invoice_model.g.dart';

@embedded
class Category {
  int? id;
  String? name;
}

@collection
class InvoiceModel {
  Id? id;
  DateTime date;
  int quantity;
  double price;
  double value;
  bool credit;
  String paymentType;
  Category category;
  bool sync;
  DateTime updatedAt;
  String? remoteId;
  InvoiceModel({
    this.id,
    required this.date,
    required this.quantity,
    required this.price,
    required this.value,
    required this.credit,
    required this.paymentType,
    required this.category,
    required this.sync,
    required this.updatedAt,
    this.remoteId,
  });
}
