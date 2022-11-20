import 'package:flutter/material.dart';
import 'package:taskido/services/tasks_services.dart';
import 'package:provider/provider.dart';
import 'package:taskido/widgets/category/task_add_bottom_sheet.dart';
import 'package:taskido/widgets/inputs/text_field_with_label.dart';

class CompletedTasksScreen extends StatefulWidget {
  CompletedTasksScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
  GlobalKey<FormState> taskUpdateForm = GlobalKey<FormState>();
  TextEditingController taskUpdateTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    var taskService = Provider.of<TaskService>(context, listen: false);
    await taskService.fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          backgroundColor: const Color(0xFF1a2f45),
          elevation: 20,
          titleSpacing: 20,
          title: const Center(
            child: Text(
              "Completed Tasks",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: IconButton(
                onPressed: () {
                  // showSearch(context: context, delegate: DataSearch());
                },
                icon: const Icon(Icons.search),
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: Consumer<TaskService>(
            builder: (context, taskService, child) {
              var completedTasks = taskService.tasks
                  .where((element) => element.completed == true)
                  .toList();
              return ListView.builder(
                itemCount: completedTasks.length,
                itemBuilder: (context, index) {
                  var task = taskService.tasks[index];
                  return InkWell(
                    onTap: () {
                      _taskUpdateBottomSheet();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                        left: 10,
                        right: 10,
                      ),
                      padding: const EdgeInsets.only(
                        top: 20,
                        bottom: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: task.completed,
                                onChanged: (value) {
                                  // taskService.updateTask(task.copyWith(
                                  //   completed: value,
                                  // ));
                                },
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 10,
                                    ),
                                    child: Text(
                                      task.task.toString(),
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_today,
                                          color: Colors.black,
                                          size: 20,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          task.createdAt.toString(),
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _taskUpdateBottomSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return TaskBottomSheet(
          taskForm: Form(
            key: taskUpdateForm,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 0),
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                const Center(
                  child: Text(
                    "Update task",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextFieldWithLabel(
                  title: "Task",
                  controller: taskUpdateTextEditingController,
                  hintText: "Enter task",
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter task";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
