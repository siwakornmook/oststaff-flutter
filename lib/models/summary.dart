// To parse this JSON data, do
//
//     final summaryList = summaryListFromJson(jsonString);

import 'dart:convert';

List<SummaryList> summaryListFromJson(String str) => List<SummaryList>.from(json.decode(str).map((x) => SummaryList.fromJson(x)));

String summaryListToJson(List<SummaryList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SummaryList {

  String title;
  String cumulative;
  String amount;
  String remain;

  SummaryList({

    this.title,
    this.cumulative,
    this.amount,
    this.remain,
  });

  factory SummaryList.fromJson(Map<String, dynamic> json) => SummaryList(

    title: json["title"],
    cumulative: json["cumulative"],
    amount: json["amount"],
    remain: json["remain"],
  );

  Map<String, dynamic> toJson() => {

    "title": title,
    "cumulative": cumulative,
    "amount": amount,
    "remain": remain,
  };
}
