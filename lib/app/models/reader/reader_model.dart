// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:isar/isar.dart';

part 'reader_model.g.dart';

@collection
class ReaderModel {
  Id? id;
  String name;
  String? phone;
  String? address;
  String? city;
  String? email;
  bool sync;
  bool openLoan;
  String? remoteId;
  DateTime updatedAt;
  ReaderModel({
    this.id,
    required this.name,
    this.phone,
    this.address,
    this.city,
    this.email,
    required this.sync,
    required this.openLoan,
    this.remoteId,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'address': address,
      'city': city,
      'email': email,
      'sync': sync,
      'openLoan': openLoan,
      'remoteId': remoteId,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory ReaderModel.fromMap(Map<String, dynamic> map) {
    return ReaderModel(
      id: map['id'],
      name: map['name'] as String,
      phone: map['phone'] != null ? map['phone'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      sync: map['sync'] as bool,
      openLoan: map['openLoan'] as bool,
      remoteId: map['remoteId'] != null ? map['remoteId'] as String : null,
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReaderModel.fromJson(String source) =>
      ReaderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return name;
  }
}
