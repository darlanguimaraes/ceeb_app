import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BookSyncModel {
  String id;
  String name;
  String author;
  String? writer;
  String code;
  bool borrow;
  String? edition;
  DateTime createdAt;
  DateTime updatedAt;
  int? mobileId;
  BookSyncModel({
    required this.id,
    required this.name,
    required this.author,
    this.writer,
    required this.code,
    required this.borrow,
    this.edition,
    required this.createdAt,
    required this.updatedAt,
    this.mobileId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'author': author,
      'writer': writer,
      'code': code,
      'borrow': borrow,
      'edition': edition,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'mobileId': mobileId,
    };
  }

  factory BookSyncModel.fromMap(Map<String, dynamic> map) {
    return BookSyncModel(
      id: map['id'] as String,
      name: map['name'] as String,
      author: map['author'] as String,
      writer: map['writer'] != null ? map['writer'] as String : null,
      code: map['code'] as String,
      borrow: map['borrow'] as bool,
      edition: map['edition'] != null ? map['edition'] as String : null,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      mobileId: map['mobileId'] != null ? map['mobileId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookSyncModel.fromJson(String source) =>
      BookSyncModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
