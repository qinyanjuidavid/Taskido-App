import 'package:flutter/material.dart';

class PasswordResetScreen extends StatefulWidget {
  PasswordResetScreen({Key? key}) : super(key: key);

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> passwordResetFormKey = GlobalKey<FormState>();
    TextEditingController passwordTextEditingController =
        TextEditingController();

    TextEditingController confirmPasswordTextEditingController =
        TextEditingController();
    bool obsecureText = true;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Password Reset",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
        ),
        body: Container(
          child: Form(
            key: passwordResetFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                    if (value.length < 6) {
                      return "password must be at least 6 characters";
                    }

                    return null;
                  },
                ),
                TextFormField(
                  obscureText: obsecureText,
                  controller: confirmPasswordTextEditingController,
                  decoration: const InputDecoration(
                    labelText: "Password Confirm",
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "password confirm is required";
                    }

                    if (value != passwordTextEditingController.text) {
                      return "password confirm must be equal to password";
                    }

                    return null;
                  },
                ),
                MaterialButton(
                  color: Colors.brown,
                  onPressed: () {},
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
