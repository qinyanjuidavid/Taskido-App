import 'package:flutter/material.dart';
import 'package:taskido/configs/routes.dart';
import 'package:taskido/services/auth_services.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _logoutFnc() async {
      await authService.logout().then((value) {
        Navigator.of(context).pop(RouteGenerator.loginPage);
      });
    }

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
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Profile"),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Logout"),
                    onTap: () {
                      _logoutFnc();
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
