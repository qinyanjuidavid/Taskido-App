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
        "phone": phone,
        'email': email,
        "full_name": full_name,
        'password': password,
        "password_confirmation": password_confirmation
      }),
    );
    return response;
  }

  static Future<http.Response> Otp(String phone, String token) async {
    var response = await client.post(
      Uri.parse("${baseUrl}activate/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        "phone": phone,
        "token": token,
      }),
    );
    return response;
  }

  static Future<http.Response> getCategories() async {
    String accessToken =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjcwMjI0Njk5LCJpYXQiOjE2Njc2MzI2OTksImp0aSI6ImE1ZjM3MjE2ZjQ4OTQ3ZTY4MDU3MzM1ZWU2ZWIyZmU4IiwidXNlcl9pZCI6Mn0.i_A_mJ0BqrOC_LGRo0gkMEhBvmNoIa_gZl_jhqXC6Pk";
    var response = await client.get(
      Uri.parse("${baseUrl}category/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "Authorization": "Bearer $accessToken",
      },
    );
    return response;
  }

  static Future<http.Response> getCategoryDetails(int? categoryId) async {
    String accessToken =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjcwMjI0Njk5LCJpYXQiOjE2Njc2MzI2OTksImp0aSI6ImE1ZjM3MjE2ZjQ4OTQ3ZTY4MDU3MzM1ZWU2ZWIyZmU4IiwidXNlcl9pZCI6Mn0.i_A_mJ0BqrOC_LGRo0gkMEhBvmNoIa_gZl_jhqXC6Pk";
    var response = await client.get(
      Uri.parse("${baseUrl}category/$categoryId/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "Authorization": "Bearer $accessToken",
      },
    );
    return response;
  }

  static Future<http.Response> addCategory(String? category) async {
    String accessToken =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjcwMjI0Njk5LCJpYXQiOjE2Njc2MzI2OTksImp0aSI6ImE1ZjM3MjE2ZjQ4OTQ3ZTY4MDU3MzM1ZWU2ZWIyZmU4IiwidXNlcl9pZCI6Mn0.i_A_mJ0BqrOC_LGRo0gkMEhBvmNoIa_gZl_jhqXC6Pk";
    var response = await client.post(
      Uri.parse("${baseUrl}category/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "Authorization": "Bearer $accessToken",
      },
      body: jsonEncode({
        "category": category,
      }),
    );
    return response;
  }

  static Future<http.Response> getTasks() async {
    String accessToken =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjcwMjI0Njk5LCJpYXQiOjE2Njc2MzI2OTksImp0aSI6ImE1ZjM3MjE2ZjQ4OTQ3ZTY4MDU3MzM1ZWU2ZWIyZmU4IiwidXNlcl9pZCI6Mn0.i_A_mJ0BqrOC_LGRo0gkMEhBvmNoIa_gZl_jhqXC6Pk";
    var response = await client.get(
      Uri.parse("${baseUrl}tasks/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "Authorization": "Bearer $accessToken",
      },
    );
    print(response.body);
    return response;
  }

  Future<http.Response> addTask(
    String? task,
    int? category,
    String? note,
    String? dueDate,
    bool? important,
  ) async {
    String accessToken =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjcwMjI0Njk5LCJpYXQiOjE2Njc2MzI2OTksImp0aSI6ImE1ZjM3MjE2ZjQ4OTQ3ZTY4MDU3MzM1ZWU2ZWIyZmU4IiwidXNlcl9pZCI6Mn0.i_A_mJ0BqrOC_LGRo0gkMEhBvmNoIa_gZl_jhqXC6Pk";
    var response = await client.post(
      Uri.parse("${baseUrl}tasks/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "Authorization": "Bearer $accessToken",
      },
      body: jsonEncode({
        "task": task,
        "category": category,
        "note": note,
        "dueDate": dueDate,
        "important": important,
      }),
    );
    print(response.body);
    return response;
  }
}
