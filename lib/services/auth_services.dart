import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../api/api.dart';
import '../data/models/login_models.dart';

class AuthService extends ChangeNotifier {
  Future login(String email, String password) async {
    return Api.login(email, password).then((response) async {
      var payload = json.decode(response.body);
      Login loginDetails = Login.fromJson(payload);

      notifyListeners();
      return payload;
    }).catchError((error) {
      print("error occured during user login $error");
    });
  }
}

AuthService authService = AuthService();
