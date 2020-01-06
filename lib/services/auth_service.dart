import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/models/api_service.dart';
import 'package:starter/models/user.dart';

class AuthService {
  Future<bool> authencation({String user, String password}) async {
    var url = '${ApiService.apiUrl}/login';
    var body = json.encode({
      'username': user,
      'password': password,
    });
    var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var userData = User.fromJson(jsonResponse);
      await prefs.setString('Token', userData.data);
      await prefs.setString('LOGIN_EMAIL', user);
      await prefs.setBool('IS_LOGIN', true);
      print(userData.data);

      return true;
    }

    return false;
  }

  Future<bool> isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('IS_LOGIN') ?? false;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove('IS_LOGIN');

  }
}
