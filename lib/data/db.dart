import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

import 'models/login_models.dart';

class DataBase {
  Box<Login>? loginDetailsBox;

  _initBoxes() async {
    loginDetailsBox = await Hive.openBox('loginUserBox');
  }

  init() async {
    await Hive.initFlutter();
    await _initBoxes();
  }
}

DataBase db = DataBase();

// flutter pub run build_runner build --delete-conflicting-outputs
