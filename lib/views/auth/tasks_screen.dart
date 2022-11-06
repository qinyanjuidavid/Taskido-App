import 'package:flutter/material.dart';
import 'package:taskido/data/models/category_models.dart';

class TasksScreen extends StatefulWidget {
  final int categoryId;
  TasksScreen({
    Key? key,
    required this.categoryId,
  }) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
