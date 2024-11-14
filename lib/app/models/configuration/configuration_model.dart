// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ConfigurationModel {
  int? id;
  DateTime syncDate;
  String? url;

  ConfigurationModel({
    this.id,
    required this.syncDate,
    this.url,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sync_date': syncDate.millisecondsSinceEpoch,
      'url': url,
    };
  }

  factory ConfigurationModel.fromMap(Map<String, dynamic> map) {
    return ConfigurationModel(
      id: map['id'] != null ? map['id'] as int : null,
      syncDate: DateTime.fromMillisecondsSinceEpoch(map['sync_date']),
      url: map['url'] != null ? map['url'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConfigurationModel.fromJson(String source) =>
      ConfigurationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
