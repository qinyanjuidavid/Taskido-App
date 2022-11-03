import 'package:flutter/material.dart';
import 'package:taskido/configs/routes.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const Drawer(
          backgroundColor: Colors.orange,
        ),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 56, 1, 180),
          title: const Text(
            "Taskido",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        body: Center(
            child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(RouteGenerator.loginPage);
          },
          child: const Text(
            "login",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        )),
      ),
    );
  }
}
