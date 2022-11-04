import 'package:flutter/material.dart';
import 'package:taskido/configs/routes.dart';
import 'package:taskido/services/auth_services.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool obsecureText = true;
  final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  TextEditingController fullnameTextEditingController = TextEditingController();
  TextEditingController phoneNumberTextEditingController =
      TextEditingController();

  void registerSubmit() async {
    if (signupFormKey.currentState!.validate()) {
      await authService
          .signup(
        phoneNumberTextEditingController.text,
        emailTextEditingController.text,
        fullnameTextEditingController.text,
        passwordTextEditingController.text,
        confirmPasswordTextEditingController.text,
      )
          .then((value) {
        print("++++------------------------+$value");
        if (value != null) {
          Navigator.of(context).pushNamed(RouteGenerator.otpPage);
          print("++++------------------------+$value");
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
            onPressed: () {
              Navigator.of(context).popAndPushNamed(RouteGenerator.welcomePage);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text(
            "Sign up",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: signupFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailTextEditingController,
                    decoration: const InputDecoration(
                      labelText: "Email",
                    ),
                  ),
                  TextFormField(
                    controller: phoneNumberTextEditingController,
                    decoration: const InputDecoration(
                      labelText: "Phone number",
                    ),
                  ),
                  TextFormField(
                    controller: fullnameTextEditingController,
                    decoration: const InputDecoration(
                      labelText: "Full name",
                    ),
                  ),
                  TextFormField(
                    obscureText: obsecureText,
                    controller: passwordTextEditingController,
                    decoration: const InputDecoration(
                      labelText: "Password",
                    ),
                  ),
                  TextFormField(
                    obscureText: obsecureText,
                    controller: confirmPasswordTextEditingController,
                    decoration: const InputDecoration(
                      labelText: "Password Confirm",
                    ),
                  ),
                  MaterialButton(
                    color: Colors.brown,
                    onPressed: registerSubmit,
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 7,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Already have an Account?",
                          style: TextStyle(),
                        ),
                        Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(RouteGenerator.otpPage);
                    },
                    child: const Text(
                      "OTP",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
