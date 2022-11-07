import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  final GlobalKey<FormState> taskAddFormKey = GlobalKey<FormState>();
  TextEditingController taskTaskEditingController = TextEditingController();
  TextEditingController noteTextEditingController = TextEditingController();
  TextEditingController dueDateTextEditingController = TextEditingController();
  TextEditingController dueTimeTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2027),
    );
    if (picked != null) {
      dueDateTextEditingController.text = picked.toString();
    }
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      print("picked ${pickedTime.format(context)}");
      final now = DateTime.now();
      DateTime convertedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      print("Converted $convertedDateTime");
      String formatedTime = DateFormat("HH:mm:ss").format(convertedDateTime);
      print("FormatedTime $formatedTime");
      dueTimeTextEditingController.text = formatedTime.toString();
    }
  }

  Future<void> _refresh() async {
    await Provider.of<TaskService>(context, listen: false)
        .fetchCategoryDetails(widget.category.id);

    Future.delayed(
      Duration(milliseconds: 0),
      (() => taskService.fetchTasks(widget.category.id)),
    );
  }

  void taskSubmit() async {
    if (taskAddFormKey.currentState!.validate()) {
      // Due date is dueDateTextEditingController.text + dueTimeTextEditingController.text in format of "2022-11-06T16:40:42Z",
      // but we need to convert it to "2022-11-06 16:40:42"
      // 2022-11-10 00:00:00.000
      // TimeOfDay(10:00)
      print(dueDateTextEditingController.text);
      print(dueTimeTextEditingController.text);
      // var dueDate = dueDateTextEditingController.text +
      //     " " +
      //     dueTimeTextEditingController.text;
      await taskService
          .addTask(
              taskTaskEditingController.text,
              widget.category.id,
              noteTextEditingController.text,
              dueDateTextEditingController.text,
              isImportant)
          .then((value) {
        if (value != null) {
          Navigator.pop(context);
          _refresh();
          taskTaskEditingController.text = "";
          noteTextEditingController.text = "";
          dueDateTextEditingController.text = "";
          // dueTimeTextEditingController.text = "";
          isImportant = false;
        }
      });
    }
  }

  bool isImportant = false;
  void _addTaskDialog() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text(
              "Add Task",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            children: [
              Container(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(children: [
                  Form(
                    key: taskAddFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: taskTaskEditingController,
                          decoration: const InputDecoration(
                            labelText: "Task",
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Task is required";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: noteTextEditingController,
                          decoration: const InputDecoration(
                            labelText: "Note",
                          ),
                        ),
                        TextFormField(
                          controller: dueDateTextEditingController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.calendar_today),
                            labelText: "Due Date",
                          ),
                          readOnly: true,
                          onTap: () async {
                            _selectDate(context);
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Due Date is required";
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: dueTimeTextEditingController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.access_time),
                            labelText: "Due Time",
                          ),
                          readOnly: true,
                          onTap: () async {
                            _selectTime(context);
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Due Time is required";
                            }
                            return null;
                          },
                        ),
                        //important check true and unchecked false
                        CheckboxListTile(
                          title: const Text("Important"),
                          value: isImportant,
                          onChanged: (bool? value) {
                            print("Value $value");
                            print("Before $isImportant");

                            setState(() {
                              // isImportant = value!;
                            });
                            print("After: $isImportant");
                          },
                        ),

                        ElevatedButton(
                          onPressed: taskSubmit,
                          style:
                              ElevatedButton.styleFrom(primary: Colors.brown),
                          child: const Text(
                            "Add",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )
                ]),
              )
            ],
          );
        });
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
          children: [
            Expanded(
              child: Consumer<TaskService>(
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: value.tasks.length,
                    itemBuilder: ((context, index) {
                      return Text(
                        "${value.tasks[index].task}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      );
                    }),
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}



//
