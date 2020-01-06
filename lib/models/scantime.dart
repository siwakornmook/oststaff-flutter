// To parse this JSON data, do
//
//     final scan = scanFromJson(jsonString);

import 'dart:convert';

List<Scan> scanFromJson(String str) => List<Scan>.from(json.decode(str).map((x) => Scan.fromJson(x)));

String scanToJson(List<Scan> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Scan {
  String time;

  Scan({
    this.time,
  });

  factory Scan.fromJson(Map<String, dynamic> json) => Scan(
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "time": time,
  };
}
