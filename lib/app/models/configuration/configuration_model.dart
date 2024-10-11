// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ConfigurationModel {
  int? id;
  DateTime syncDate;

  ConfigurationModel({
    this.id,
    required this.syncDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sync_date': syncDate.millisecondsSinceEpoch,
    };
  }

  factory ConfigurationModel.fromMap(Map<String, dynamic> map) {
    return ConfigurationModel(
      id: map['id'] != null ? map['id'] as int : null,
      syncDate: DateTime.fromMillisecondsSinceEpoch(map['sync_date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ConfigurationModel.fromJson(String source) =>
      ConfigurationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
