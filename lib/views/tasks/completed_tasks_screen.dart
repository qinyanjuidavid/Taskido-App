import 'package:flutter/material.dart';

class CompletedTasks extends StatefulWidget {
  CompletedTasks({Key? key}) : super(key: key);

  @override
  State<CompletedTasks> createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Completed"),
        ),
        body: ListView.builder(
          itemCount: 0,
          itemBuilder: (context, index) {
            return const ListTile(
              title: Text(""),
            );
          },
        ),
      ),
    );
  }
}
