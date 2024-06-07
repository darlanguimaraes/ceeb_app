// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

part 'note_model.g.dart';

@collection
class NoteModel {
  Id? id;
  DateTime date;
  String text;
  bool complete;
  DateTime updatedAt;
  NoteModel({
    this.id,
    required this.date,
    required this.text,
    required this.complete,
    required this.updatedAt,
  });
}
