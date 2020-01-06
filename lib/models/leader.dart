// To parse this JSON data, do
//
//     final leader = leaderFromJson(jsonString);

import 'dart:convert';

Leader leaderFromJson(String str) => Leader.fromJson(json.decode(str));

String leaderToJson(Leader data) => json.encode(data.toJson());

class Leader {
  String leadername;
  String leaderid;

  Leader({
    this.leadername,
    this.leaderid,
  });

  factory Leader.fromJson(Map<String, dynamic> json) => Leader(
    leadername: json["leadername"],
    leaderid: json["leaderid"],
  );

  Map<String, dynamic> toJson() => {
    "leadername": leadername,
    "leaderid": leaderid,
  };
}
