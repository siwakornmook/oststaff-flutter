import '../models/dataObj.dart';

class User {
  bool result;
  int httpCode;
  String data;
  DataObj dataObj;

  User({this.result, this.httpCode, this.data, this.dataObj});

  User.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    httpCode = json['httpCode'];
    data = json['data'] != null ? json['data'] : '';
    dataObj =
        json['dataObj'] != null ? new DataObj.fromJson(json['dataObj']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['httpCode'] = this.httpCode;
    data['data'] = this.data;
    if (this.dataObj != null) {
      data['dataObj'] = this.dataObj.toJson();
    }
    return data;
  }
}
