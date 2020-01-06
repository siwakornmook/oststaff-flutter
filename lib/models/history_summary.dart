// To parse this JSON data, do
//
//     final historySummary = historySummaryFromJson(jsonString);

import 'dart:convert';

List<HistorySummary> historySummaryFromJson(String str) => List<HistorySummary>.from(json.decode(str).map((x) => HistorySummary.fromJson(x)));

String historySummaryToJson(List<HistorySummary> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistorySummary {
  String dateStart;
  String dateEnd;
  String title;
  String statusText;

  HistorySummary({
    this.dateStart,
    this.dateEnd,
    this.title,
    this.statusText,
  });

  factory HistorySummary.fromJson(Map<String, dynamic> json) => HistorySummary(
    dateStart: json["dateStart"],
    dateEnd: json["dateEnd"],
    title: json["title"],
    statusText: json["statusText"],
  );

  Map<String, dynamic> toJson() => {
    "dateStart": dateStart,
    "dateEnd": dateEnd,
    "title": title,
    "statusText": statusText,
  };
}
