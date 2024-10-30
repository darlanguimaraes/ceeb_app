import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ReaderSyncModel {
  String id;
  String name;
  String phone;
  String? address;
  String? city;
  String? email;
  bool openLoan;
  DateTime createdAt;
  DateTime updatedAt;
  int? mobileId;
  ReaderSyncModel({
    required this.id,
    required this.name,
    required this.phone,
    this.address,
    this.city,
    this.email,
    required this.openLoan,
    required this.createdAt,
    required this.updatedAt,
    this.mobileId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      'address': address,
      'city': city,
      'email': email,
      'openLoan': openLoan,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'mobileId': mobileId,
    };
  }

  factory ReaderSyncModel.fromMap(Map<String, dynamic> map) {
    return ReaderSyncModel(
      id: map['id'] as String,
      name: map['name'] as String,
      phone: map['phone'] as String,
      address: map['address'] != null ? map['address'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      openLoan: map['openLoan'] as bool,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      mobileId: map['mobileId'] != null ? map['mobileId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReaderSyncModel.fromJson(String source) =>
      ReaderSyncModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
