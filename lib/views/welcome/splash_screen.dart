import 'dart:async';

import "package:flutter/material.dart";
import 'package:taskido/configs/routes.dart';
import 'package:taskido/data/db.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initDatabase() async {
    await db.init();
  }

  @override
  void initState() {
    goNext();
    super.initState();
    print("Initialize DB......");
    initDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
      body: Center(
        child: Text(
          "Splash Screen",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
      ),
    ));
  }

  void goNext() {
    Timer(Duration(seconds: 3), () async {
      Navigator.of(context).pushNamed(RouteGenerator.welcomePage);
    });
  }
}
