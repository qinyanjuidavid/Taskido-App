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
                  controller: emailTextEditingController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                  ),
                  validator: (val) {
                    if (val != null) {
                      return "Email field can not be empty.";
                    }
                  },
                ),
                TextFormField(
                  obscureText: obsecureText,
                  controller: passwordTextEditingController,
                  decoration: const InputDecoration(
                    labelText: "Password",
                  ),
                  validator: (val) {
                    if (val != null) {
                      return "Password field can not be empty.";
                    }
                  },
                ),
                MaterialButton(
                  color: Colors.brown,
                  onPressed: () async {
                    if (loginFormKey.currentState!.validate()) {
                      await authService
                          .login(
                        emailTextEditingController.text,
                        passwordTextEditingController.text,
                      )
                          .then(
                        (value) {
                          if (value != null) {
                            print(value);
                            Navigator.of(context)
                                .pushNamed(RouteGenerator.homePage);
                          }
                        },
                      );
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 5,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
