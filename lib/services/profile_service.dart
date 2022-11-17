import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:taskido/api/api.dart';
import 'package:taskido/data/db.dart';
import 'package:taskido/data/models/profile_model.dart';
import 'package:taskido/services/auth_services.dart';

class ProfileService extends ChangeNotifier {
  Box<Profile>? get userProfileDetails => db.userProfileDetailsBox;

  bool _profileLoading = false;
  bool get profileLoading => _profileLoading;

  Profile _profileDetails = Profile();
  Profile get profileDetails => _profileDetails;

  Future getProfile() async {
    _profileLoading = true;
    String? refreshToken = authService.loginDetails.refresh;

    return await Api.profile().then((response) async {
      if (response.statusCode == 200) {
        var payload = jsonDecode(response.body);

        Profile profile = Profile.fromJson(payload[0]);
        _profileDetails = profile;

        _profileLoading = false;
        notifyListeners();
        await db.userProfileDetailsBox!.clear();
        await db.userProfileDetailsBox!.add(profile);
      } else if (response.statusCode == 401) {
        await authService.refreshToken(refreshToken);
        getProfile();
      } else {
        print("Error");
        var payload = jsonDecode(response.body);
        _profileLoading = false;
      }
    }).catchError((erorr) {
      print("error occured while fetching user profile $erorr");
      _profileLoading = false;
    });
  }

  void _profileUpdateSuccessToast() {
    Fluttertoast.showToast(
      msg: "Profile Updated Successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  void _profileUpdateErrorToast(msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 18.0,
    );
  }

  bool _profileUpdateLoading = false;
  bool get profileUpdateLoading => _profileUpdateLoading;

  Profile _updatedProfileDetails = Profile();
  Profile get updatedProfileDetails => _updatedProfileDetails;

  set profileUpdateLoading(bool val) {
    _profileUpdateLoading = val;
    notifyListeners();
  }

  Future updateProfile({
    String? phone,
    String? email,
    String? fullName,
    String? bio,
    int? userID,
  }) async {
    String? refreshToken = authService.loginDetails.refresh;
    _profileUpdateLoading = true;

    return await Api.updateProfile(phone, email, fullName, bio, userID)
        .then((response) async {
      var payload = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _updatedProfileDetails = Profile.fromJson(payload);

        await db.userProfileDetailsBox!.clear();
        await db.userProfileDetailsBox!.add(_updatedProfileDetails);
        // await Future.delayed(
        //   const Duration(seconds: 20),
        // );
        _profileUpdateSuccessToast();

        _profileUpdateLoading = false;
        notifyListeners();

        return payload;
      } else if (response.statusCode == 401) {
        await authService.refreshToken(refreshToken);
        updateProfile(
          phone: phone,
          email: email,
          fullName: fullName,
          bio: bio,
          userID: userID,
        );
      } else {
        _profileUpdateErrorToast(payload);
        _profileUpdateLoading = false;
        notifyListeners();
      }
    }).catchError((error) {
      print("error occured while updating profile $error");
      _profileUpdateErrorToast("Profile Update Failed!");
      _profileLoading = false;
    });
  }
}

ProfileService profileService = ProfileService();
