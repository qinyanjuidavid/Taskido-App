import 'package:flutter/material.dart';
import 'package:taskido/configs/routes.dart';
import 'package:taskido/services/auth_services.dart';
import 'package:taskido/views/auth/profile_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text("Home"),
                    onTap: () {
                      Navigator.of(context).pushNamed(RouteGenerator.homePage);
                    },
                  ),
                  ListTile(
                    title: Text("Profile"),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RouteGenerator.profilePage);
                    },
                  ),
                  ListTile(
                    title: Text("Logout"),
                    onTap: () {
                      logoutFunc(context);
                      Navigator.of(context).pop(RouteGenerator.loginPage);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
