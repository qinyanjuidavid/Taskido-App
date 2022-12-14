import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:taskido/data/models/otp_check_model.dart';
import 'package:taskido/data/models/profile_model.dart';

import 'models/login_models.dart';
import 'models/sign_up_model.dart';

class DataBase {
  Box<Login>? loginAllDetailsBox;
  Box<User>? loginUserDetailsBox;
  Box<SignUp>? signUpDetailsBox;
  Box<TokenCheck>? otpDetailsBox;
  Box<OtpData>? otpDataDetailsBox;
  //profile
  Box<Profile>? userProfileDetailsBox;

  _initBoxes() async {
    loginAllDetailsBox = await Hive.openBox('loginUserBox');
    loginUserDetailsBox = await Hive.openBox("userDetailsBox");
    signUpDetailsBox = await Hive.openBox("signUpDetailsBox");
    otpDetailsBox = await Hive.openBox("passwordTokenDetailsBox");
    otpDataDetailsBox = await Hive.openBox("otpDataDetailsBox");
    userProfileDetailsBox = await Hive.openBox("profileDetailsBox");
  }

  _loginAdapters() async {
    Hive.registerAdapter(LoginAdapter());
    Hive.registerAdapter(UserAdapter());
  }

  _userProfileAdapters() async {
    Hive.registerAdapter(ProfileAdapter());
    Hive.registerAdapter(UserProfileAdapter());
  }

  _signupAdapters() async {
    Hive.registerAdapter(SignUpAdapter());
  }

  _otpAdapters() async {
    Hive.registerAdapter(TokenCheckAdapter());
    Hive.registerAdapter(OtpDataAdapter());
  }

  init() async {
    await Hive.initFlutter();
    await _userProfileAdapters();
    await _otpAdapters();
    await _signupAdapters();
    await _loginAdapters();
    await _initBoxes(); //Set this at the bottom
  }
}

DataBase db = DataBase();

// flutter pub run build_runner build --delete-conflicting-outputs
