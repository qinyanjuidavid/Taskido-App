import 'package:flutter/material.dart';

class UncompleteTasksScreen extends StatefulWidget {
  UncompleteTasksScreen({Key? key}) : super(key: key);

  @override
  State<UncompleteTasksScreen> createState() => _UncompleteTasksScreenState();
}

class _UncompleteTasksScreenState extends State<UncompleteTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("UnCompleted"),
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
