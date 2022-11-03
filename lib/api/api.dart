import 'package:taskido/app_config.dart';
import 'package:http/http.dart' as http;

class Api {
  static String baseUrl = baseUrl = 'https://127.0.0.1:8000/api/v1/';

  static var client = http.Client();

  // login
  // static Future<http.Response> login(String email, String password) {
  //   var url = baseUrl + 'login/';
  //   return http.post(url, body: {'email': email, 'password': password});
  // }

  static Future login({required email, required password}) async {
    var url = baseUrl + 'login/';
    var response = await client.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: {
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.statusCode;
    }
  }
}
