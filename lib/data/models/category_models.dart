import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  String? next;
  String? previous;
  List<Result>? results;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.id,
    this.category,
    this.owner,
    this.completed,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? category;
  CategoryOwner? owner;
  bool? completed;
  String? createdAt;
  String? updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        category: json["category"],
        owner: CategoryOwner.fromJson(json["owner"]),
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

class CategoryOwner {
  CategoryOwner({
    this.id,
    this.user,
    this.bio,
    this.profilePicture,
  });

  int? id;
  CategoryUser? user;
  String? bio;
  String? profilePicture;

  factory CategoryOwner.fromJson(Map<String, dynamic> json) => CategoryOwner(
        id: json["id"],
        user: CategoryUser.fromJson(json["user"]),
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

class CategoryUser {
  CategoryUser({
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

  factory CategoryUser.fromJson(Map<String, dynamic> json) => CategoryUser(
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
