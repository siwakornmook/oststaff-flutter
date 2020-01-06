import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/models/api_service.dart';
import 'package:starter/models/leader.dart';
import 'package:starter/models/leavetype.dart';
import 'package:starter/models/view.dart';

class LeaveService {
  Future<List<Leavetype>> getLeaveType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var url =
        '${ApiService.apiUrl}/leavetype';

    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'token': prefs.getString("Token")
    });
    if (response.statusCode == 200) {
      var jsonUtf8 = utf8.decode(response.bodyBytes);
      final jsonResponse = json.decode(jsonUtf8);

      return jsonResponse
          .map<Leavetype>((json) => Leavetype.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load Youtubes');
    }
  }

  Future<Leader> getLeader() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var url =
        '${ApiService.apiUrl}/leader';
//    var url = 'http://172.16.4.54:8080/SVNAPINEW/rest/ostservice/leader';
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'token': prefs.getString("Token")
    });
    if (response.statusCode == 200) {
      var jsonUtf8 = utf8.decode(response.bodyBytes);
      final jsonResponse = json.decode(jsonUtf8);
      Leader leaderResponse = Leader.fromJson(jsonResponse);

      return leaderResponse;
    } else {
      throw Exception('Failed to load Youtubes');
    }
  }

  Future<bool> postCreate(View create) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = '${ApiService.apiUrl}/leave';

    var body = json.encode(create);
    print('POST$body');

    var response = await http.post(url,
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



  Future<bool> putCreate(View create) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = '${ApiService.apiUrl}/leave/${create.id}';
    print(url);



    var body = json.encode(create);
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

  Future<bool> deleteLeave(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url =
        '${ApiService.apiUrl}/leave/$id';

    var response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'token': prefs.getString("Token"),
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return true;
    }

    return false;
  }
}
