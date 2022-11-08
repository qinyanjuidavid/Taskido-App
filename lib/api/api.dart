import 'dart:convert';
import 'dart:io';

import 'package:http_interceptor/http/http.dart';
import 'package:taskido/api/interceptors/authorization_interceptor.dart';
import 'package:taskido/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:taskido/data/models/category_models.dart';
import 'package:taskido/services/auth_services.dart';
import 'package:taskido/services/tasks_services.dart';

class Api {
  static String baseUrl = baseUrl = 'http://127.0.0.1:8000/api/v1/';

  static var client = http.Client();
  //interceptor client
  static final client2 = InterceptedClient.build(
    interceptors: [
      AuthorizationInterceptor(),
    ],
    requestTimeout: Duration(seconds: 5),
  );

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

  static Future<http.Response> logout() async {
    String? token = authService.loginDetails.access;
    String? refresh = authService.loginDetails.refresh;
    var response = await client2.post(
      Uri.parse("${baseUrl}logout/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "refresh": refresh,
      }),
    );
    return response;
  }

  static Future<http.Response> refreshToken(String? refreshToken) async {
    var response = await client.post(
      Uri.parse('${baseUrl}auth/refresh/'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        "refresh": refreshToken,
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

  static Future<http.Response> Otp(String token) async {
    String? phone = authService.loginDetails.user!.phone;
    print("OTP phone.......... $phone");
    print("OTP Phone............$phone");
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
    // get token from db
    String? token = authService.loginDetails.access;
    return await client2.get(
      Uri.parse("${baseUrl}category/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
  }

  static Future<http.Response> getCategoryDetails(int? categoryId) async {
    String? token = authService.loginDetails.access;
    var response = await client2.get(
      Uri.parse("${baseUrl}category/$categoryId/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    return response;
  }

  static Future<http.Response> addCategory(String? category) async {
    String? token = authService.loginDetails.access;
    var response = await client2.post(
      Uri.parse("${baseUrl}category/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "category": category,
      }),
    );
    return response;
  }

  static Future<http.Response> updateCategory(
    int? categoryId,
    String? category,
  ) async {
    String? token = authService.loginDetails.access;
    var response = await client2.put(
      Uri.parse("${baseUrl}category/$categoryId/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "category": category,
      }),
    );
    return response;
  }

  static Future<http.Response> getTasks() async {
    String? token = authService.loginDetails.access;
    var response = await client2.get(
      Uri.parse("${baseUrl}tasks/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> getTaskDetails(int? taskId) async {
    String? token = authService.loginDetails.access;
    var response = await client2.get(
      Uri.parse("${baseUrl}tasks/$taskId/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "Authorization": "Bearer $token",
      },
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> addTask(
    String? task,
    int? category,
    String? note,
    String? dueDate,
    bool? important,
  ) async {
    String accessToken =
        "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjcwMjI0Njk5LCJpYXQiOjE2Njc2MzI2OTksImp0aSI6ImE1ZjM3MjE2ZjQ4OTQ3ZTY4MDU3MzM1ZWU2ZWIyZmU4IiwidXNlcl9pZCI6Mn0.i_A_mJ0BqrOC_LGRo0gkMEhBvmNoIa_gZl_jhqXC6Pk";
    var response = await client2.post(
      Uri.parse("${baseUrl}tasks/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "Authorization": "Bearer $accessToken",
      },
      body: jsonEncode({
        "task": task,
        "category": category,
        "note": note,
        "due_date": dueDate,
        "important": important,
      }),
    );
    print(response.body);
    return response;
  }
}
