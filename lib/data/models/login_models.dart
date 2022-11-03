import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    this.refresh,
    this.access,
    this.user,
  });

  String? refresh;
  String? access;
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

class User {
  User({
    this.id,
    this.username,
    this.fullName,
    this.email,
    this.phone,
    this.timestamp,
  });

  int? id;
  String? username;
  String? fullName;
  String? email;
  String? phone;
  String? timestamp;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        fullName: json["full_name"],
        email: json["email"],
        phone: json["phone"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "full_name": fullName,
        "email": email,
        "phone": phone,
        "timestamp": timestamp,
      };
}
