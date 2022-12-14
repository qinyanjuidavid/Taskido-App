import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:taskido/configs/routes.dart';
import 'package:taskido/services/auth_services.dart';
import 'package:taskido/services/profile_service.dart';
import 'package:taskido/services/tasks_services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authService),
        // ChangeNotifierProvider(
        //   create: (context) => TaskService(),
        // ),
        ChangeNotifierProvider.value(value: taskService),
        ChangeNotifierProvider.value(value: profileService),
      ],
      child: MaterialApp(
        title: "Taskido",
        onGenerateTitle: (context) => "Taskido",
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          // fontFamily: "Roboto",
          brightness: Brightness.light,
          focusColor: Colors.black,
          primaryColor: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: "/",
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
