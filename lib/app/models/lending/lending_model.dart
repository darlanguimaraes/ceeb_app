// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

part 'lending_model.g.dart';

@embedded
class BookEmbedded {
  int? id;
  String? name;
}

@embedded
class ReaderEmbedded {
  int? id;
  String? name;
}

@collection
class LeadingModel {
  Id? id;
  BookEmbedded book;
  ReaderEmbedded reader;
  DateTime date;
  DateTime expectedDate;
  DateTime? deliveryDate;
  DateTime updatedAt;
  bool returned;
  bool sync;
  String? remoteId;
  LeadingModel({
    this.id,
    required this.book,
    required this.reader,
    required this.date,
    required this.expectedDate,
    this.deliveryDate,
    required this.updatedAt,
    required this.returned,
    required this.sync,
    this.remoteId,
  });
}
