// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:isar/isar.dart';

part 'book_model.g.dart';

@collection
class BookModel {
  Id? id;
  String name;
  String author;
  String? writer;
  String code;
  bool borrow;
  bool sync;
  DateTime updatedAt;
  String? remoteId;
  BookModel({
    this.id,
    required this.name,
    required this.author,
    this.writer,
    required this.code,
    required this.borrow,
    required this.sync,
    required this.updatedAt,
    this.remoteId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'author': author,
      'writer': writer,
      'code': code,
      'borrow': borrow,
      'sync': sync,
      'updatedAt': updatedAt.toIso8601String(),
      'remoteId': remoteId,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map['id'],
      name: map['name'] as String,
      author: map['author'] as String,
      writer: map['writer'] != null ? map['writer'] as String : null,
      code: map['code'] as String,
      borrow: map['borrow'] as bool,
      sync: map['sync'] as bool,
      updatedAt: DateTime.parse(map['updatedAt']),
      remoteId: map['remoteId'] != null ? map['remoteId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
