import 'package:flutter/material.dart';
import 'package:taskido/services/tasks_services.dart';
import 'package:provider/provider.dart';

class CompletedTasksScreen extends StatefulWidget {
  CompletedTasksScreen({Key? key}) : super(key: key);

  @override
  State<CompletedTasksScreen> createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasksScreen> {
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
                  return Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 10,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        //badge for category at the topr
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
                                //badge for category at the top
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      top: 10,
                                      left: 10,
                                    ),
                                    padding: const EdgeInsets.only(
                                      left: 5,
                                      right: 5,
                                      top: 3,
                                      bottom: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 253, 211, 176),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      task.category.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // task title
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
                                  child: Text(
                                    task.note.toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // task date due
                                Container(
                                  margin: const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  //calendar icon and date
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
                                        //convert task time to datetime

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
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
