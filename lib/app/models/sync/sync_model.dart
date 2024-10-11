import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SyncModel {
  int created;
  int updated;
  SyncModel({
    required this.created,
    required this.updated,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'created': created,
      'updated': updated,
    };
  }

  factory SyncModel.fromMap(Map<String, dynamic> map) {
    return SyncModel(
      created: map['created'] as int,
      updated: map['updated'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory SyncModel.fromJson(String source) =>
      SyncModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
