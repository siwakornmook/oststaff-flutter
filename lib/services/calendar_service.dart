import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/models/api_service.dart';
import 'package:starter/models/calendar.dart';

class CalendarService {
  Future<List<Calendar>> getCalendar({@required date,workday,leave,holiday}) async {

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var url =
          '${ApiService.apiUrl}/calendar?date=$date&workday=$workday&leave=$leave&holiday=$holiday';
      print(url);


      var response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'token': prefs.getString("Token")
      });

      if (response.statusCode == 200) {

        var jsonUtf8 = utf8.decode(response.bodyBytes);

        final jsonResponse = json.decode(jsonUtf8);
        return jsonResponse
            .map<Calendar>((json) => Calendar.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load Timesheet');
      }

  }

  Future<Null> setTypeCalendar({workday, leave, holiday}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('${workday} ${leave} ${holiday}');
    prefs.setBool("workDaySwitch", workday);
    prefs.setBool("leaveSwitch", leave);
    prefs.setBool("holidaySwitch", holiday);
  }
}
