import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskido/data/models/sign_up_model.dart';

import '../api/api.dart';
import '../data/models/login_models.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService extends ChangeNotifier {
  bool _loadingLogin = false;
  bool get loadingLogin => _loadingLogin;

  set loadingLogin(bool val) {
    _loadingLogin = val;
    notifyListeners();
  }

  void loginToast() {
    Fluttertoast.showToast(
      msg: "Login Successful",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  void loginToastError() {
    Fluttertoast.showToast(
      msg: "Incorrect phone or password",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  Future login(String phone, String password) async {
    loadingLogin = true;

    return await Api.login(phone, password).then((response) async {
      if (response.statusCode == 200) {
        var payload = json.decode(response.body);
        Login loginDetails = Login.fromJson(payload);

        notifyListeners();
        loginToast();

        loadingLogin = false;
        return payload;
      } else {
        var payload = json.decode(response.body);
        loginToastError();
        loadingLogin = false;
        print(payload);
      }
    }).catchError((error) {
      loginToastError();
      loadingLogin = false;
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
    return await Api.register(
      phone,
      email,
      full_name,
      password,
      password_confirmation,
    ).then((response) async {
      if (response.statusCode == 201) {
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

  Future otp(String token) async {
    //622067
    String phone = "254720215645";
    return await Api.Otp(phone, token).then((response) {
      if (response.statusCode == 200) {
        var payload = json.decode(response.body);

        notifyListeners();
        return payload;
      } else {
        var payload = json.decode(response.body);
        print("exception $payload");
      }
    }).catchError((error) {
      print("error occured during user login $error");
    });
  }
}

AuthService authService = AuthService();
