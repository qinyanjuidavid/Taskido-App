import 'package:flutter/material.dart';
import 'package:taskido/configs/routes.dart';
import 'package:taskido/services/auth_services.dart';
import 'package:taskido/views/auth/profile_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF1a2f45),
        child: Column(
          children: [
            //profile image
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.blueGrey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1616166330073-8b8b2b2b2b1a?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "John Doe",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    // child: Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 20),
    //   child: Column(
    //     children: [
    //       Expanded(
    //         child: ListView(
    //           children: [
    //             ListTile(
    //               title: Text("Home"),
    //               onTap: () {
    //                 Navigator.of(context).pushNamed(RouteGenerator.homePage);
    //               },
    //             ),
    //             ListTile(
    //               title: Text("Profile"),
    //               onTap: () {
    //                 Navigator.of(context)
    //                     .pushNamed(RouteGenerator.profilePage);
    //               },
    //             ),
    //             ListTile(
    //               title: Text("Logout"),
    //               onTap: () {
    //                 logoutFunc(context);
    //                 Navigator.of(context).pop(RouteGenerator.loginPage);
    //               },
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // ),
  }
}
