import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:taskido/data/models/sign_up_model.dart';

import 'models/login_models.dart';

class DataBase {
  Box<Login>? loginAllDetailsBox;
  // Box<User>? loginUserDetailsBox;
  Box<SignUp>? signUpDetailsBox;

  _initBoxes() async {
    loginAllDetailsBox = await Hive.openBox('loginUserBox');
    signUpDetailsBox = await Hive.openBox("signUpUserBox");
  }

  _loginAdapters() async {
    Hive.registerAdapter(LoginAdapter());
    // Hive.registerAdapter(UserAdapter());
  }

  _signupAdapters() async {}

  init() async {
    await Hive.initFlutter();
    await _loginAdapters();
    await _signupAdapters();
    await _initBoxes(); //Set this at the bottom
  }
}

DataBase db = DataBase();

// flutter pub run build_runner build --delete-conflicting-outputs
