import 'dart:convert';

import 'package:hive/hive.dart';

part '../adapters/login_models.g.dart';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

@HiveType(typeId: 0)
class Login {
  Login({
    this.refresh,
    this.access,
    this.user,
  });

  @HiveField(0)
  String? refresh;
  @HiveField(1)
  String? access;
  //Class  User what Hive does is it creates a new box for the class User
  @HiveField(2)
  User? user;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        refresh: json["refresh"],
        access: json["access"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
        "user": user!.toJson(),
      };
}

@HiveType(typeId: 1)
class User {
  User({
    this.id,
    this.phone,
    this.email,
    this.fullName,
    this.role,
    this.timestamp,
  });

  @HiveField(0)
  int? id;
  @HiveField(1)
  String? phone;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? fullName;
  @HiveField(4)
  String? role;
  @HiveField(5)
  String? timestamp;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        phone: json["phone"],
        email: json["email"],
        fullName: json["full_name"],
        role: json["role"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "email": email,
        "full_name": fullName,
        "role": role,
        "timestamp": timestamp,
      };
}
