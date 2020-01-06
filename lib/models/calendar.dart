// To parse this JSON data, do
//
//     final calendar = calendarFromJson(jsonString);

import 'dart:convert';

List<Calendar> calendarFromJson(String str) => List<Calendar>.from(json.decode(str).map((x) => Calendar.fromJson(x)));

String calendarToJson(List<Calendar> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Calendar {
  String date;
  List<Schedule> schedule;

  Calendar({
    this.date,
    this.schedule,
  });

  factory Calendar.fromJson(Map<String, dynamic> json) => Calendar(
    date: json["date"],
    schedule: List<Schedule>.from(json["schedule"].map((x) => Schedule.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "schedule": List<dynamic>.from(schedule.map((x) => x.toJson())),
  };
}

class Schedule {
  String title;
  String type;
  String scheduleid;
  DateTime dateStart;
  DateTime dateEnd;
  String status;


  Schedule({
    this.title,
    this.type,
    this.scheduleid,
    this.dateStart,
    this.dateEnd,
    this.status
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    title: json["title"],
    type: json["type"],
    scheduleid: json["scheduleid"],
    dateStart: DateTime.parse(json["dateStart"]),
    dateEnd:  DateTime.parse(json["dateEnd"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "type": type,
    "scheduleid": scheduleid,
    "dateStart": dateStart.toIso8601String(),
    "dateEnd": dateEnd.toIso8601String(),
    "status":status,
  };
}
