import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskido/configs/routes.dart';
import 'package:taskido/data/models/category_models.dart';
import 'package:taskido/services/tasks_services.dart';
import 'package:taskido/views/auth/tasks_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _refresh();
  }

// refresh
  Future<void> _refresh() async {
    await Provider.of<TaskService>(context, listen: false).fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Taskido"),
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: Consumer<TaskService>(
            builder: (BuildContext context, value, child) {
              return ListView.builder(
                itemCount: value.categories.length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return TasksScreen(category: value.categories[index]);
                      }));
                    },
                    child: Text(
                      "${value.categories[index].category}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ));
  }
}
