// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  bool result;
  int httpCode;
  String data;

  Response({
    this.result,
    this.httpCode,
    this.data,
  });

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    result: json["result"],
    httpCode: json["httpCode"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "result": result,
    "httpCode": httpCode,
    "data": data,
  };
}
