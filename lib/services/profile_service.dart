import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/models/api_service.dart';
import 'package:starter/models/personal.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileService {
  Future<Personal> fetchProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var url =
        '${ApiService.apiUrl}/personal/null';
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'token': prefs.getString("Token")
    });
    if (response.statusCode == 200) {
      var jsonUtf8 = utf8.decode(response.bodyBytes);
      final jsonResponse = json.decode(jsonUtf8);
      Personal responses = Personal.fromJson(jsonResponse);

      return responses;
    } else {
      throw Exception('Failed to load Profile');
    }
  }

  Future<bool> updatePersonal(Personal personal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url =
       '${ApiService.apiUrl}/personal/null';
    var body = json.encode(personal);
    print(body);
    var response = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'token': prefs.getString("Token")
        },
        body: body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return true;
    }
    return false;
  }

}
