import 'dart:convert';

TokenCheck tokenCheckFromJson(String str) =>
    TokenCheck.fromJson(json.decode(str));

String tokenCheckToJson(TokenCheck data) => json.encode(data.toJson());

class TokenCheck {
  TokenCheck({
    this.otpData,
    this.message,
  });

  OtpData? otpData;
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

class OtpData {
  OtpData({
    this.token,
    this.phone,
  });

  String? token;
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
