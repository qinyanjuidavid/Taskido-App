import 'dart:convert';

import 'package:hive/hive.dart';
part 'otp_check_model.g.dart';

TokenCheck tokenCheckFromJson(String str) =>
    TokenCheck.fromJson(json.decode(str));

String tokenCheckToJson(TokenCheck data) => json.encode(data.toJson());

@HiveType(typeId: 4)
class TokenCheck {
  TokenCheck({
    this.otpData,
    this.message,
  });

  @HiveField(0)
  OtpData? otpData;
  @HiveField(1)
  String? message;

  factory TokenCheck.fromJson(Map<String, dynamic> json) => TokenCheck(
        otpData: OtpData.fromJson(json["otpData"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "otpData": otpData!.toJson(),
        "message": message,
      };
}

@HiveType(typeId: 5)
class OtpData {
  OtpData({
    this.token,
    this.phone,
  });

  @HiveField(0)
  String? token;
  @HiveField(1)
  String? phone;

  factory OtpData.fromJson(Map<String, dynamic> json) => OtpData(
        token: json["token"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "phone": phone,
      };
}
