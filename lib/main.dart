import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskido/configs/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return
        // MultiProvider(
        // providers: [],
        // child:
        MaterialApp(
      title: "Taskido",
      onGenerateTitle: (context) => "Taskido",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        // fontFamily: "Roboto",
        brightness: Brightness.light,
        focusColor: Colors.black,
        primaryColor: Colors.amber,
      ),
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
    );
    // );
  }
}
