import 'dart:async';
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
import 'package:internet_connection_checker/internet_connection_checker.dart';

class AuthService extends ChangeNotifier {
  Login get loginDetails => db.loginAllDetailsBox!.getAt(0)!;
  TokenCheck get otpCheckDetails => db.otpDetailsBox!.getAt(0)!;

  bool _loadingLogin = false;
  bool get loadingLogin => _loadingLogin;

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

  void loginToastError(msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.redAccent,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  Future login(String phone, String password) async {
    _loadingLogin = true;

    return await Api.login(phone, password).then((response) async {
      if (response.statusCode == 200) {
        var payload = json.decode(response.body);
        Login loginDetails = Login.fromJson(payload);
        await db.loginAllDetailsBox!.clear();
        await db.loginAllDetailsBox!.add(loginDetails);
        print("Login Details++++++: ${loginDetails.access}");

        notifyListeners();
        loginToast();

        _loadingLogin = false;
        return payload;
      } else {
        var payload = json.decode(response.body);
        loginToastError(
          "Incorrect phone or password",
        );
        _loadingLogin = false;
        print(payload);
      }
    }).catchError((error) {
      loginToastError("Login Failed!");
      _loadingLogin = false;
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

  bool _loadingSignup = false;
  bool get loadingSignup => _loadingSignup;
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
    _loadingSignup = true;
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
        _loadingSignup = false;
        return payload;
      } else {
        var payload = json.decode(response.body);
        print(payload);
        signUpErrorToast(payload);
        _loadingSignup = false;
      }
    }).catchError((error) {
      signUpErrorToast("Account sign up failed!");
      print("error occured during user signup $error");
      _loadingSignup = false;
    });
  }

  void otpSuccessToast() {
    Fluttertoast.showToast(
      msg: "OTP verified",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  void otpErrorToast(msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  bool _isOtpLoading = false;
  bool get isOtpLoading => _isOtpLoading;

  Future otp(String? token) async {
    _isOtpLoading = true;
    print("OTP is---->$token");
    return await Api.Otp(token).then((response) {
      print("Response :::: ${response.body}");
      if (response.statusCode == 200) {
        var payload = json.decode(response.body);

        notifyListeners();
        otpSuccessToast();
        _isOtpLoading = false;
        return payload;
      } else {
        var payload = json.decode(response.body);
        otpErrorToast(payload);
        _isOtpLoading = false;
      }
    }).catchError((error) {
      print("error occured during user account verification $error");
      otpErrorToast("Account verification failed!");
      _isOtpLoading = false;
    });
  }

  void passwordResetRequestPhoneNumberSuccessToast() {
    Fluttertoast.showToast(
      msg: "",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  void passwordResetRequestPhoneNumberErrorToast(msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  bool _isSendOtpLoading = false;
  bool get isSendOtpLoading => _isSendOtpLoading;

  Future passwordResetPhoneNumber(String? phoneNumber) async {
    _isSendOtpLoading = true;
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
        _isSendOtpLoading = false;
        return payload;
      } else {
        var payload = json.decode(response.body);
        print("Password Reset Phone $payload");
        _isSendOtpLoading = false;
      }
    }).catchError((error) {
      print("error occured while requesting for an otp $error");
      _isSendOtpLoading = false;
    });
  }

  void passwordResetTokenCheckSuccessToast() {
    Fluttertoast.showToast(
      msg: "",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  void passwordResetTokenCheckErrorToast(msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  bool _isPasswordOTPLoading = false;
  bool get isPasswordOTPLoading => _isPasswordOTPLoading;

  Future passwordResetTokenCheck(String? token) async {
    _isPasswordOTPLoading = true;
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
        _passwordResetLoading = false;
        return payload;
      } else {
        var payload = json.decode(response.body);
        print(payload);
        _passwordResetLoading = false;
      }
    }).catchError((error) {
      print("error occurred during otp check $error");
      _passwordResetLoading = false;
    });
  }

  void passwordResetSuccessToast() {
    Fluttertoast.showToast(
      msg: "",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  void passwordResetErrorToast(msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 4,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  bool _passwordResetLoading = false;
  bool get passwordResetLoading => _passwordResetLoading;

  Future passwordReset(String? password, String? password_confirm) async {
    _passwordResetLoading = true;
    return await Api.passwordReset(password, password_confirm).then((response) {
      if (response.statusCode == 200) {
        var payload = json.decode(response.body);
        notifyListeners();
        _passwordResetLoading = false;
        return payload;
      } else {
        var payload = json.decode(response.body);
        _passwordResetLoading = false;
        print("Password Reset Payload");
      }
    }).catchError((error) {
      _passwordResetLoading = false;
      print("error occured during password reset $error");
    });
  }
}

AuthService authService = AuthService();
