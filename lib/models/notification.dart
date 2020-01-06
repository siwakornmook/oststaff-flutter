// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

import 'dart:convert';

List<Notification> notificationFromJson(String str) => List<Notification>.from(json.decode(str).map((x) => Notification.fromJson(x)));

String notificationToJson(List<Notification> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notification {
  String approveStatus;
  String requestId;
  String image;
  String requestName;
  String subtitle;
  String approveId;
  String status;
  String personalId;
  String dateConfirm;
  int type;
  String dialogue;

  Notification({
    this.approveStatus,
    this.requestId,
    this.image,
    this.requestName,
    this.subtitle,
    this.approveId,
    this.status,
    this.personalId,
    this.dateConfirm,
    this.type,
    this.dialogue,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    approveStatus: json["approveStatus"],
    requestId: json["requestId"],
    image: json["image"],
    requestName: json["requestName"],
    subtitle: json["subtitle"],
    approveId: json["approveId"],
    status: json["status"],
    personalId: json["personalId"],
    dateConfirm: json["dateConfirm"],
    type: json["type"],
    dialogue: json["dialogue"],
  );

  Map<String, dynamic> toJson() => {
    "approveStatus": approveStatus,
    "requestId": requestId,
    "image": image,
    "requestName": requestName,
    "subtitle": subtitle,
    "approveId": approveId,
    "status": status,
    "personalId": personalId,
    "dateConfirm": dateConfirm,
    "type": type,
    "dialogue": dialogue,
  };
}
