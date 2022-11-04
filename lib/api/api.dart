import 'dart:convert';
import 'dart:io';

import 'package:taskido/app_config.dart';
import 'package:http/http.dart' as http;

class Api {
  static String baseUrl = baseUrl = 'http://127.0.0.1:8000/api/v1/';

  static var client = http.Client();

  static Future<http.Response> login(String phone, String password) async {
    var response = await client.post(
      Uri.parse('${baseUrl}login/'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        'phone': phone,
        'password': password,
      }),
    );
    return response;
  }

  static Future<http.Response> register(
    String username,
    String phone,
    String email,
    String full_name,
    String password,
    String password_confirmation,
  ) async {
    var response = await client.post(
      Uri.parse("${baseUrl}register/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        "username": username,
        "phone": phone,
        'email': email,
        "full_name": full_name,
        'password': password,
        "password_confirmation": password_confirmation
      }),
    );
    return response;
  }
}
