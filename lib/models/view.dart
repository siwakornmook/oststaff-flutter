// To parse this JSON data, do
//
//     final view = viewFromJson(jsonString);

import 'dart:convert';

View viewFromJson(String str) => View.fromJson(json.decode(str));

String viewToJson(View data) => json.encode(data.toJson());

class View {
  String requestName;
  String requestImg;
  String subtitle;
  String id;
  String title;
  DateTime dateTimeStart;
  DateTime dateTimeEnd;
  String description;
  String leaveTypeId;
  String leaveTypeName;
  String approvePersonalId;
  String approveName;
  List<FileAttach> fileAttach;
  String statusconfirm;
  String dialogue;


  View({
    this.requestName,
    this.requestImg,
    this.subtitle,
    this.id,
    this.title,
    this.dateTimeStart,
    this.dateTimeEnd,
    this.description,
    this.leaveTypeId,
    this.leaveTypeName,
    this.approvePersonalId,
    this.approveName,
    this.fileAttach,
    this.statusconfirm,
    this.dialogue,
  });

  factory View.fromJson(Map<String, dynamic> json) => View(
    requestName: json["requestName"],
    requestImg: json["requestImg"],
    subtitle: json["subtitle"],
    id: json["id"],
    title: json["title"],
    dateTimeStart: DateTime.parse(json["dateTimeStart"]),
    dateTimeEnd: DateTime.parse(json["dateTimeEnd"]),
    description: json["description"],
    leaveTypeId: json["leaveTypeId"],
    leaveTypeName: json["leaveTypeName"],
    approvePersonalId: json["approvePersonalId"],
    approveName: json["approveName"],
    fileAttach: List<FileAttach>.from(json["fileAttach"].map((x) => FileAttach.fromJson(x))),
    statusconfirm: json["statusconfirm"],
    dialogue: json["dialogue"],
  );

  Map<String, dynamic> toJson() => {
    "requestName": requestName,
    "requestImg": requestImg,
    "subtitle": subtitle,
    "id": id,
    "title": title,
    "dateTimeStart": dateTimeStart.toIso8601String(),
    "dateTimeEnd": dateTimeEnd.toIso8601String(),
    "description": description,
    "leaveTypeId": leaveTypeId,
    "leaveTypeName": leaveTypeName,
    "approvePersonalId": approvePersonalId,
    "approveName": approveName,
    "fileAttach": List<dynamic>.from(fileAttach.map((x) => x.toJson())),
    "statusconfirm": statusconfirm,
    "dialogue": dialogue,
  };
}

class FileAttach {
  String id;
  String url;

  FileAttach({
    this.id,
    this.url,
  });

  factory FileAttach.fromJson(Map<String, dynamic> json) => FileAttach(
    id: json["id"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
  };
}
