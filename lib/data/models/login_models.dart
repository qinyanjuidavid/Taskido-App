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
    this.phone,
    this.email,
    this.fullName,
    this.role,
    this.timestamp,
  });

  int? id;
  String? phone;
  String? email;
  String? fullName;
  String? role;
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
