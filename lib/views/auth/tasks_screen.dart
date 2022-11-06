import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskido/data/models/category_models.dart';
import 'package:taskido/services/tasks_services.dart';

class TasksScreen extends StatefulWidget {
  final Category category;
  TasksScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    await Provider.of<TaskService>(context, listen: false)
        .fetchCategoryDetails(widget.category.id);
    // Future.delayed(Duration(milliseconds: 100),
    // () => bookService.loadCategoryBooks(widget.category.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.category.category}"),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [],
        ),
      ),
    );
  }
}
