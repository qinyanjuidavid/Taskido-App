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
  TextEditingController phoneNumberTextEditingController =
      TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  void loginSubmit() async {
    if (loginFormKey.currentState!.validate()) {
      await authService
          .login(
        phoneNumberTextEditingController.text,
        passwordTextEditingController.text,
      )
          .then(
        (value) {
          if (value != null) {
            print(value);
            Navigator.of(context).pushNamed(RouteGenerator.homePage);
          }
        },
      );
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
              Navigator.of(context).popAndPushNamed(RouteGenerator.welcomePage);
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
                  controller: phoneNumberTextEditingController,
                  decoration: const InputDecoration(
                    labelText: "Phone number",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "phone is required";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: obsecureText,
                  controller: passwordTextEditingController,
                  decoration: const InputDecoration(
                    labelText: "Password",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "password is required";
                    }
                    return null;
                  },
                ),
                MaterialButton(
                  color: Colors.brown,
                  onPressed: loginSubmit,
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 7,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(RouteGenerator.signUpPage);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Don't have an account?",
                        ),
                        Text(
                          "Register",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 7,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteGenerator.homePage);
                  },
                  child: const Text(
                    "Categories",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
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
