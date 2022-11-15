import 'package:flutter/material.dart';
import 'package:taskido/views/auth/forgot_password_otp.dart';
import 'package:taskido/views/auth/forgot_password_screen.dart';
import 'package:taskido/views/auth/otp_page.dart';
import 'package:taskido/views/auth/password_reset_screen.dart';
import 'package:taskido/views/home.dart';
import 'package:taskido/views/auth/signup.dart';
import 'package:taskido/views/welcome/splash_screen.dart';
import 'package:taskido/views/welcome/welcome_screen.dart';

import '../views/auth/login.dart';

class RouteGenerator {
  static const String splashScreen = "/";
  static const String welcomePage = "/welcome";
  static const String homePage = "/home";
  static const String loginPage = "/login";
  static const String signUpPage = "/signup";
  static const String otpPage = "/otp";
  static const String forgotPasswordPage = "/forgotPassword";
  static const String forgotPasswordOtpPage = "/forgotPasswordOtp";
  static const String passwordResetPage = "/passwordReset";

  RouteGenerator._() {}

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );
      case welcomePage:
        return MaterialPageRoute(
          builder: (_) => WelcomScreen(),
        );
      case homePage:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case loginPage:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case signUpPage:
        return MaterialPageRoute(
          builder: (_) => SignUpScreen(),
        );
      case otpPage:
        return MaterialPageRoute(
          builder: (_) => OtpScreen(),
        );
      case forgotPasswordPage:
        return MaterialPageRoute(
          builder: (_) => PasswordResetPhoneScreen(),
        );
      case forgotPasswordOtpPage:
        return MaterialPageRoute(
          builder: (_) => ForgotPasswordOtpScreen(),
        );
      case passwordResetPage:
        return MaterialPageRoute(
          builder: (_) => PasswordResetScreen(),
        );
      default:
        throw FormatException("Route not found");
    }
  }
}

class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}
