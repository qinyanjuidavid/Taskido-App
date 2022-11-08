import 'dart:convert';

import 'package:hive/hive.dart';
part 'sign_up_model.g.dart';

SignUp signUpFromJson(String str) => SignUp.fromJson(json.decode(str));

String signUpToJson(SignUp data) => json.encode(data.toJson());

@HiveType(typeId: 2)
class SignUp {
  SignUp({
    this.user,
    this.refresh,
    this.token,
  });

  @HiveField(0)
  UserDetails? user;
  @HiveField(1)
  String? refresh;
  @HiveField(2)
  String? token;

  factory SignUp.fromJson(Map<String, dynamic> json) => SignUp(
        user: UserDetails.fromJson(json["user"]),
        refresh: json["refresh"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
        "refresh": refresh,
        "token": token,
      };
}

@HiveType(typeId: 3)
class UserDetails {
  UserDetails({
    this.phone,
    this.email,
    this.fullName,
  });

  @HiveField(0)
  String? phone;
  @HiveField(1)
  String? email;
  @HiveField(2)
  String? fullName;

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        phone: json["phone"],
        email: json["email"],
        fullName: json["full_name"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "email": email,
        "full_name": fullName,
      };
}
