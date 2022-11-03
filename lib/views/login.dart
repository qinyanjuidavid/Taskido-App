import 'package:flutter/material.dart';
import 'package:taskido/configs/routes.dart';
import 'package:taskido/services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obsecureText = true;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  void loginSubmit() async {
    if (loginFormKey.currentState!.validate()) {
      await authService
          .login(emailTextEditingController.text,
              passwordTextEditingController.text)
          .then((value) {
        if (value) {
          print("Hello");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).popAndPushNamed(RouteGenerator.homePage);
            },
          ),
          title: const Text(
            "Login",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        body: Center(
          child: Form(
            key: loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: emailTextEditingController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                  ),
                ),
                TextFormField(
                  obscureText: obsecureText,
                  controller: passwordTextEditingController,
                  decoration: const InputDecoration(
                    labelText: "Password",
                  ),
                ),
                MaterialButton(
                  color: Colors.brown,
                  onPressed: () async {
                    print(emailTextEditingController.text);
                    print(passwordTextEditingController.text);
                    print(loginFormKey.currentState!.validate());
                    if (loginFormKey.currentState!.validate()) {
                      await authService
                          .login(emailTextEditingController.text,
                              passwordTextEditingController.text)
                          .then((value) {
                        if (value) {
                          print("hello");
                        }
                      });
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
