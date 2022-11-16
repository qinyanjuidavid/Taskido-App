import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:taskido/configs/routes.dart';
import 'package:taskido/data/data_search.dart';
import 'package:taskido/data/models/category_models.dart';
import 'package:taskido/services/auth_services.dart';
import 'package:taskido/services/tasks_services.dart';
import 'package:taskido/widgets/buttons/auth_button.dart';
import 'package:taskido/widgets/category/category_add_bottomsheet.dart';
import 'package:taskido/widgets/category/category_container.dart';
import 'package:taskido/widgets/inputs/text_field_with_label.dart';

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

  void _categorySubmit() async {
    print("Valide:::: ${categoryAddFormKey.currentState!.validate()}");

    if (categoryAddFormKey.currentState!.validate()) {
      await taskService
          .addCategory(
        categoryTextEditingController.text,
        "#2312FF",
      )
          .then(
        (value) {
          print("Value:::: $value");
          if (value != null) {
            Navigator.pop(context);
            _refresh();
            categoryTextEditingController.text = "";
          }
        },
      );
    }
  }

  void _logoutFnc() async {
    await authService.logout().then((value) {
      Navigator.of(context).pop(RouteGenerator.loginPage);
    });
  }

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
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 7, right: 7),
                height: 150,
                child: Row(
                  children: const [
                    CompleteAndUncompleteContainerWidget(
                      title: "Complete",
                      color: Colors.indigo,
                      numberOfTasks: "27",
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    CompleteAndUncompleteContainerWidget(
                      title: "To complete",
                      color: Colors.teal,
                      numberOfTasks: "13",
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 7,
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
                height: 2,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 7, right: 7, top: 5),
                  child: Consumer<TaskService>(
                    builder: (context, value, child) {
                      if (value.categoryLoading == true) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return GridView.builder(
                        controller: value.scrollController,
                        itemCount: value.categories.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.1,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 12,
                        ),
                        itemBuilder: (context, index) {
                          var clr = value.categories[index].color.toString();
                          var categoryColor = Color(
                              int.parse(clr.substring(1, 7), radix: 16) +
                                  0xFF000000);

                          return InkWell(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: categoryColor,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.only(
                                top: 10,
                                left: 10,
                                right: 20,
                                bottom: 12,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          value.categories[index].category
                                              .toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "2 weeks ago",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          //number of tasks completed of all eg 2 of 5
                                          Row(
                                            children: const [
                                              Text(
                                                "3",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                " of ",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "4",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          // at the end of the row
                                          const Spacer(),
                                          // normal circular progress indicator
                                          const CircularProgressIndicator(
                                            value: 0.45,
                                            backgroundColor: Colors.white70,
                                            strokeWidth: 5,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 60, 55, 255),
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return CategoryBottomSheet(
                  categoryAddForm: Form(
                    key: categoryAddFormKey,
                    child: Column(
                      children: [
                        TextFieldWithLabel(
                          title: "Category",
                          controller: categoryTextEditingController,
                          hintText: "Enter category",
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter category";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AuthButton(
                          onPressed: _categorySubmit,
                          child: Consumer<TaskService>(
                            builder: (context, value, child) {
                              return value.addCategoryLoading == true
                                  ? const Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(0),
                                        child: CircularProgressIndicator(
                                          color: Colors.orange,
                                        ),
                                      ),
                                    )
                                  : const Text(
                                      "Submit",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
            // ////////
          },
          child: Icon(Icons.add),
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
