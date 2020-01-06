import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/models/api_service.dart';
import 'package:starter/models/dashboard.dart';
import 'package:starter/models/scantime.dart';

class DashboardService {
  Future<Dashboard> fetchDashboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url =
        '${ApiService.apiUrl}/timestamp';
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'token': prefs.getString("Token")
    });

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      Dashboard dashboardResponse = Dashboard.fromJson(jsonResponse);
print(dashboardResponse.dateStart);
      return dashboardResponse;
    } else {
      throw Exception('Failed to load Dashboard');
    }
  }

  Future<List<Scan>> getScan() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var url =
        '${ApiService.apiUrl}/scantime';
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'token': prefs.getString("Token")
    });
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      return jsonResponse.map<Scan>((json) => Scan.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Youtubes');
    }
  }
}
