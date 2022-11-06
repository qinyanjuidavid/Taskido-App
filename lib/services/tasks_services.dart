import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:taskido/api/api.dart';
import 'package:taskido/data/models/category_models.dart';

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
}

TaskService taskService = TaskService();
