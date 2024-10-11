// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BookModel {
  int? id;
  String name;
  String nameDiacritics;
  String author;
  String? writer;
  String code;
  bool borrow;
  bool sync;
  String? remoteId;
  BookModel({
    this.id,
    required this.name,
    required this.nameDiacritics,
    required this.author,
    this.writer,
    required this.code,
    required this.borrow,
    required this.sync,
    this.remoteId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'name_diacritics': nameDiacritics,
      'author': author,
      'writer': writer,
      'code': code,
      'borrow': borrow ? 1 : 0,
      'remote_id': remoteId,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      nameDiacritics: map['name_diacritics'] as String,
      writer: map['writer'] != null ? map['writer'] as String : null,
      author: map['author'] as String,
      code: map['code'] as String,
      borrow: (map['borrow'] as int) == 0 ? false : true,
      sync: map['sync'] == 1,
      remoteId: map['remote_id'] != null ? map['remote_id'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
