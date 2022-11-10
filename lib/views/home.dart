import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskido/configs/routes.dart';
import 'package:taskido/data/data_search.dart';
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
// set scroll listener

// refresh
  Future<void> _refresh() async {
    await Provider.of<TaskService>(context, listen: false).fetchCategories();
    await Provider.of<TaskService>(context, listen: false)
        .setScrollController();
  }

  // void _addCategoryDialog() async {
  //   await showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return SimpleDialog(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //           title: const Text(
  //             "Add Category",
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
  //               child: Column(
  //                 children: [
  //                   Form(
  //                     key: categoryAddFormKey,
  //                     child: TextFormField(
  //                       controller: categoryTextEditingController,
  //                       decoration: const InputDecoration(
  //                         labelText: "Category",
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     width: MediaQuery.of(context).size.width,
  //                     height: 15,
  //                   ),
  //                   MaterialButton(
  //                     color: Colors.brown,
  //                     onPressed: () {},
  //                     // _categorySubmit,
  //                     child: const Text(
  //                       "Add Category",
  //                       style: TextStyle(
  //                         fontWeight: FontWeight.bold,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             )
  //           ],
  //         );
  //       });
  // }

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
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(7, 94, 84, 1),
        elevation: 10,
        titleSpacing: 20,
        automaticallyImplyLeading: false,
        title: const Text(
          "Taskido",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
    ));

    // Scaffold(
    //   appBar: AppBar(
    //     title: Text("Taskido"),
    //     actions: [
    //       Padding(
    //         padding: const EdgeInsets.only(
    //           right: 10,
    //         ),
    //         child: IconButton(
    //           iconSize: 30,
    //           onPressed: _logoutFnc,
    //           icon: const Icon(
    //             Icons.logout,
    //             // size: 10,
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    //   //implement categories with pagination
    //   body: RefreshIndicator(
    //     onRefresh: _refresh,
    //     child: Consumer<TaskService>(
    //       builder: (context, value, child) {
    //         if (value.categoryLoading == true) {
    //           return const Center(
    //             child: Padding(
    //               padding: EdgeInsets.all(8),
    //               child: CircularProgressIndicator(),
    //             ),
    //           );
    //         } else {
    //           return ListView.builder(
    //             controller: value.scrollController,
    //             itemCount: value.categories.length,
    //             itemBuilder: (context, index) {
    //               return ListTile(
    //                 onTap: () {},
    //                 title: Text(
    //                   value.categories[index].category.toString(),
    //                   style: const TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 60,
    //                   ),
    //                 ),
    //                 trailing: IconButton(
    //                   onPressed: () {},
    //                   icon: const Icon(
    //                     Icons.delete,
    //                     color: Colors.red,
    //                   ),
    //                 ),
    //               );
    //             },
    //           );
    //         }
    //       },
    //     ),
    //   ),
    //   // body: RefreshIndicator(
    //   //   onRefresh: _refresh,
    //   //   child: Consumer<TaskService>(
    //   //     builder: (BuildContext context, value, child) {
    //   //       return ListView.builder(
    //   //         itemCount: value.categories.length,
    //   //         itemBuilder: ((context, index) {
    //   //           return GestureDetector(
    //   //             onTap: () {
    //   //               // Navigator.of(context)
    //   //               //     .push(MaterialPageRoute(builder: (context) {
    //   //               //   return TasksScreen(category: value.categories[index]);
    //   //               // }));
    //   //             },
    //   //             child: const Text(
    //   //               "Category",
    //   //               // "${value.categories[index].category}",
    //   //               style: TextStyle(
    //   //                 fontWeight: FontWeight.bold,
    //   //                 fontSize: 24,
    //   //               ),
    //   //             ),
    //   //           );
    //   //         }),
    //   //       );
    //   //     },
    //   //   ),
    //   // ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {},
    //     //  _addCategoryDialog,
    //     child: const Icon(Icons.add),
    //   ),
    // );
  }
}
