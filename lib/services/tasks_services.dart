import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:taskido/api/api.dart';
import 'package:taskido/api/interceptors/authorization_interceptor.dart';
import 'package:taskido/data/models/category_models.dart';
import 'package:taskido/data/models/task_model.dart';
import 'package:taskido/services/auth_services.dart';
import 'package:http/http.dart' as http;

class TaskService extends ChangeNotifier {
  static var client = http.Client();
  //interceptor client
  static final client2 = InterceptedClient.build(
    interceptors: [
      AuthorizationInterceptor(),
    ],
    requestTimeout: Duration(seconds: 5),
  );

  int? _count;
  String? _next;
  String? _previous;
  bool? _categoryLoading = false;
  bool? _categoryOnError = false;
  bool? _moreDataLoading = false;
  bool? get moreDataLoading => _moreDataLoading;

  ScrollController? _scrollController;
  List<Result> _categories = [];

  int? get count => _count;
  String? get next => _next;
  String? get previous => _previous;
  bool? get categoryLoading => _categoryLoading;
  bool? get categoryOnError => _categoryOnError;
  ScrollController? get scrollController => _scrollController;

  List<Result> get categories => _categories;

  Future<void> setScrollController() async {
    _scrollController = ScrollController();
    print("Scroll Controller............");

    _scrollController!.addListener(() async {
      print("Try this......");
      String? token = authService.loginDetails.access;
      String? refreshToken = authService.loginDetails.refresh;
      if (_scrollController!.position.pixels ==
          _scrollController!.position.maxScrollExtent) {
        print("Next Page:: $_next");
        print("Categoris Lengt::${_categories.length}");
        if (_next != null && _count != _categories.length) {
          _moreDataLoading = true;
          return await client.get(
            Uri.parse("$_next"),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              HttpHeaders.authorizationHeader: 'Bearer $token',
            },
          ).then((response) async {
            if (response.statusCode == 200) {
              var payload = jsonDecode(response.body);
              Category category = Category.fromJson(payload);
              _categories.addAll(category.results!.toList());
              _next = category.next;
              _count = category.count;
              notifyListeners();
              _moreDataLoading = false;
            } else if (response.statusCode == 401) {
              await authService.refreshToken(refreshToken);
              fetchCategories();
            } else {
              var payload = jsonDecode(response.body);
              print(payload);
            }
          }).catchError((error) {
            print("Error occured while fetching data $error");
          });
        }
        _moreDataLoading = false;
      }
    });
    notifyListeners();
  }

  Future fetchCategories() async {
    _categoryLoading = true;
    String? refreshToken = authService.loginDetails.refresh;
    var response = await Api.getCategories().then((response) async {
      if (response.statusCode == 200) {
        var payload = jsonDecode(response.body);
        Category category = Category.fromJson(payload);
        _count = category.count;
        _next = category.next;
        _previous = category.previous;
        _categories = category.results!;
        notifyListeners();
        _categoryLoading = false;
      } else if (response.statusCode == 401) {
        await authService.refreshToken(refreshToken);
        fetchCategories();
      } else {
        _categoryLoading = false;
        var payload = jsonDecode(response.body);
        print(payload);
      }
    }).catchError((error) {
      _categoryLoading = false;
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

  void addCategorySuccessToast() {
    Fluttertoast.showToast(
        msg: "Category Added Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void addCategoryErrorToast(msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  bool _addCategoryLoading = false;
  bool get addCategoryLoading => _addCategoryLoading;

  Future addCategory(String? category, String? color) async {
    String? refreshToken = authService.loginDetails.refresh;

    _addCategoryLoading = true;
    return await Api.addCategory(category, color).then((response) async {
      if (response.statusCode == 201) {
        var payload = json.decode(response.body);
        notifyListeners();
        addCategorySuccessToast();
        _addCategoryLoading = false;
        return payload;
      } else if (response.statusCode == 401) {
        await authService.refreshToken(refreshToken);
        addCategory(category, color);
        //navigate to login page

      } else {
        var payload = json.decode(response.body);
        addCategoryErrorToast(payload);
        _addCategoryLoading = false;
      }
    }).catchError((error) {
      print("error occured while adding category $error");
      addCategoryErrorToast("Category not added");
      _addCategoryLoading = false;
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

  List<Results> _tasks = [];
  List<Tasks> get tasks => _tasks;

  bool _taskLoading = false;
  bool get taskLoading => _taskLoading;

  Future fetchTasks({int? categoryId}) async {
    _tasks = [];
    _taskLoading = true;
    String? refreshToken = authService.loginDetails.refresh;

    return await Api.getTasks().then((response) async {
      if (response.statusCode == 200) {
        var payload = json.decode(response.body);

        if (categoryId != null) {
          for (var task in payload) {
            if (task['category'] == categoryId) {
              _tasks.add(Tasks.fromJson(task));
            }
          }
        } else {
          // for (var task in payload) {
          _tasks = Tasks.fromJson(payload);
          // }
        }

        notifyListeners();
        _taskLoading = false;
      } else if (response.statusCode == 401) {
        await authService.refreshToken(refreshToken);
        if (categoryId != null) {
          fetchTasks(categoryId: categoryId);
        } else {
          fetchTasks();
        }
      } else {
        var payload = json.decode(response.body);
        print("Failed to load Tasks $payload");
        notifyListeners();
        _taskLoading = false;
      }
    }).catchError((error) {
      _taskLoading = false;
      print("error occured while fetching tasks $error");
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
      print("Response ${response.body}");
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
      print("error occured while adding task $error");
    });
  }

  Tasks _taskDetails = Tasks();
  Tasks get taskDetails => _taskDetails;

  Future fetchTaskDetails(int? taskID) async {
    String? refreshToken = authService.loginDetails.refresh;

    return await Api.getTaskDetails(taskID).then((response) async {
      var payload = json.decode(response.body);
      if (response.statusCode == 200) {
        _taskDetails = Tasks.fromJson(payload);
        notifyListeners();
        return payload;
      } else if (response.statusCode == 401) {
        await authService.refreshToken(refreshToken);
        fetchTaskDetails(taskID);
      } else {
        print("Payload---> $payload");
      }
    }).catchError((error) {
      print("error occured while fetching task $error");
    });
  }

  Future updateTask({
    String? task,
    int? category,
    String? note,
    String? dueDate,
    bool? important,
    bool? completed,
    int? taskID,
  }) async {
    String? refreshToken = authService.loginDetails.refresh;
    return await Api.updateTask(
      category: category,
      completed: completed,
      dueDate: dueDate,
      important: important,
      note: note,
      task: task,
      taskID: taskID,
    ).then((response) async {
      var payload = json.decode(response.body);
      if (response.statusCode == 200) {
        return payload;
      } else if (response.statusCode == 401) {
        await authService.refreshToken(refreshToken);
        // updateTask(task, category, note, dueDate, important, completed, taskID);
      } else {
        print("payload----> $payload");
      }
    }).catchError((error) {
      print("error occured while updating task $error");
    });
  }
}

TaskService taskService = TaskService();
