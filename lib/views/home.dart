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
      {
        "name": "Home",
        "icon": Icons.home,
        "color": Colors.blue,
        "id": 1,
        "date": "2021-09-01 00:00:00"
      },
      {
        "name": "Work",
        "icon": Icons.work,
        "color": Colors.red,
        "id": 2,
        "date": "2021-09-01 00:00:00"
      },
      {
        "name": "School",
        "icon": Icons.school,
        "color": Colors.green,
        "id": 3,
        "date": "2021-09-01 00:00:00"
      },
      {
        "name": "Shopping",
        "icon": Icons.shopping_cart,
        "color": Colors.purple,
        "id": 4,
        "date": "2021-09-01 00:00:00"
      },
      {
        "name": "Personal",
        "icon": Icons.person,
        "color": Colors.orange,
        "id": 5,
        "date": "2021-09-01 00:00:00"
      },
      {
        "name": "Other",
        "icon": Icons.more_horiz,
        "color": Colors.grey,
        "id": 6,
        "date": "2021-09-01 00:00:00"
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
        mainAxisAlignment: MainAxisAlignment.start,
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
          const SizedBox(
            height: 5,
          ),

          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 10,
              ),
              child: Text(
                "Categories",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),

          // category to be in grid view

          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 7, right: 7),
              child: GridView.builder(
                itemCount: infor.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: infor[index]["color"] as Color,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.only(
                        top: 1,
                        left: 5,
                        right: 5,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              //row of name of task and the date created at the end of the row
                              Text(
                                infor[index]["name"] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              //date to be in a white container in the format of 20th then Oct
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "20",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Oct",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        focusColor: Colors.amber,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    ));
  }
}
