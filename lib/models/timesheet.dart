// To parse this JSON data, do
//
//     final timesheet = timesheetFromJson(jsonString);

import 'dart:convert';

List<Timesheet> timesheetFromJson(String str) => List<Timesheet>.from(json.decode(str).map((x) => Timesheet.fromJson(x)));

String timesheetToJson(List<Timesheet> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Timesheet {
  String id;
  String dateStart;
  String dateEnd;
  String titleStart;
  String titleEnd;
  bool remarkStatus;
  String remarkNote;
  bool state;
  String title;

  Timesheet({
    this.id,
    this.dateStart,
    this.dateEnd,
    this.titleStart,
    this.titleEnd,
    this.remarkStatus,
    this.remarkNote,
    this.state,
    this.title,
  });

  factory Timesheet.fromJson(Map<String, dynamic> json) => Timesheet(
    id: json["id"],
    dateStart: json["dateStart"],
    dateEnd: json["dateEnd"],
    titleStart: json["titleStart"],
    titleEnd: json["titleEnd"],
    remarkStatus: json["remarkStatus"],
    remarkNote: json["remarkNote"],
    state: json["state"],
    title: json["title"] == null ? null : json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dateStart": dateStart,
    "dateEnd": dateEnd,
    "titleStart": titleStart,
    "titleEnd": titleEnd,
    "remarkStatus": remarkStatus,
    "remarkNote": remarkNote,
    "state": state,
    "title": title == null ? null : title,
  };
}
