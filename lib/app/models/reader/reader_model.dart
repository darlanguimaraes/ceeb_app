// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReaderModel {
  int? id;
  String name;
  String nameDiacritics;
  String phone;
  String? address;
  String? city;
  String? email;
  bool sync;
  bool openLoan;
  String? remoteId;
  ReaderModel({
    this.id,
    required this.name,
    required this.nameDiacritics,
    required this.phone,
    this.address,
    this.city,
    this.email,
    required this.sync,
    required this.openLoan,
    this.remoteId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'name_diacritics': nameDiacritics,
      'phone': phone,
      'address': address,
      'city': city,
      'email': email,
      'open_loan': openLoan ? 1 : 0,
      'sync': sync ? 1 : 0,
      'remote_id': remoteId,
    };
  }

  factory ReaderModel.fromMap(Map<String, dynamic> map) {
    return ReaderModel(
      id: map['id'],
      name: map['name'] as String,
      nameDiacritics: map['name_diacritics'] as String,
      phone: map['phone'] as String,
      address: map['address'] != null ? map['address'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      sync: map['sync'] == 1,
      openLoan: map['open_loan'] == 1,
      remoteId: map['remote_id'] != null ? map['remote_id'] as String : null,
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
