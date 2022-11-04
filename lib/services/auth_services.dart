import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:taskido/data/models/sign_up_model.dart';

import '../api/api.dart';
import '../data/models/login_models.dart';

class AuthService extends ChangeNotifier {
  Future login(String phone, String password) async {
    return Api.login(phone, password).then((response) async {
      if (response.statusCode == 200) {
        var payload = json.decode(response.body);
        Login loginDetails = Login.fromJson(payload);

        notifyListeners();
        return payload;
      } else {
        var payload = json.decode(response.body);
        print(payload);
      }
    }).catchError((error) {
      print("error occured during user login $error");
    });
  }

  Future signup(
    String phone,
    String email,
    String full_name,
    String password,
    String password_confirmation,
  ) async {
    return Api.register(
      phone,
      email,
      full_name,
      password,
      password_confirmation,
    ).then((response) {
      if (response.statusCode == 200) {
        var payload = json.decode(response.body);

        SignUp signupDetails = SignUp.fromJson(payload);

        notifyListeners();
        return payload;
      } else {
        var payload = json.decode(response.body);
        print(payload);
      }
    }).catchError((error) {
      print("error occured during user login $error");
    });
  }
}

AuthService authService = AuthService();
