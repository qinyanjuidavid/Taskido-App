import 'dart:convert';

List<Tasks> tasksFromJson(String str) =>
    List<Tasks>.from(json.decode(str).map((x) => Tasks.fromJson(x)));

String tasksToJson(List<Tasks> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tasks {
  Tasks({
    this.id,
    this.task,
    this.owner,
    this.category,
    this.note,
    this.dueDate,
    this.important,
    this.completed,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? task;
  TaskOwner? owner;
  int? category;
  String? note;
  String? dueDate;
  bool? important;
  bool? completed;
  String? createdAt;
  String? updatedAt;

  factory Tasks.fromJson(Map<String, dynamic> json) => Tasks(
        id: json["id"],
        task: json["task"],
        owner: TaskOwner.fromJson(json["owner"]),
        category: json["category"],
        note: json["note"],
        dueDate: json["due_date"],
        important: json["important"],
        completed: json["completed"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "task": task,
        "owner": owner!.toJson(),
        "category": category,
        "note": note,
        "due_date": dueDate,
        "important": important,
        "completed": completed,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class TaskOwner {
  TaskOwner({
    this.id,
    this.user,
    this.bio,
    this.profilePicture,
  });

  int? id;
  TaskUser? user;
  String? bio;
  String? profilePicture;

  factory TaskOwner.fromJson(Map<String, dynamic> json) => TaskOwner(
        id: json["id"],
        user: TaskUser.fromJson(json["user"]),
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

class TaskUser {
  TaskUser({
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

  factory TaskUser.fromJson(Map<String, dynamic> json) => TaskUser(
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
