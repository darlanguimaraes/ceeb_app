import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class LendingModel {
  int? id;
  int bookId;
  String? bookName;
  String? bookCode;
  int readerId;
  String? readerName;
  DateTime date;
  DateTime expectedDate;
  DateTime? deliveryDate;
  bool returned;
  bool sync;
  String? remoteId;
  LendingModel({
    this.id,
    required this.bookId,
    this.bookName,
    this.bookCode,
    required this.readerId,
    this.readerName,
    required this.date,
    required this.expectedDate,
    this.deliveryDate,
    required this.returned,
    required this.sync,
    this.remoteId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'book_id': bookId,
      'reader_id': readerId,
      'date': date.millisecondsSinceEpoch,
      'expected_date': expectedDate.millisecondsSinceEpoch,
      'delivery_date': deliveryDate?.millisecondsSinceEpoch,
      'returned': returned ? 1 : 0,
      'sync': sync ? 1 : 0,
      'remote_id': remoteId,
    };
  }

  factory LendingModel.fromMap(Map<String, dynamic> map) {
    return LendingModel(
      id: map['id'] != null ? map['id'] as int : null,
      bookId: map['book_id'] as int,
      bookName: map['book_name'] != null ? map['book_name'] as String : null,
      bookCode: map['book_code'] != null ? map['book_code'] as String : null,
      readerId: map['reader_id'] as int,
      readerName:
          map['reader_name'] != null ? map['reader_name'] as String : null,
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      expectedDate: DateTime.fromMillisecondsSinceEpoch(map['expected_date']),
      deliveryDate: map['delivery_date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['delivery_date'])
          : null,
      returned: map['returned'] == 1,
      sync: map['sync'] == 1,
      remoteId: map['remote_id'] != null ? map['remote_id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LendingModel.fromJson(String source) =>
      LendingModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
