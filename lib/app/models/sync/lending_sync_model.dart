import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class LendingSyncModel {
  String id;
  String bookId;
  String readerId;
  DateTime date;
  DateTime expectedDate;
  DateTime? deliveryDate;
  bool returned;
  DateTime createdAt;
  DateTime updatedAt;
  int? mobileId;
  LendingSyncModel({
    required this.id,
    required this.bookId,
    required this.readerId,
    required this.date,
    required this.expectedDate,
    this.deliveryDate,
    required this.returned,
    required this.createdAt,
    required this.updatedAt,
    required this.mobileId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'bookId': bookId,
      'readerId': readerId,
      'date': date.millisecondsSinceEpoch,
      'expectedDate': expectedDate.toIso8601String(),
      'deliveryDate': deliveryDate?.toIso8601String(),
      'returned': returned,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'mobileId': mobileId,
    };
  }

  factory LendingSyncModel.fromMap(Map<String, dynamic> map) {
    return LendingSyncModel(
      id: map['id'] as String,
      bookId: map['bookId'] as String,
      readerId: map['readerId'] as String,
      date: DateTime.parse(map['date']),
      expectedDate: DateTime.parse(map['expectedDate']),
      deliveryDate: map['deliveryDate'] != null
          ? DateTime.parse(map['deliveryDate'])
          : null,
      returned: map['returned'] as bool,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      mobileId: map['mobileId'] != null ? map['mobileId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LendingSyncModel.fromJson(String source) =>
      LendingSyncModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
