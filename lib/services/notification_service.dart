import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/models/api_service.dart';
import 'package:starter/models/notification.dart';
import 'package:starter/models/view.dart';

class NotificationService {
  Future<List<Notification>> getNotificationList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var url =
        '${ApiService.apiUrl}/notification';

    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'token': prefs.getString("Token")
    });
    if (response.statusCode == 200) {
      var jsonUtf8 = utf8.decode(response.bodyBytes);
      final jsonResponse = json.decode(jsonUtf8);

      return jsonResponse
          .map<Notification>((json) => Notification.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load Youtubes');
    }
  }

  Future<View> getView({requestId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var url =
        '${ApiService.apiUrl}/leave/$requestId';


    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'token': prefs.getString("Token")
    });
    if (response.statusCode == 200) {
      var jsonUtf8 = utf8.decode(response.bodyBytes);
      final jsonResponse = json.decode(jsonUtf8);
      View viewResponse = View.fromJson(jsonResponse);

      return viewResponse;
    } else {
      throw Exception('Failed to load Youtubes');
    }
  }

  Future<bool> dialogNotofication({requestId, status}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url =
    '${ApiService.apiUrl}/leave/status/$requestId';

    var body = json.encode({'statusconfirm': status});
    print(body);
    var response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'token': prefs.getString("Token")
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
