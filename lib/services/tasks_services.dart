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

  List<Category> _categoryDetails = [];
  List<Category> get categoryDetails => _categoryDetails;

  Future fetchCategoryDetails(int? categoryId) async {
    print("fetching category $categoryId Details--------------");
    return await Api.getCategoryDetails(categoryId).then((response) async {
      if (response.statusCode == 200) {
        var payload = json.decode(response.body);
        // payload is not lst its map
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
}

TaskService taskService = TaskService();
