// To parse this JSON data, do
//
//     final leavetype = leavetypeFromJson(jsonString);

import 'dart:convert';

List<Leavetype> leavetypeFromJson(String str) => List<Leavetype>.from(json.decode(str).map((x) => Leavetype.fromJson(x)));

String leavetypeToJson(List<Leavetype> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Leavetype {
  String key;
  String value;

  Leavetype({
    this.key,
    this.value,
  });

  factory Leavetype.fromJson(Map<String, dynamic> json) => Leavetype(
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "value": value,
  };
}
