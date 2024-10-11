import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class NoteModel {
  int? id;
  DateTime date;
  String description;
  bool complete;
  DateTime? createdAt;
  DateTime? updatedAt;
  NoteModel({
    this.id,
    required this.date,
    required this.description,
    required this.complete,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.toIso8601String(),
      'description': description,
      'complete': complete ? 1 : 0,
      'created_at': createdAt?.millisecondsSinceEpoch,
      'updated_at': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'] != null ? map['id'] as int : null,
      date: DateTime.parse(map['date']),
      description: map['description'] as String,
      complete: map['complete'] == 1,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteModel.fromJson(String source) =>
      NoteModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
