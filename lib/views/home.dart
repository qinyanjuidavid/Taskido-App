import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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

  // void _logoutFnc() async {
  //   await authService.logout().then((value) {
  //     Navigator.of(context).pop(RouteGenerator.loginPage);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.black87,
        // .deepOrangeAccent,
        elevation: 20,
        titleSpacing: 20,
        // automaticallyImplyLeading: false,
        title: const Text(
          "Taskido",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              },
              icon: const Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // SizedBox(
            //   width: MediaQuery.of(context).size.width,
            //   height: 10,
            // ),

            // Container(
            //   margin: const EdgeInsets.only(left: 7, right: 7),
            //   height: 150,
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: InkWell(
            //           onTap: () {},
            //           child: Container(
            //             padding: const EdgeInsets.only(
            //               top: 18,
            //               left: 15,
            //             ),
            //             decoration: BoxDecoration(
            //               color: Colors.indigo,
            //               borderRadius: BorderRadius.circular(10),
            //               boxShadow: [
            //                 BoxShadow(
            //                   color: Colors.grey.withOpacity(0.5),
            //                   spreadRadius: 5,
            //                   blurRadius: 7,
            //                   offset: const Offset(0, 3),
            //                 ),
            //               ],
            //             ),
            //             child: Column(
            //               children: [
            //                 const SizedBox(
            //                   height: 10,
            //                 ),
            //                 Row(
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   children: const [
            //                     Text(
            //                       "27",
            //                       style: TextStyle(
            //                         color: Colors.white,
            //                         fontSize: 45,
            //                         fontWeight: FontWeight.bold,
            //                       ),
            //                     ),
            //                     SizedBox(
            //                       width: 5,
            //                     ),
            //                     Text(
            //                       "Tasks",
            //                       style: TextStyle(
            //                         color: Colors.white,
            //                         fontSize: 20,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 const SizedBox(
            //                   height: 3,
            //                 ),
            //                 Row(
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   children: const [
            //                     Flexible(
            //                       child: Text(
            //                         "Completed",
            //                         style: TextStyle(
            //                           color: Colors.white,
            //                           fontWeight: FontWeight.bold,
            //                           fontSize: 26,
            //                         ),
            //                         softWrap: false,
            //                         maxLines: 1,
            //                         overflow: TextOverflow.ellipsis,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //       //space the containers
            //       const SizedBox(
            //         width: 8,
            //       ),

            //       Expanded(
            //         child: InkWell(
            //           onTap: () {},
            //           child: Container(
            //             padding: const EdgeInsets.only(
            //               top: 18,
            //               left: 15,
            //             ),
            //             decoration: BoxDecoration(
            //               color: Colors.teal,
            //               borderRadius: BorderRadius.circular(10),
            //               boxShadow: [
            //                 BoxShadow(
            //                   color: Colors.grey.withOpacity(0.5),
            //                   spreadRadius: 5,
            //                   blurRadius: 7,
            //                   offset: const Offset(0, 3),
            //                 ),
            //               ],
            //             ),
            //             child: Column(
            //               children: [
            //                 const SizedBox(
            //                   height: 10,
            //                 ),
            //                 Row(
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   children: const [
            //                     Text(
            //                       "17",
            //                       style: TextStyle(
            //                         color: Colors.white,
            //                         fontSize: 45,
            //                         fontWeight: FontWeight.bold,
            //                       ),
            //                     ),
            //                     SizedBox(
            //                       width: 5,
            //                     ),
            //                     Text(
            //                       "Tasks",
            //                       style: TextStyle(
            //                         color: Colors.white,
            //                         fontSize: 20,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //                 const SizedBox(
            //                   height: 3,
            //                 ),
            //                 Row(
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   children: const [
            //                     Flexible(
            //                       child: Text(
            //                         "To complete",
            //                         style: TextStyle(
            //                           color: Colors.white,
            //                           fontWeight: FontWeight.bold,
            //                           fontSize: 26,
            //                         ),
            //                         softWrap: false,
            //                         maxLines: 1,
            //                         overflow: TextOverflow.ellipsis,
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 7,
            // ),
            // const Align(
            //   alignment: Alignment.centerLeft,
            //   child: Padding(
            //     padding: EdgeInsets.only(
            //       left: 10,
            //     ),
            //     child: Text(
            //       "Categories",
            //       style: TextStyle(
            //         fontWeight: FontWeight.w600,
            //         fontSize: 24,
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 2,
            // ),
            Expanded(
              child: Consumer<TaskService>(
                builder: (context, value, child) {
                  if (value.categoryLoading == true) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ListView.builder(
                    controller: value.scrollController,
                    itemCount: value.categories.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 120,
                        child: Text(
                            "${value.categories[index].id} - ${value.categories[index].category}"),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 60, 55, 255),
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
  }
}
