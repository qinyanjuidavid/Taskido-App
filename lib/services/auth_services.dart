import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskido/data/db.dart';
import 'package:taskido/data/models/category_models.dart';
import 'package:taskido/data/models/otp_check_model.dart';
import 'package:taskido/data/models/password_reset_phone_number.dart';
import 'package:taskido/data/models/refresh_token_model.dart';
import 'package:taskido/data/models/sign_up_model.dart';

import '../api/api.dart';
import '../data/models/login_models.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService extends ChangeNotifier {
  // db
  Login get loginDetails => db.loginAllDetailsBox!.getAt(0)!;
  TokenCheck get otpCheckDetails => db.otpDetailsBox!.getAt(0)!;

  bool _loadingLogin = false;
  bool get loadingLogin => _loadingLogin;

  set loadingLogin(bool val) {
    _loadingLogin = val;
    notifyListeners();
  }

  void loginToast() {
    Fluttertoast.showToast(
      msg: "Login Successly",
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
        await db.loginAllDetailsBox!.clear();
        await db.loginAllDetailsBox!.add(loginDetails);
        // print("Login Details++++++: ${loginDetails.access}");

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

  void logoutToastError() {
    Fluttertoast.showToast(
      msg: "Can't logout at the moment",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  void logoutToast() {
    Fluttertoast.showToast(
      msg: "Logout Successful",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  Future logout() async {
    return await Api.logout().then((response) async {
      await db.loginAllDetailsBox!.clear();
      logoutToast();
      print("************************Logged Out*******************");
    }).catchError((error) {
      logoutToastError();
      print("error occured during user logout ${error.toString()}");
    });
  }

  Future refreshToken(String? refreshToken) async {
    return await Api.refreshToken(refreshToken).then((response) {
      if (response.statusCode == 200) {
        var payload = json.decode(response.body);
        RefreshToken refreshTokenDetails = RefreshToken.fromJson(payload);

        // print old accessToken
        print("Old Access Token ${loginDetails.access}");
        print("Old refresh token ${loginDetails.refresh}");
        // update accessToken
        loginDetails.access = refreshTokenDetails.access;
        loginDetails.refresh = refreshTokenDetails.refresh;
        // save new accessToken
        db.loginAllDetailsBox!.putAt(0, loginDetails);
        print("New Access Token ${refreshTokenDetails.access}");
        print("New refresh token ${refreshTokenDetails.refresh}");
        // update the access token and refresh token

        notifyListeners();
      } else {
        var payload = json.decode(response.body);
        print(payload);
      }
    }).catchError((error) {
      print("error occured during token refresh auth $error");
    });
  }

  void signUpToast() {
    Fluttertoast.showToast(
      msg: "OTP sent to your phone",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  void signUpErrorToast(var msg) {
    Fluttertoast.showToast(
      msg: msg.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 18.0,
    );
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

        print("Register*******************$payload");
        SignUp signupDetails = SignUp.fromJson(payload);
        Login allDetails = Login(
          access: signupDetails.token,
          refresh: signupDetails.refresh,
          user: User(
            email: signupDetails.user!.email,
            phone: signupDetails.user!.phone,
            fullName: signupDetails.user!.fullName,
          ),
        );

        await db.loginAllDetailsBox!.clear();
        await db.loginAllDetailsBox!.add(allDetails);

        notifyListeners();
        signUpToast();
        return payload;
      } else {
        var payload = json.decode(response.body);
        print(payload);
        signUpErrorToast(payload);
      }
    }).catchError((error) {
      signUpErrorToast("Account sign up failed!");
      print("error occured during user signup $error");
    });
  }

  Future otp(String? token) async {
    return await Api.Otp(token).then((response) {
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

  Future passwordResetPhoneNumber(String? phoneNumber) async {
    return await Api.passwordResetPhoneNumber(phoneNumber)
        .then((response) async {
      if (response.statusCode == 200) {
        var payload = json.decode(response.body);
        PasswordResetPhoneNumber passwordResetDetails =
            PasswordResetPhoneNumber.fromJson(payload);
        Login passwordPhoneNumber = Login(
          user: User(phone: passwordResetDetails.data!.phone),
        );

        TokenCheck passwordOtpDetails = TokenCheck(
          otpData: OtpData(
            phone: passwordResetDetails.data!.phone,
          ),
        );

        await db.loginAllDetailsBox!.clear();
        await db.loginAllDetailsBox!.add(passwordPhoneNumber);
        await db.otpDetailsBox!.clear();
        await db.otpDetailsBox!.add(passwordOtpDetails);

        //print phone number from db
        print("Phone number from db ${loginDetails.user!.phone}");
        print("OTP 2 Phone number from db ${otpCheckDetails.otpData!.phone}");
        notifyListeners();
        return payload;
      } else {
        var payload = json.decode(response.body);
        print("Password Reset Phone $payload");
      }
    }).catchError((error) {
      print("error occured while requesting for an otp $error");
    });
  }

  Future passwordResetTokenCheck(String? token) async {
    return await Api.passwordResetTokenCheck(token).then((response) async {
      if (response.statusCode == 200) {
        var payload = json.decode(response.body);
        TokenCheck tokenDetails = TokenCheck.fromJson(payload);
        TokenCheck passwordOtpDetails = TokenCheck(
          otpData: OtpData(
            token: tokenDetails.otpData!.token,
            phone: tokenDetails.otpData!.phone,
          ),
        );

        // add token to the otp db
        await db.otpDetailsBox!.clear();
        await db.otpDetailsBox!.add(passwordOtpDetails);
        // print the token from db
        print("Token from db ${otpCheckDetails.otpData!.token}");
        // print phone number from db
        print(
          "OTP Check 2 Phone number from db ${otpCheckDetails.otpData!.phone}",
        );
        print("Password Check ##### Payload $payload");
        notifyListeners();
        return payload;
      } else {
        var payload = json.decode(response.body);
        print("Password Token Check $payload");
      }
    }).catchError((error) {
      print("error occurred during otp check $error");
    });
  }
}

AuthService authService = AuthService();
