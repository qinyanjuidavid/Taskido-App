import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taskido/services/tasks_services.dart';
import 'package:taskido/widgets/buttons/auth_button.dart';
import 'package:taskido/widgets/category/task_add_bottom_sheet.dart';
import 'package:taskido/widgets/inputs/text_field_with_label.dart';
import 'package:taskido/widgets/tasks/tasks_container.dart';

class UncompleteTasksScreen extends StatefulWidget {
  UncompleteTasksScreen({Key? key}) : super(key: key);

  @override
  State<UncompleteTasksScreen> createState() => _UncompleteTasksScreenState();
}

class _UncompleteTasksScreenState extends State<UncompleteTasksScreen> {
  GlobalKey<FormState> taskUpdateKey = GlobalKey<FormState>();
  TextEditingController taskUpdateTextEditingController =
      TextEditingController();
  TextEditingController noteUpdateTextEditingController =
      TextEditingController();
  TextEditingController dueDateTextEditingController = TextEditingController();
  TextEditingController categoryTextEditingController = TextEditingController();
  TextEditingController importantTextEditingController =
      TextEditingController();
  TextEditingController dueTimeTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    var taskService = Provider.of<TaskService>(context, listen: false);
    await taskService.fetchTasks();
    await taskService.taskSetScrollController();
  }

  void _taskUpdateFnc(int? taskID) async {
    if (taskUpdateKey.currentState!.validate()) {
      DateTime dueDate = DateFormat("dd/MM/yyyy")
          .parse(dueDateTextEditingController.text.toString().split(" ")[0]);
      TimeOfDay dueTime = TimeOfDay(
          hour: int.parse(
              dueTimeTextEditingController.text.toString().split(":")[0]),
          minute: int.parse(
              dueTimeTextEditingController.text.toString().split(":")[1]));

      var dueDateAndTime = DateTime(
        dueDate.year,
        dueDate.month,
        dueDate.day,
        dueTime.hour,
        dueTime.minute,
      ).toString();
      await taskService
          .updateTask(
        taskID: taskID,
        task: taskUpdateTextEditingController.text,
        note: noteUpdateTextEditingController.text,
        dueDate: dueDateAndTime,
        important: false,
        completed: true,
        category: int.tryParse(
          categoryTextEditingController.text,
        ),
      )
          .then((value) {
        if (value != null) {
          _refresh();
        }
      });
    }
  }

  _selectTime(BuildContext context, String? dueDate) async {
    TimeOfDay initTime;
    if (dueDate != null) {
      DateTime dueDay = DateTime.parse(dueDate);
      initTime = TimeOfDay(
        hour: dueDay.hour,
        minute: dueDay.minute,
      );
    } else {
      initTime = TimeOfDay.now();
    }

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        dueTimeTextEditingController.text =
            picked.format(context).split(" ")[0];
      });
    }
  }

  _selectDate(BuildContext context, String? dueDate) async {
    DateTime initDate;
    if (dueDate != null) {
      initDate = DateTime.parse(dueDate);
    } else {
      initDate = DateTime.now();
    }
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        dueDateTextEditingController.text =
            DateFormat('dd/MM/yyyy').format(picked);
      });
    }
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
              "Uncompleted Tasks",
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
              var unCompletedTasks = taskService.tasks
                  .where((element) => element.completed == false)
                  .toList();
              if (taskService.taskLoading == true ||
                  taskService.taskUpdateLoading == true) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: unCompletedTasks.length,
                itemBuilder: (context, index) {
                  var task = unCompletedTasks[index];
                  var dueDateFormatted;
                  var dueTime;
                  if (task.dueDate != null) {
                    var dueDate = DateTime.parse(task.dueDate!);
                    dueDateFormatted =
                        "${dueDate.day}/${dueDate.month}/${dueDate.year}";
                    dueTime = "${dueDate.hour}:${dueDate.minute}";
                  }
                  return TaskContainer(
                    onTap: () async {
                      await taskService.fetchTaskDetails(task.id);
                      if (task.dueDate != null) {
                        dueDateTextEditingController.text = dueDateFormatted;
                        dueTimeTextEditingController.text = dueTime;
                      } else {
                        dueDateTextEditingController.text = "";
                        dueTimeTextEditingController.text = "";
                      }

                      taskUpdateTextEditingController.text =
                          task.task.toString();
                      noteUpdateTextEditingController.text =
                          task.note.toString();
                      categoryTextEditingController.text =
                          task.category.toString();
                      _taskUpdateBottomSheet(task.id, task.dueDate);
                    },
                    value: task.completed!,
                    onChanged: (value) async {
                      taskService.fetchTaskDetails(task.id);
                      await taskService.updateTask(
                        completed: value,
                        taskID: task.id,
                        task: task.task,
                        note: task.note,
                        dueDate: task.dueDate,
                        important: task.important,
                        category: task.category,
                      );
                      await taskService.fetchTasks();
                    },
                    task: task.task.toString(),
                    dueDate: task.dueDate.toString(),
                    dueDateFormatted: dueDateFormatted,
                    dueTime: dueTime,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _taskUpdateBottomSheet(int? taskID, String? dueDate) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return TaskBottomSheet(
          taskForm: Form(
            key: taskUpdateKey,
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
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Note",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 106, 106, 106),
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  autofocus: false,
                  controller: noteUpdateTextEditingController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    fillColor: const Color.fromARGB(255, 245, 170, 51),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 20, 106, 218), width: 2.0),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    hintText: "Enter description",
                  ),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 106, 106, 106),
                  ),
                  maxLines: 5,
                  minLines: 5,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Due date",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 106, 106, 106),
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  autofocus: false,
                  textInputAction: TextInputAction.next,
                  controller: dueDateTextEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    fillColor: const Color.fromARGB(255, 245, 170, 51),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 20, 106, 218), width: 2.0),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    prefixIcon: const Icon(Icons.calendar_today),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return "Please enter due date";
                    }
                    return null;
                  },
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 106, 106, 106),
                  ),
                  readOnly: true,
                  onTap: () async {
                    _selectDate(context, dueDate);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Due time",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 106, 106, 106),
                      fontSize: 15,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  autofocus: false,
                  textInputAction: TextInputAction.next,
                  controller: dueTimeTextEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    fillColor: const Color.fromARGB(255, 245, 170, 51),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 20, 106, 218), width: 2.0),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    prefixIcon: const Icon(Icons.access_time),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter due time";
                    }
                    return null;
                  },
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 106, 106, 106),
                  ),
                  readOnly: true,
                  onTap: () async {
                    _selectTime(context, dueDate);
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                AuthButton(
                  onPressed: () {
                    _taskUpdateFnc(taskID);
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Update",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
