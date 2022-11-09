import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:taskido/api/api.dart';
import 'package:taskido/data/models/category_models.dart';
import 'package:taskido/data/models/task_model.dart';
import 'package:taskido/services/auth_services.dart';

class TaskService extends ChangeNotifier {
  List<Category> _categories = [];
  List<Category> get categories => _categories;

  Future fetchCategories() async {
    print("fetching categories.....");
    _categories = [];
    String? refreshToken = authService.loginDetails.refresh;
    return Api.getCategories().then((response) async {
      print("RESPONSE:::::::::::::::::::: ${response.statusCode}");
      if (response.statusCode == 200) {
        var payload = json.decode(response.body);
        //payload in the format of
//         {
//   "count": 19,
//   "next": "http://127.0.0.1:8000/api/v1/category/?page=2",
//   "previous": null,
//   "results": [
//     {
//       "id": 1,
//       "category": "Tasks",
//       "CategoryOwner": {
//         "id": 1,
//         "CategoryUser": {
//           "id": 2,
//           "phone": "+254700215646",
//           "email": "gracy@gmail.com",
//           "full_name": "Grace Gaciuki",
//           "role": "Owner",
//           "timestamp": "2022-11-04T13:06:11.521147Z"
//         },
//         "bio": null,
//         "profile_picture": "http://127.0.0.1:8000/media/default.png"
//       },
//       "completed": false,
//       "created_at": "2022-11-04T13:06:11.552044Z",
//       "updated_at": "2022-11-04T13:06:11.552044Z"
//     }
//   ]
// }
        var results = payload["results"];
        for (var result in results) {
          Category category = Category.fromJson(result);
          _categories.add(category);
        }
        print(_categories);
        notifyListeners();
      } else if (response.statusCode == 401) {
        await authService.refreshToken(refreshToken);
        fetchCategories();
      } else {
        var payload = json.decode(response.body);

        print("Load.... $payload");
        notifyListeners();
      }
    }).catchError((error) {
      print("error occured while fetching categories $error");
    });
  }

  Category _categoryDetails = Category();
  Category get categoryDetails => _categoryDetails;

  Future fetchCategoryDetails(int? categoryId) async {
    _categoryDetails;
    String? refreshToken = authService.loginDetails.refresh;
    print("fetching category $categoryId Details--------------");

    return await Api.getCategoryDetails(categoryId).then((response) async {
      if (response.statusCode == 200) {
        var payload = json.decode(response.body);
        print("Category Details33333333----> $payload");
        _categoryDetails = Category.fromJson(payload);
        notifyListeners();
      } else if (response.statusCode == 401) {
        await authService.refreshToken(refreshToken);
        fetchCategoryDetails(categoryId);
      } else {
        var payload = json.decode(response.body);
        print("Failed to load Category $payload");

        notifyListeners();
      }
    }).catchError((error) {
      print("error occcured while fetching categories $error");
    });
  }

  List<Tasks> _tasks = [];
  List<Tasks> get tasks => _tasks;

  Future fetchTasks(int? categoryId) async {
    _tasks = [];
    String? refreshToken = authService.loginDetails.refresh;
    print("fetching tasks for category $categoryId");

    return await Api.getTasks().then((response) async {
      if (response.statusCode == 200) {
        var payload = json.decode(response.body);
        // filter the tasks using category ID
        for (var task in payload) {
          if (task['category'] == categoryId) {
            _tasks.add(Tasks.fromJson(task));
          }
        }
        notifyListeners();
      } else if (response.statusCode == 401) {
        await authService.refreshToken(refreshToken);
        fetchTasks(categoryId);
      } else {
        var payload = json.decode(response.body);
        print("Failed to load Tasks $payload");
        notifyListeners();
      }
    }).catchError((error) {
      print("error occured while fetching tasks $error");
    });
  }

  Future addCategory(String? category) async {
    String? refreshToken = authService.loginDetails.refresh;

    return await Api.addCategory(category).then((response) async {
      if (response.statusCode == 201) {
        var payload = json.decode(response.body);
        Category categoryDetails = Category.fromJson(payload);

        print("Category Added############ $categoryDetails");
        notifyListeners();
        return categoryDetails;
      } else if (response.statusCode == 401) {
        await authService.refreshToken(refreshToken);
        addCategory(category);
      } else {
        var payload = json.decode(response.body);
        print("payload----> $payload");
      }
    }).catchError((error) {
      print("error occured while adding category $error");
    });
  }

  Future updateCategory(int? categoryId, String? category) async {
    String? refreshToken = authService.loginDetails.refresh;

    return await Api.updateCategory(categoryId, category)
        .then((response) async {
      if (response.statusCode == 201) {
        var payload = json.decode(response.body);
        Category categoryDetails = Category.fromJson(payload);

        notifyListeners();
        return categoryDetails;
      } else if (response.statusCode == 401) {
        await authService.refreshToken(refreshToken);
        updateCategory(categoryId, category);
      } else {
        var payload = json.decode(response.body);
        print("payload----> $payload");
      }
    }).catchError((error) {
      print("error occured while updating category $error");
    });
  }

  Future addTask(
    String? task,
    int? category,
    String? note,
    String? dueDate,
    bool? important,
  ) async {
    String? refreshToken = authService.loginDetails.refresh;

    return await Api.addTask(task, category, note, dueDate, important)
        .then((response) async {
      if (response.statusCode == 201) {
        var payload = json.decode(response.body);
        Tasks taskDetails = Tasks.fromJson(payload);

        print("Task Added********** $taskDetails");
        notifyListeners();
        return taskDetails;
      } else if (response.statusCode == 401) {
        await authService.refreshToken(refreshToken);
        addTask(
          task,
          category,
          note,
          dueDate,
          important,
        );
      } else {
        var payload = json.decode(response.body);
        print("payload---> $payload");
      }
    }).catchError((error) {
      print("error occured while adding task $task");
    });
  }
}

TaskService taskService = TaskService();
