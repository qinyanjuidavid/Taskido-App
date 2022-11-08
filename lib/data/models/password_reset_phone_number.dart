import 'dart:convert';

PasswordResetPhoneNumber passwordResetPhoneNumberFromJson(String str) =>
    PasswordResetPhoneNumber.fromJson(json.decode(str));

String passwordResetPhoneNumberToJson(PasswordResetPhoneNumber data) =>
    json.encode(data.toJson());

class PasswordResetPhoneNumber {
  PasswordResetPhoneNumber({
    this.data,
    this.message,
  });

  Data? data;
  String? message;

  factory PasswordResetPhoneNumber.fromJson(Map<String, dynamic> json) =>
      PasswordResetPhoneNumber(
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    this.phone,
  });

  String? phone;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
      };
}
