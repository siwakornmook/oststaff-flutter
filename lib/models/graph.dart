// To parse this JSON data, do
//
//     final graphList = graphListFromJson(jsonString);

import 'dart:convert';

List<GraphList> graphListFromJson(String str) => List<GraphList>.from(json.decode(str).map((x) => GraphList.fromJson(x)));

String graphListToJson(List<GraphList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GraphList {
  String title;
  int value;

  GraphList({
    this.title,
    this.value,
  });

  factory GraphList.fromJson(Map<String, dynamic> json) => GraphList(
    title: json["title"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "value": value,
  };
}
