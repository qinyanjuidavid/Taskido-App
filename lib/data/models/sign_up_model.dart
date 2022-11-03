import 'dart:convert';

SignUp signUpFromJson(String str) => SignUp.fromJson(json.decode(str));

String signUpToJson(SignUp data) => json.encode(data.toJson());

class SignUp {
  SignUp({
    this.user,
    this.refresh,
    this.token,
  });

  User? user;
  String? refresh;
  String? token;

  factory SignUp.fromJson(Map<String, dynamic> json) => SignUp(
        user: User.fromJson(json["user"]),
        refresh: json["refresh"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
        "refresh": refresh,
        "token": token,
      };
}

class User {
  User({
    this.username,
    this.fullName,
    this.email,
    this.phone,
  });

  String? username;
  String? fullName;
  String? email;
  String? phone;

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        fullName: json["full_name"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "full_name": fullName,
        "email": email,
        "phone": phone,
      };
}
