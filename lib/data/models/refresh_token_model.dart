import 'dart:convert';

RefreshToken refreshTokenFromJson(String str) =>
    RefreshToken.fromJson(json.decode(str));

String refreshTokenToJson(RefreshToken data) => json.encode(data.toJson());

class RefreshToken {
  RefreshToken({
    this.access,
    this.refresh,
  });

  String? access;
  String? refresh;

  factory RefreshToken.fromJson(Map<String, dynamic> json) => RefreshToken(
        access: json["access"],
        refresh: json["refresh"],
      );

  Map<String, dynamic> toJson() => {
        "access": access,
        "refresh": refresh,
      };
}
