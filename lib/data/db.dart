import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import 'models/login_models.dart';

class DataBase {
  Box<Login>? loginDetailsBox;

  _initBoxes() async {
    loginDetailsBox = await Hive.openBox('loginUserBox');
  }

  _loginAdapters() async {
    Hive.registerAdapter(LoginAdapter());
    Hive.registerAdapter(UserAdapter());
  }

  init() async {
    await Hive.initFlutter();
    await _loginAdapters();
    await _initBoxes(); //Set this at the bottom
  }
}

DataBase db = DataBase();

// flutter pub run build_runner build --delete-conflicting-outputs
