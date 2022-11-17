import 'dart:convert';

import 'package:hive/hive.dart';
part 'profile_model.g.dart';

List<Profile> profileFromJson(String str) =>
    List<Profile>.from(json.decode(str).map((x) => Profile.fromJson(x)));

String profileToJson(List<Profile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 6)
class Profile {
  Profile({
    this.id,
    this.user,
    this.bio,
    this.profilePicture,
  });

  @HiveField(0)
  int? id;
  @HiveField(1)
  UserProfile? user;
  @HiveField(2)
  String? bio;
  @HiveField(3)
  String? profilePicture;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json["id"],
        user: UserProfile.fromJson(json["user"]),
        bio: json["bio"],
        profilePicture: json["profile_picture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user!.toJson(),
        "bio": bio,
        "profile_picture": profilePicture,
      };
}

@HiveType(typeId: 7)
class UserProfile {
  UserProfile({
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

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
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
