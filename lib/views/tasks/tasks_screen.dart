import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taskido/data/models/category_models.dart';
import 'package:taskido/services/tasks_services.dart';

class TasksScreen extends StatefulWidget {
  final Result category;
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

  // @override
  // void initState() {
  //   super.initState();
  //   _refresh();
  //   categoryTextUpdateController.text = widget.category.category!;
  // }

  // _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2027),
  //   );
  //   if (picked != null) {
  //     String formatedDate = DateFormat("yyyy-MM-dd").format(picked);
  //     dueDateTextEditingController.text = formatedDate.toString();
  //   }
  // }

  // _selectTime(BuildContext context) async {
  //   final TimeOfDay? pickedTime = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   );
  //   if (pickedTime != null) {
  //     // print("picked ${pickedTime.format(context)}");
  //     final now = DateTime.now();
  //     DateTime convertedDateTime = DateTime(
  //       now.year,
  //       now.month,
  //       now.day,
  //       pickedTime.hour,
  //       pickedTime.minute,
  //     );
  //     String formatedTime = DateFormat("HH:mm:ss").format(convertedDateTime);
  //     dueTimeTextEditingController.text = formatedTime.toString();
  //   }
  // }

  // Future<void> _refresh() async {
  //   await Provider.of<TaskService>(context, listen: false)
  //       .fetchCategoryDetails(widget.category.id);
  //   await Provider.of<TaskService>(context, listen: false).fetchCategories();
  //   Future.delayed(
  //     Duration(milliseconds: 0),
  //     (() => taskService.fetchTasks(widget.category.id)),
  //   );
  // }

  // void categoryUpdateFnc() async {
  //   if (categoryUpdateKey.currentState!.validate()) {
  //     await taskService
  //         .updateCategory(widget.category.id, categoryTextUpdateController.text)
  //         .then((value) async {
  //       if (value != null) {
  //         Navigator.pop(context);
  //         _refresh();
  //       }
  //     });
  //   }
  // }

  // void taskSubmit() async {
  //   if (taskAddFormKey.currentState!.validate()) {
  //     // Due date is dueDateTextEditingController.text + dueTimeTextEditingController.text
  //     var dueDate =
  //         "${dueDateTextEditingController.text} ${dueTimeTextEditingController.text}";
  //     print("Due Date $dueDate");
  //     await taskService
  //         .addTask(taskTaskEditingController.text, widget.category.id,
  //             noteTextEditingController.text, dueDate, isImportant)
  //         .then((value) {
  //       if (value != null) {
  //         Navigator.pop(context);
  //         _refresh();
  //         taskTaskEditingController.text = "";
  //         noteTextEditingController.text = "";
  //         dueDateTextEditingController.text = "";
  //         dueTimeTextEditingController.text = "";
  //         isImportant = false;
  //       }
  //     });
  //   }
  // }

