import 'dart:convert';

Dashboard dashboardFromJson(String str) => Dashboard.fromJson(json.decode(str));

String dashboardToJson(Dashboard data) => json.encode(data.toJson());

class Dashboard {

  bool late;
  String id;
  String dateStart;
  String dateEnd;


  Dashboard({
    this.late,
    this.id,
    this.dateStart,
    this.dateEnd,

  });

  factory Dashboard.fromJson(Map<String, dynamic> json) => Dashboard(
    late: json["late"],
    id: json["id"],
    dateStart: json["dateStart"],
    dateEnd: json["dateEnd"],

  );

  Map<String, dynamic> toJson() => {
    "late": late,
    "id": id,
    "dateStart": dateStart,
    "dateEnd": dateEnd,

  };
}