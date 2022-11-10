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
    // _refresh();
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

  // void _logoutFnc() async {
  //   await authService.logout().then((value) {
  //     Navigator.of(context).pop(RouteGenerator.loginPage);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // create category map
    var infor = [
      {"name": "Home", "icon": Icons.home, "color": Colors.blue, "id": 1},
      {"name": "Work", "icon": Icons.work, "color": Colors.red, "id": 2},
      {"name": "School", "icon": Icons.school, "color": Colors.green, "id": 3},
      {
        "name": "Shopping",
        "icon": Icons.shopping_cart,
        "color": Colors.purple,
        "id": 4
      },
      {
        "name": "Others",
        "icon": Icons.more_horiz,
        "color": Colors.grey,
        "id": 5
      },
      {
        "name": "Others",
        "icon": Icons.more_horiz,
        "color": Colors.grey,
        "id": 5
      },
    ];
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 20,
        titleSpacing: 20,
        automaticallyImplyLeading: false,
        title: const Text(
          "Taskido",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
          ),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(
        //       right: 20,
        //     ),
        //     child: IconButton(
        //       onPressed: () {
        //         showSearch(context: context, delegate: DataSearch());
        //       },
        //       icon: const Icon(Icons.search),
        //     ),
        //   )
        // ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(28),
          child: Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 0,
                  ),
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      showSearch(context: context, delegate: DataSearch());
                    },
                    icon: const Icon(Icons.search),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 7,
          ),
          Container(
            margin: const EdgeInsets.only(left: 7, right: 7),
            height: 150,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 18,
                      left: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "27",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Tasks",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Flexible(
                              child: Text(
                                "Completed",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                                softWrap: false,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                //space the containers
                const SizedBox(
                  width: 8,
                ),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 18,
                      left: 15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "17",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Tasks",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Flexible(
                              child: Text(
                                "To complete",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                                softWrap: false,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // category to be in a List builder with a row of 2 containers
          Expanded(
            child: ListView.builder(
              // split the list into 2
              itemCount: (infor.length / 2).ceil(),
              itemBuilder: (context, index) {
                int firstIndex = index * 2;
                int secondIndex = firstIndex + 1;
                return Container(
                  height: 180,
                  margin: const EdgeInsets.only(left: 7, right: 7),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(
                            top: 18,
                            left: 15,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    infor[firstIndex]["name"].toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    "Tasks",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      infor[firstIndex + 1]["id"].toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        // 24,
                                      ),
                                      softWrap: false,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(
                            top: 18,
                            left: 15,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.pink,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    infor[secondIndex]["name"].toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      // 45,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Text(
                                    "Tasks",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      infor[secondIndex + 1]["id"].toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                      softWrap: false,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
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
