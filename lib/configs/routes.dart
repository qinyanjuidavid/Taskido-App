import 'package:flutter/material.dart';
import 'package:taskido/views/home.dart';
import 'package:taskido/views/signup.dart';
import 'package:taskido/views/welcome_screen.dart';

import '../views/login.dart';

class RouteGenerator {
  static const String welcomePage = "/";
  static const String homePage = "/home";
  static const String loginPage = "/login";
  static const String signUpPage = "/signup";

  RouteGenerator._() {}

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
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
      default:
        throw FormatException("Route not found");
    }
  }
}

class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}