  // final GlobalKey<FormState> categoryUpdateKey = GlobalKey<FormState>();
  // TextEditingController categoryTextUpdateController = TextEditingController();
  // void _updateCategoryDialog() async {
  //   await showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return SimpleDialog(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           title: const Text(
  //             "Update Category",
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontWeight: FontWeight.w600,
  //               fontSize: 20,
  //             ),
  //           ),
  //           children: [
  //             Container(
  //               padding: const EdgeInsets.only(
  //                 left: 20,
  //                 right: 20,
  //               ),
  //               child: Form(
  //                 key: categoryUpdateKey,
  //                 child: Column(
  //                   children: [
  //                     TextFormField(
  //                       controller: categoryTextUpdateController,
  //                       decoration: const InputDecoration(
  //                         labelText: "Category",
  //                       ),
  //                       validator: (String? value) {
  //                         if (value == null || value.isEmpty) {
  //                           return "Task is required";
  //                         }
  //                         return null;
  //                       },
  //                     ),
  //                     SizedBox(
  //                       width: MediaQuery.of(context).size.width,
  //                       height: 10,
  //                     ),
  //                     MaterialButton(
  //                       color: Colors.brown,
  //                       onPressed: categoryUpdateFnc,
  //                       child: const Text(
  //                         "Update",
  //                         style: TextStyle(
  //                           color: Colors.white,
  //                         ),
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         );
  //       });
  // }

  // bool isImportant = false;
  // void _addTaskDialog() async {
  //   await showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return SimpleDialog(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           title: const Text(
  //             "Add Task",
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontWeight: FontWeight.w600,
  //               fontSize: 20,
  //             ),
  //           ),
  //           children: [
  //             Container(
  //               padding: const EdgeInsets.only(
  //                 left: 20,
  //                 right: 20,
  //               ),
  //               child: Column(children: [
  //                 Form(
  //                   key: taskAddFormKey,
  //                   child: Column(
  //                     children: [
  //                       TextFormField(
  //                         controller: taskTaskEditingController,
  //                         decoration: const InputDecoration(
  //                           labelText: "Task",
  //                         ),
  //                         validator: (String? value) {
  //                           if (value == null || value.isEmpty) {
  //                             return "Task is required";
  //                           }
  //                           return null;
  //                         },
  //                       ),
  //                       TextFormField(
  //                         controller: noteTextEditingController,
  //                         decoration: const InputDecoration(
  //                           labelText: "Note",
  //                         ),
  //                       ),
  //                       TextFormField(
  //                         controller: dueDateTextEditingController,
  //                         decoration: const InputDecoration(
  //                           icon: Icon(Icons.calendar_today),
  //                           labelText: "Due Date",
  //                         ),
  //                         readOnly: true,
  //                         onTap: () async {
  //                           _selectDate(context);
  //                         },
  //                         validator: (String? value) {
  //                           if (value == null || value.isEmpty) {
  //                             return "Due Date is required";
  //                           }
  //                           return null;
  //                         },
  //                       ),
  //                       TextFormField(
  //                         controller: dueTimeTextEditingController,
  //                         decoration: const InputDecoration(
  //                           icon: Icon(Icons.access_time),
  //                           labelText: "Due Time",
  //                         ),
  //                         readOnly: true,
  //                         onTap: () async {
  //                           _selectTime(context);
  //                         },
  //                         validator: (String? value) {
  //                           if (value == null || value.isEmpty) {
  //                             return "Due Time is required";
  //                           }
  //                           return null;
  //                         },
  //                       ),
  //                       //important check true and unchecked false
  //                       CheckboxListTile(
  //                         title: const Text("Important"),
  //                         value: isImportant,
  //                         onChanged: (bool? value) {
  //                           print("Value $value");
  //                           print("Before $isImportant");

  //                           setState(() {
  //                             isImportant = value!;
  //                           });
  //                           print("After: $isImportant");
  //                         },
  //                       ),

  //                       ElevatedButton(
  //                         onPressed: taskSubmit,
  //                         style:
  //                             ElevatedButton.styleFrom(primary: Colors.brown),
  //                         child: const Text(
  //                           "Add Task",
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 )
  //               ]),
  //             )
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Text("Tasks"),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Consumer<TaskService>(
    //       builder: (context, value, child) {
    //         //flatten list with single map

    //         return Text(
    //           "${value.categoryDetails.category}",
    //           style: const TextStyle(
    //             color: Colors.white,
    //             fontWeight: FontWeight.w600,
    //             fontSize: 20,
    //           ),
    //         );
    //         // return Text("${widget.category.category}");
    //       },
    //     ),
    //     actions: [
    //       Padding(
    //         padding: const EdgeInsets.only(
    //           right: 10,
    //         ),
    //         child: IconButton(
    //           iconSize: 30,
    //           onPressed: _updateCategoryDialog,
    //           icon: const Icon(
    //             Icons.edit_note,
    //             // size: 10,
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    //   body: RefreshIndicator(
    //     onRefresh: _refresh,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       children: [
    //         Expanded(
    //           child: Consumer<TaskService>(
    //             builder: (context, value, child) {
    //               return ListView.builder(
    //                 itemCount: value.tasks.length,
    //                 itemBuilder: ((context, index) {
    //                   return Text(
    //                     "${value.tasks[index].task}",
    //                     style: const TextStyle(
    //                       fontWeight: FontWeight.bold,
    //                       fontSize: 24,
    //                     ),
    //                   );
    //                 }),
    //               );
    //             },
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: _addTaskDialog,
    //     child: const Icon(Icons.add),
    //   ),
    // );
  }
}

//
