import 'package:flutter/material.dart';
import 'package:taskido/views/home.dart';

import '../views/login.dart';

class RouteGenerator {
  static const String homePage = "/";
  static const String loginPage = "/login";

  RouteGenerator._() {}

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case loginPage:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
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
