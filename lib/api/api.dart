import 'dart:io';

import 'package:taskido/app_config.dart';
import 'package:http/http.dart' as http;

class Api {
  static String baseUrl = baseUrl = 'http://127.0.0.1:8000/api/v1/';

  static var client = http.Client();

  static Future<http.Response> login(String email, String password) async {
    print("API Email $email");
    var response = await client.post(
      Uri.parse('${baseUrl}login/'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: {
        'email': email,
        'password': password,
      },
    );
    print(response);
    return response;
  }

  static Future<http.Response> register(
    String phone,
    String email,
    String full_name,
    String password,
    String password_confirmation,
  ) async {
    var response = await client.post(
      Uri.parse("${baseUrl}register/"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: {
        "phone": phone,
        'email': email,
        "full_name": full_name,
        'password': password,
        "password_confirmation": password_confirmation
      },
    );
    return response;
  }
}
