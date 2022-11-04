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
    this.phone,
    this.email,
    this.fullName,
  });

  String? phone;
  String? email;
  String? fullName;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
