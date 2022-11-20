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
  // static String baseUrl = baseUrl = 'http://127.0.0.1:8000/api/v1/';
  static String baseUrl = baseUrl = 'http://10.0.2.2:8000/api/v1/';
  static var client = http.Client();
  //interceptor client
  static final client2 = InterceptedClient.build(
    interceptors: [
      AuthorizationInterceptor(),
    ],
    requestTimeout: Duration(seconds: 5),
  );

  static Future<http.Response> login(String phone, String password) async {
    print("Phone:: $phone Password:: $password ");
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
    print("Response.... $response");
    return response;
  }

  static Future<http.Response> profile() async {
    String? token = authService.loginDetails.access;

    var response = await client2.get(
      Uri.parse("${baseUrl}owner/profile/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

    return response;
  }

  static Future<http.Response> updateProfile(
    String? phone,
    String? email,
    String? fullName,
    String? bio,
    int? userID,
  ) async {
    String? token = authService.loginDetails.access;

    var response = await client2.put(
      Uri.parse("${baseUrl}owner/profile/$userID/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: jsonEncode({
        // "user": {"email": email, "phone": phone, "full_name": fullName},
        "phone": phone,
        "email": email,
        "full_name": fullName,
        "bio": bio,
      }),
    );

    return response;
  }

  static Future updateProfilePicture(
    String? imagePath,
    File? profileImage,
    int? userID,
  ) async {
    String? token = authService.loginDetails.access;
    print("Api Path ${imagePath} --->Type ${imagePath.runtimeType}");
    print("Api Image ${profileImage} --->Type ${profileImage.runtimeType}");
    final file = File(imagePath!);
    final _url = Uri.parse("http://10.0.2.2:8000/media/profile_pictures/");
    //upload profile picture to django rest framework api
    var request = http.MultipartRequest(
      'PUT',
      // _url,
      Uri.parse("${baseUrl}owner/profile/$userID/"),
    );
    request.headers.addAll({
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token",
    });
    request.files.add(
      http.MultipartFile.fromBytes(
        "profile_picture",
        file.readAsBytesSync(),
        filename: imagePath.split('/').last,
      ),
    );
    var response = await request.send();
    print("Data ${response.stream.toBytes()}");
    print("Response ${response.statusCode}");
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

  static Future<http.Response> Otp(String? token) async {
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

  static Future<http.Response> passwordResetPhoneNumber(
      String? phoneNumber) async {
    print("Password Rest Phone #### $phoneNumber");
    var response = await client.post(
      Uri.parse("${baseUrl}password-reset/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        "phone": phoneNumber,
      }),
    );
    return response;
  }

  static Future<http.Response> passwordResetTokenCheck(String? token) async {
    // String? phone = authService.loginDetails.user!.phone;
    String? phone = authService.otpCheckDetails.otpData!.phone;

    var response = await client.post(
      Uri.parse("${baseUrl}password-reset-token-check/"),
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

  static Future<http.Response> passwordReset(
      String? password, String? password_confirm) async {
    String? phone = authService.otpCheckDetails.otpData!.phone;
    String? token = authService.otpCheckDetails.otpData!.token;

    var response = await client.post(
      Uri.parse("${baseUrl}password-reset-complete/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        "password": password,
        "password_confirm": password_confirm,
        "phone": phone,
        "token": token,
      }),
    );
    return response;
  }

  static Future<http.Response> getCategories() async {
    // get token from db
    String? token = authService.loginDetails.access;

    var response = await client2.get(
      Uri.parse("${baseUrl}category/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    return response;
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

  static Future<http.Response> addCategory(
      String? category, String? color) async {
    String? token = authService.loginDetails.access;
    var response = await client2.post(
      Uri.parse("${baseUrl}category/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "category": category,
        "color": color,
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
    String? token = authService.loginDetails.access;
    var response = await client2.post(
      Uri.parse("${baseUrl}tasks/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "Authorization": "Bearer $token",
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

  static Future<http.Response> updateTask(
      {String? task,
      int? category,
      String? note,
      String? dueDate,
      bool? important,
      bool? completed,
      int? taskID}) async {
    String? token = authService.loginDetails.access;
    var response = await client2.post(
      Uri.parse("${baseUrl}tasks/$taskID/"),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "task": task,
        "category": category,
        "note": note,
        "due_date": dueDate,
        "important": important,
        "completed": completed,
      }),
    );
    return response;
  }
}
