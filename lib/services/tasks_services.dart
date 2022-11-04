import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:taskido/api/api.dart';

class TasksServices extends ChangeNotifier {
  Future category(int? categoryId) async {
    return await Api.category(categoryId).then((response) {
      if (response.statusCode == 200) {
        var payload = json.decode(response.body);
      } else {
        var payload = json.decode(response.body);
      }
    }).catchError((error) {
      print("error occured during user login $error");
    });
  }
}
