import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/models/api_service.dart';
import 'package:starter/models/graph.dart';
import 'package:starter/models/history_summary.dart';
import 'package:starter/models/summary.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ReportService {
  Future<List<GraphList>> getGraphList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url =
        '${ApiService.apiUrl}/leave/graph';

    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'token': prefs.getString("Token")
    });
    if (response.statusCode == 200) {
      var jsonUtf8 = utf8.decode(response.bodyBytes);

      final jsonResponse = json.decode(jsonUtf8);

      return jsonResponse
          .map<GraphList>((json) => GraphList.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load Timesheet');
    }
  }

  Future<List<SummaryList>> getSummaryList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url =
        '${ApiService.apiUrl}/leave/summary';

    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'token': prefs.getString("Token")
    });
    if (response.statusCode == 200) {
      var jsonUtf8 = utf8.decode(response.bodyBytes);

      final jsonResponse = json.decode(jsonUtf8);

      return jsonResponse
          .map<SummaryList>((json) => SummaryList.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load Timesheet');
    }
  }

  Future<List<HistorySummary>> getHistorySummary({start, end}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(start);
    print(end);
    var url =
        '${ApiService.apiUrl}/leave/history?dateStart=$start&dateEnd=$end';

    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'token': prefs.getString("Token")
    });
    if (response.statusCode == 200) {
      var jsonUtf8 = utf8.decode(response.bodyBytes);

      final jsonResponse = json.decode(jsonUtf8);

      return jsonResponse
          .map<HistorySummary>((json) => HistorySummary.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load Timesheet');
    }
  }
}
