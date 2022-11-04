import 'package:flutter/material.dart';
import 'package:taskido/configs/routes.dart';

class WelcomScreen extends StatefulWidget {
  WelcomScreen({Key? key}) : super(key: key);

  @override
  State<WelcomScreen> createState() => _WelcomScreenState();
}

class _WelcomScreenState extends State<WelcomScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text(
        //     "Welcome",
        //     style: TextStyle(
        //       fontWeight: FontWeight.bold,
        //       fontSize: 30,
        //     ),
        //   ),
        // ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "roboto",
                fontSize: 24,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(RouteGenerator.loginPage);
                  },
                  color: Colors.brown,
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(RouteGenerator.signUpPage);
                  },
                  color: Colors.brown,
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
