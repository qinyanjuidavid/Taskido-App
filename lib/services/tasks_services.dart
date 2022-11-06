import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:taskido/api/api.dart';
import 'package:taskido/data/models/category_models.dart';
import 'package:taskido/data/models/task_model.dart';

class TaskService extends ChangeNotifier {
  List<Category> _categories = [];
  List<Category> get categories => _categories;

  Future fetchCategories() async {
    print("fetching categories.....");
    _categories = [];
    return Api.getCategories().then((response) async {
      if (response.statusCode == 200) {
        var payload = json.decode(response.body);
        for (var category in payload) {
          _categories.add(Category.fromJson(category));
        }
        print("Categories++++++: $_categories");
        notifyListeners();
      } else {
        var payload = json.decode(response.body);
        print("Load.... $payload");
        notifyListeners();
      }
    }).catchError((error) {
      print("error occured while fetching categories $error");
    });
  }

  List<Category> _categoryDetails = [];
  List<Category> get categoryDetails => _categoryDetails;

  Future fetchCategoryDetails(int? categoryId) async {
    _categoryDetails = [];
    print("fetching category $categoryId Details--------------");
    return await Api.getCategoryDetails(categoryId).then((response) async {
      if (response.statusCode == 200) {
        var payload = json.decode(response.body);

        _categoryDetails.add(Category.fromJson(payload));
        print("Category Details++++++: ${_categoryDetails[0].category}");

        notifyListeners();
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
    print("fetching tasks for category $categoryId");
    return await Api.getTasks().then((response) {
      if (response.statusCode == 200) {
        var payload = json.decode(response.body);
        // filter the tasks using category ID
        for (var task in payload) {
          if (task['category'] == categoryId) {
            _tasks.add(Tasks.fromJson(task));
          }
        }
        print("Tasks++++++: $_tasks");
        notifyListeners();
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
    return await Api.addCategory(category).then((response) {
      if (response.statusCode == 201) {
        var payload = json.decode(response.body);
        Category categoryDetails = Category.fromJson(payload);

        print("Category Added############ $categoryDetails");
        notifyListeners();
        return categoryDetails;
      } else {
        var payload = json.decode(response.body);
        print("payload----> $payload");
      }
    }).catchError((error) {
      print("error occured while adding category $error");
    });
  }
}

TaskService taskService = TaskService();
