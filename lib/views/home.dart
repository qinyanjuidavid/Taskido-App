import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskido/configs/routes.dart';
import 'package:taskido/data/models/category_models.dart';
import 'package:taskido/services/auth_services.dart';
import 'package:taskido/services/tasks_services.dart';
import 'package:taskido/views/auth/tasks_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> categoryAddFormKey = GlobalKey<FormState>();
  TextEditingController categoryTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refresh();
  }

// refresh
  Future<void> _refresh() async {
    await Provider.of<TaskService>(context, listen: false).fetchCategories();
  }

  void _addCategoryDialog() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text(
              "Add Category",
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
                child: Column(
                  children: [
                    Form(
                      key: categoryAddFormKey,
                      child: TextFormField(
                        controller: categoryTextEditingController,
                        decoration: const InputDecoration(
                          labelText: "Category",
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 15,
                    ),
                    MaterialButton(
                      color: Colors.brown,
                      onPressed: () {},
                      // _categorySubmit,
                      child: const Text(
                        "Add Category",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  // void _categorySubmit() async {
  //   if (categoryAddFormKey.currentState!.validate()) {
  //     await taskService
  //         .addCategory(
  //       categoryTextEditingController.text,
  //     )
  //         .then(
  //       (value) {
  //         if (value != null) {
  //           Navigator.pop(context);
  //           _refresh();
  //           categoryTextEditingController.text = "";
  //         }
  //       },
  //     );
  //   }
  // }

  void _logoutFnc() async {
    await authService.logout().then((value) {
      Navigator.of(context).pop(RouteGenerator.loginPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Taskido"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 10,
            ),
            child: IconButton(
              iconSize: 30,
              onPressed: _logoutFnc,
              icon: const Icon(
                Icons.logout,
                // size: 10,
              ),
            ),
          )
        ],
      ),
      body: Text("Category"),
      // body: RefreshIndicator(
      //   onRefresh: _refresh,
      //   child: Consumer<TaskService>(
      //     builder: (BuildContext context, value, child) {
      //       return ListView.builder(
      //         itemCount: value.categories.length,
      //         itemBuilder: ((context, index) {
      //           return GestureDetector(
      //             onTap: () {
      //               // Navigator.of(context)
      //               //     .push(MaterialPageRoute(builder: (context) {
      //               //   return TasksScreen(category: value.categories[index]);
      //               // }));
      //             },
      //             child: const Text(
      //               "Category",
      //               // "${value.categories[index].category}",
      //               style: TextStyle(
      //                 fontWeight: FontWeight.bold,
      //                 fontSize: 24,
      //               ),
      //             ),
      //           );
      //         }),
      //       );
      //     },
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCategoryDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
