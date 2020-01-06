import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/models/api_service.dart';
import 'package:starter/models/remark.dart';

import 'package:starter/models/timesheet.dart';

class TimesheetService {
  Future<List<Timesheet>> getTimesheetList({dateStart, dateEnd}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url =
        '${ApiService.apiUrl}/timesheet?dateStart=$dateStart&dateEnd=$dateEnd';
    print(url);

    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'token': prefs.getString("Token")
    });
    if (response.statusCode == 200) {
      var jsonUtf8 = utf8.decode(response.bodyBytes);

      final jsonResponse = json.decode(jsonUtf8);

      return jsonResponse
          .map<Timesheet>((json) => Timesheet.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load Timesheet');
    }
  }

  Future<bool> postRemark({Remark remark}) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url =
        '${ApiService.apiUrl}/remark';
    var body = json.encode({'id': remark.id, 'remark': remark.remark});


    var response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'token': prefs.getString("Token"),
        },
        body: body);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return true;
    }

    return false;
  }
}
