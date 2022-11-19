import 'package:flutter/material.dart';
import 'package:taskido/configs/routes.dart';
import 'package:taskido/services/auth_services.dart';
import 'package:taskido/services/profile_service.dart';
import 'package:taskido/views/auth/profile_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF1a2f45),
        child: ListView(
          children: [
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
                      profileService.profileDetails.profilePicture.toString(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    profileService.profileDetails.user!.fullName.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: const Text(
                "Home",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(RouteGenerator.homePage);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: const Text("Profile",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(RouteGenerator.profilePage);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.check_circle,
                color: Colors.white,
              ),
              title: const Text(
                "Completed Tasks",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pushNamed(RouteGenerator.completeTasksPage);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.cancel,
                color: Colors.white,
              ),
              title: const Text(
                "Uncompleted Tasks",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pushNamed(RouteGenerator.unCompleteTasksPage);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.calendar_today,
                color: Colors.white,
              ),
              title: const Text(
                "Calendar",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                // Navigator.of(context)
                //     .pushNamed(RouteGenerator.calendarPage);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: const Text(
                "Logout",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed(RouteGenerator.loginPage);
                authService.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
