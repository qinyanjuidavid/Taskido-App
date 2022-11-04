import 'dart:convert';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    this.id,
    this.category,
    this.owner,
    this.completed,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? category;
  Owner? owner;
  bool? completed;
  String? createdAt;
  String? updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        category: json["category"],
        owner: Owner.fromJson(json["owner"]),
        completed: json["completed"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "owner": owner!.toJson(),
        "completed": completed,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Owner {
  Owner({
    this.id,
    this.user,
    this.bio,
    this.profilePicture,
  });

  int? id;
  User? user;
  String? bio;
  String? profilePicture;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json["id"],
        user: User.fromJson(json["user"]),
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
